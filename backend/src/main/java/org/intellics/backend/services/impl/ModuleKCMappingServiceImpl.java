package org.intellics.backend.services.impl;

import lombok.extern.slf4j.Slf4j;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import org.intellics.backend.api.error.exceptions.ItemNotFoundException;
import org.intellics.backend.domain.dto.ModuleKCMappingDto;
import org.intellics.backend.domain.dto.ModuleKCMappingPatchDto;
import org.intellics.backend.domain.entities.KnowledgeComponent;
import org.intellics.backend.domain.entities.Module;
import org.intellics.backend.domain.entities.ModuleKCMapping;
import org.intellics.backend.domain.entities.ModuleKCMappingId;
import org.intellics.backend.mappers.Mapper;
import org.intellics.backend.repositories.KnowledgeComponentRepository;
import org.intellics.backend.repositories.ModuleKCMappingRepository;
import org.intellics.backend.repositories.ModuleRepository;
import org.intellics.backend.services.ModuleKCMappingService;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class ModuleKCMappingServiceImpl implements ModuleKCMappingService {

    private final ModuleKCMappingRepository moduleKCMappingRepository;
    private final ModuleRepository moduleRepository;
    private final KnowledgeComponentRepository knowledgeComponentRepository;
    private final Mapper<ModuleKCMappingDto, ModuleKCMapping> moduleKCMappingMapper;

    public ModuleKCMappingServiceImpl(ModuleKCMappingRepository moduleKCMappingRepository,
                                      ModuleRepository moduleRepository,
                                      KnowledgeComponentRepository knowledgeComponentRepository,
                                      Mapper<ModuleKCMappingDto, ModuleKCMapping> moduleKCMappingMapper) {
        this.moduleKCMappingRepository = moduleKCMappingRepository;
        this.moduleRepository = moduleRepository;
        this.knowledgeComponentRepository = knowledgeComponentRepository;
        this.moduleKCMappingMapper = moduleKCMappingMapper;
    }

    @Override
    public ModuleKCMappingDto createModuleKCMapping(ModuleKCMappingDto moduleKCMappingDto) {
        Module module = moduleRepository.findById(moduleKCMappingDto.getModuleId())
                .orElseThrow(() -> new ItemNotFoundException("Module not found"));
        KnowledgeComponent kc = knowledgeComponentRepository.findById(moduleKCMappingDto.getKcId())
                .orElseThrow(() -> new ItemNotFoundException("Knowledge Component not found"));

        ModuleKCMappingId mappingId = ModuleKCMappingId.builder()
                .moduleId(moduleKCMappingDto.getModuleId())
                .kcId(moduleKCMappingDto.getKcId())
                .build();

        // Check for existing mapping
        if (moduleKCMappingRepository.existsById(mappingId)) {
            throw new IllegalArgumentException("Mapping for this Module and Knowledge Component already exists. Use PATCH to update.");
        }

        ModuleKCMapping moduleKCMapping = ModuleKCMapping.builder()
                .mappingId(mappingId)
                .module(module)
                .knowledgeComponent(kc)
                .prerequisiteKnowledgeComponents(new HashSet<>())
                .build();

        if (moduleKCMappingDto.getPrerequisiteKcIds() != null && !moduleKCMappingDto.getPrerequisiteKcIds().isEmpty()) {
            // Fetch all prerequisite KCs in a single batch
            java.util.Map<UUID, KnowledgeComponent> prerequisiteKcMap = knowledgeComponentRepository.findAllById(moduleKCMappingDto.getPrerequisiteKcIds())
                    .stream()
                    .collect(Collectors.toMap(KnowledgeComponent::getKc_id, val -> val));

            // Build current graph for cycle detection
            List<ModuleKCMapping> existingMappings = moduleKCMappingRepository.findByModule(module);
            Map<UUID, Set<UUID>> adjList = buildAdjacencyList(existingMappings);

            for (UUID prerequisiteKcId : moduleKCMappingDto.getPrerequisiteKcIds()) {
                if (kc.getKc_id().equals(prerequisiteKcId)) {
                    throw new IllegalArgumentException("A knowledge component cannot be its own prerequisite.");
                }
                KnowledgeComponent prerequisiteKc = prerequisiteKcMap.get(prerequisiteKcId);
                if (prerequisiteKc == null) {
                    throw new ItemNotFoundException("Prerequisite Knowledge Component not found: " + prerequisiteKcId);
                }

                // Temporarily add the new edge for cycle detection
                adjList.computeIfAbsent(kc.getKc_id(), k -> new HashSet<>()).add(prerequisiteKcId);

                if (hasCycle(moduleKCMappingDto.getModuleId(), kc.getKc_id(), prerequisiteKcId, adjList)) {
                    throw new IllegalArgumentException("Adding this prerequisite would create a circular dependency for KC: " + kc.getKc_name());
                }
                moduleKCMapping.getPrerequisiteKnowledgeComponents().add(prerequisiteKc);
            }
        }

        ModuleKCMapping savedMapping = moduleKCMappingRepository.save(moduleKCMapping);
        return moduleKCMappingMapper.mapTo(savedMapping);
    }

    @Override
    public List<ModuleKCMappingDto> findAll() {
        return StreamSupport.stream(moduleKCMappingRepository.findAll().spliterator(), false)
                .map(moduleKCMappingMapper::mapTo)
                .collect(Collectors.toList());
    }

    @Override
    public Optional<ModuleKCMappingDto> findOne(UUID moduleId, UUID kcId) {
        ModuleKCMappingId mappingId = ModuleKCMappingId.builder()
                .moduleId(moduleId)
                .kcId(kcId)
                .build();
        return moduleKCMappingRepository.findById(mappingId).map(moduleKCMappingMapper::mapTo);
    }

    @Override
    public void delete(UUID moduleId, UUID kcId) {
        ModuleKCMappingId mappingId = ModuleKCMappingId.builder()
                .moduleId(moduleId)
                .kcId(kcId)
                .build();
        if (!moduleKCMappingRepository.existsById(mappingId)) {
            throw new ItemNotFoundException("Module-KC mapping not found");
        }
        
        Module module = moduleRepository.findById(moduleId)
                .orElseThrow(() -> new ItemNotFoundException("Module not found"));
        
        // Get all KC mappings in this module
        List<ModuleKCMapping> allMappingsInModule = moduleKCMappingRepository.findByModule(module);
        
        // Step 1: Remove the KC being deleted from prerequisites of other KCs
        for (ModuleKCMapping mapping : allMappingsInModule) {
            if (mapping.getPrerequisiteKnowledgeComponents() != null) {
                boolean wasModified = mapping.getPrerequisiteKnowledgeComponents().removeIf(
                    prerequisite -> prerequisite.getKc_id().equals(kcId)
                );
                if (wasModified) {
                    // Save the updated mapping if it was modified
                    moduleKCMappingRepository.save(mapping);
                }
            }
        }
        
        // Step 2: Clear all prerequisites of the KC being deleted (since it's being removed from the module)
        ModuleKCMapping kcToDelete = moduleKCMappingRepository.findById(mappingId).orElse(null);
        if (kcToDelete != null && kcToDelete.getPrerequisiteKnowledgeComponents() != null && 
            !kcToDelete.getPrerequisiteKnowledgeComponents().isEmpty()) {
            kcToDelete.getPrerequisiteKnowledgeComponents().clear();
            moduleKCMappingRepository.save(kcToDelete);
        }
        
        // Step 3: Delete the mapping record (this will cascade delete prerequisite relationships due to ON DELETE CASCADE)
        moduleKCMappingRepository.deleteById(mappingId);
    }

    @Override
    public boolean isExists(UUID moduleId, UUID kcId) {
        ModuleKCMappingId mappingId = ModuleKCMappingId.builder()
                .moduleId(moduleId)
                .kcId(kcId)
                .build();
        return moduleKCMappingRepository.existsById(mappingId);
    }

    @Override
    public ModuleKCMappingDto patchModuleKCMapping(UUID moduleId, UUID kcId, ModuleKCMappingPatchDto patchDto) {
        ModuleKCMappingId mappingId = ModuleKCMappingId.builder()
                .moduleId(moduleId)
                .kcId(kcId)
                .build();

        ModuleKCMapping existingMapping = moduleKCMappingRepository.findById(mappingId)
                .orElseThrow(() -> new ItemNotFoundException("Module-KC mapping not found"));

        // Clear existing prerequisites
        existingMapping.getPrerequisiteKnowledgeComponents().clear();

        if (patchDto.getPrerequisiteKcIds() != null && !patchDto.getPrerequisiteKcIds().isEmpty()) {
            // Build current graph for cycle detection (excluding the KC being patched for its own prerequisites)
            List<ModuleKCMapping> allMappings = moduleKCMappingRepository.findByModule(existingMapping.getModule());
            Map<UUID, Set<UUID>> adjList = buildAdjacencyList(allMappings);

            for (UUID prerequisiteKcId : patchDto.getPrerequisiteKcIds()) {
                if (kcId.equals(prerequisiteKcId)) {
                    throw new IllegalArgumentException("A knowledge component cannot be its own prerequisite.");
                }
                KnowledgeComponent prerequisiteKc = knowledgeComponentRepository.findById(prerequisiteKcId)
                        .orElseThrow(() -> new ItemNotFoundException("Prerequisite Knowledge Component not found: " + prerequisiteKcId));

                // Temporarily add the new edge for cycle detection
                adjList.computeIfAbsent(kcId, k -> new HashSet<>()).add(prerequisiteKcId);

                if (hasCycle(moduleId, kcId, prerequisiteKcId, adjList)) {
                    throw new IllegalArgumentException("Adding this prerequisite would create a circular dependency for KC: " + existingMapping.getKnowledgeComponent().getKc_name());
                }
                existingMapping.getPrerequisiteKnowledgeComponents().add(prerequisiteKc);
            }
        }

        ModuleKCMapping updatedMapping = moduleKCMappingRepository.save(existingMapping);
        return moduleKCMappingMapper.mapTo(updatedMapping);
    }

    // Helper method to build adjacency list from existing mappings
    private Map<UUID, Set<UUID>> buildAdjacencyList(List<ModuleKCMapping> mappings) {
        Map<UUID, Set<UUID>> adjList = new HashMap<>();
        for (ModuleKCMapping mapping : mappings) {
            UUID kcId = mapping.getKnowledgeComponent().getKc_id();
            for (KnowledgeComponent prerequisite : mapping.getPrerequisiteKnowledgeComponents()) {
                adjList.computeIfAbsent(kcId, k -> new HashSet<>()).add(prerequisite.getKc_id());
            }
        }
        return adjList;
    }

    // Helper method for cycle detection using DFS
    private boolean hasCycle(UUID moduleId, UUID startKcId, UUID targetKcId, Map<UUID, Set<UUID>> adjList) {
        Set<UUID> visited = new HashSet<>();
        Set<UUID> recursionStack = new HashSet<>();
        return dfs(targetKcId, startKcId, visited, recursionStack, adjList);
    }

    private boolean dfs(UUID currentKcId, UUID targetKcId, Set<UUID> visited, Set<UUID> recursionStack, Map<UUID, Set<UUID>> adjList) {
        visited.add(currentKcId);
        recursionStack.add(currentKcId);

        // If we found the target KC in the current path, it means a cycle exists
        if (currentKcId.equals(targetKcId)) {
            return true;
        }

        Set<UUID> prerequisites = adjList.getOrDefault(currentKcId, java.util.Collections.emptySet());
        for (UUID prerequisiteKcId : prerequisites) {
            if (!visited.contains(prerequisiteKcId)) {
                if (dfs(prerequisiteKcId, targetKcId, visited, recursionStack, adjList)) {
                    return true;
                }
            } else if (recursionStack.contains(prerequisiteKcId)) {
                // Back-edge detected, means a cycle
                return true;
            }
        }

        recursionStack.remove(currentKcId);
        return false;
    }
}
