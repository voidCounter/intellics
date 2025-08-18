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
import org.intellics.backend.domain.dto.PrerequisiteWithRationaleDto;
import org.intellics.backend.domain.entities.KnowledgeComponent;
import org.intellics.backend.domain.entities.Module;
import org.intellics.backend.domain.entities.ModuleKCMapping;
import org.intellics.backend.domain.entities.ModuleKCMappingId;
import org.intellics.backend.domain.entities.ModuleKCPrerequisite;
import org.intellics.backend.domain.entities.ModuleKCPrerequisiteId;
import org.intellics.backend.mappers.Mapper;
import org.intellics.backend.repositories.KnowledgeComponentRepository;
import org.intellics.backend.repositories.ModuleKCMappingRepository;
import org.intellics.backend.repositories.ModuleKCPrerequisiteRepository;
import org.intellics.backend.repositories.ModuleRepository;
import org.intellics.backend.services.ModuleKCMappingService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
public class ModuleKCMappingServiceImpl implements ModuleKCMappingService {

    private final ModuleKCMappingRepository moduleKCMappingRepository;
    private final ModuleRepository moduleRepository;
    private final KnowledgeComponentRepository knowledgeComponentRepository;
    private final ModuleKCPrerequisiteRepository moduleKCPrerequisiteRepository;
    private final Mapper<ModuleKCMappingDto, ModuleKCMapping> moduleKCMappingMapper;

    public ModuleKCMappingServiceImpl(ModuleKCMappingRepository moduleKCMappingRepository,
                                      ModuleRepository moduleRepository,
                                      KnowledgeComponentRepository knowledgeComponentRepository,
                                      ModuleKCPrerequisiteRepository moduleKCPrerequisiteRepository,
                                      Mapper<ModuleKCMappingDto, ModuleKCMapping> moduleKCMappingMapper) {
        this.moduleKCMappingRepository = moduleKCMappingRepository;
        this.moduleRepository = moduleRepository;
        this.knowledgeComponentRepository = knowledgeComponentRepository;
        this.moduleKCPrerequisiteRepository = moduleKCPrerequisiteRepository;
        this.moduleKCMappingMapper = moduleKCMappingMapper;
    }

    @Override
    @Transactional
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
                .build();

        // Save the main mapping first
        ModuleKCMapping savedMapping = moduleKCMappingRepository.save(moduleKCMapping);

        // Handle prerequisites - prioritize prerequisitesWithRationale if provided
        List<PrerequisiteWithRationaleDto> prerequisitesWithRationale = moduleKCMappingDto.getPrerequisitesWithRationale();
        List<UUID> prerequisiteKcIds = moduleKCMappingDto.getPrerequisiteKcIds();
        
        if (prerequisitesWithRationale != null && !prerequisitesWithRationale.isEmpty()) {
            // Use prerequisites with rationale
            handlePrerequisitesWithRationale(module, kc, prerequisitesWithRationale, savedMapping);
        } else if (prerequisiteKcIds != null && !prerequisiteKcIds.isEmpty()) {
            // Use legacy prerequisite IDs (backward compatibility)
            handleLegacyPrerequisites(module, kc, prerequisiteKcIds, savedMapping);
        }

        return moduleKCMappingMapper.mapTo(savedMapping);
    }

    private void handlePrerequisitesWithRationale(Module module, KnowledgeComponent kc, 
                                                List<PrerequisiteWithRationaleDto> prerequisitesWithRationale, 
                                                ModuleKCMapping savedMapping) {
        // Fetch all prerequisite KCs in a single batch
        Set<UUID> prerequisiteKcIds = prerequisitesWithRationale.stream()
                .map(PrerequisiteWithRationaleDto::getPrerequisiteKcId)
                .collect(Collectors.toSet());
        
        Map<UUID, KnowledgeComponent> prerequisiteKcMap = knowledgeComponentRepository.findAllById(prerequisiteKcIds)
                .stream()
                .collect(Collectors.toMap(KnowledgeComponent::getKc_id, val -> val));

        // Build current graph for cycle detection
        List<ModuleKCMapping> existingMappings = moduleKCMappingRepository.findByModule(module);
        Map<UUID, Set<UUID>> adjList = buildAdjacencyList(existingMappings);

        for (PrerequisiteWithRationaleDto prerequisiteDto : prerequisitesWithRationale) {
            UUID prerequisiteKcId = prerequisiteDto.getPrerequisiteKcId();
            if (kc.getKc_id().equals(prerequisiteKcId)) {
                throw new IllegalArgumentException("A knowledge component cannot be its own prerequisite.");
            }
            
            KnowledgeComponent prerequisiteKc = prerequisiteKcMap.get(prerequisiteKcId);
            if (prerequisiteKc == null) {
                throw new ItemNotFoundException("Prerequisite Knowledge Component not found: " + prerequisiteKcId);
            }

            // Temporarily add the new edge for cycle detection
            adjList.computeIfAbsent(kc.getKc_id(), k -> new HashSet<>()).add(prerequisiteKcId);

            if (hasCycle(module.getModule_id(), kc.getKc_id(), prerequisiteKcId, adjList)) {
                throw new IllegalArgumentException("Adding KC " + prerequisiteKcId + " as prerequisite KC would create a circular dependency for KC: " + kc.getKc_name());
            }

            // Check if prerequisite relationship already exists
            ModuleKCPrerequisiteId prerequisiteId = ModuleKCPrerequisiteId.builder()
                    .moduleId(module.getModule_id())
                    .kcId(kc.getKc_id())
                    .prerequisiteKcId(prerequisiteKcId)
                    .build();

            // Try to find existing prerequisite
            Optional<ModuleKCPrerequisite> existingPrerequisite = moduleKCPrerequisiteRepository.findById(prerequisiteId);
            
            if (existingPrerequisite.isPresent()) {
                // Update existing prerequisite with new rationale
                ModuleKCPrerequisite existing = existingPrerequisite.get();
                existing.setRationale(prerequisiteDto.getRationale());
                moduleKCPrerequisiteRepository.save(existing);
            } else {
                // Create new prerequisite relationship with rationale
                ModuleKCPrerequisite prerequisite = ModuleKCPrerequisite.builder()
                        .id(prerequisiteId)
                        .rationale(prerequisiteDto.getRationale())
                        .build();

                moduleKCPrerequisiteRepository.save(prerequisite);
            }
        }
    }

    private void handleLegacyPrerequisites(Module module, KnowledgeComponent kc, 
                                         List<UUID> prerequisiteKcIds, 
                                         ModuleKCMapping savedMapping) {
        // Fetch all prerequisite KCs in a single batch
        Map<UUID, KnowledgeComponent> prerequisiteKcMap = knowledgeComponentRepository.findAllById(prerequisiteKcIds)
                .stream()
                .collect(Collectors.toMap(KnowledgeComponent::getKc_id, val -> val));

        // Build current graph for cycle detection
        List<ModuleKCMapping> existingMappings = moduleKCMappingRepository.findByModule(module);
        Map<UUID, Set<UUID>> adjList = buildAdjacencyList(existingMappings);

        for (UUID prerequisiteKcId : prerequisiteKcIds) {
            if (kc.getKc_id().equals(prerequisiteKcId)) {
                throw new IllegalArgumentException("A knowledge component cannot be its own prerequisite.");
            }
            KnowledgeComponent prerequisiteKc = prerequisiteKcMap.get(prerequisiteKcId);
            if (prerequisiteKc == null) {
                throw new ItemNotFoundException("Prerequisite Knowledge Component not found: " + prerequisiteKcId);
            }

            // Temporarily add the new edge for cycle detection
            adjList.computeIfAbsent(kc.getKc_id(), k -> new HashSet<>()).add(prerequisiteKcId);

            if (hasCycle(module.getModule_id(), kc.getKc_id(), prerequisiteKcId, adjList)) {
                throw new IllegalArgumentException("Adding kc " + prerequisiteKcId + " as prerequisite would create a circular dependency for KC: " + kc.getKc_name());
            }
            
            // Check if prerequisite relationship already exists
            ModuleKCPrerequisiteId prerequisiteId = ModuleKCPrerequisiteId.builder()
                    .moduleId(module.getModule_id())
                    .kcId(kc.getKc_id())
                    .prerequisiteKcId(prerequisiteKcId)
                    .build();

            // Try to find existing prerequisite
            Optional<ModuleKCPrerequisite> existingPrerequisite = moduleKCPrerequisiteRepository.findById(prerequisiteId);
            
            if (existingPrerequisite.isPresent()) {
                // Update existing prerequisite (keep existing rationale if any)
                ModuleKCPrerequisite existing = existingPrerequisite.get();
                // Don't change the rationale for legacy mode
                moduleKCPrerequisiteRepository.save(existing);
            } else {
                // Create new prerequisite relationship without rationale (legacy mode)
                ModuleKCPrerequisite prerequisite = ModuleKCPrerequisite.builder()
                        .id(prerequisiteId)
                        .rationale(null) // No rationale in legacy mode
                        .build();

                moduleKCPrerequisiteRepository.save(prerequisite);
            }
        }
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
    @Transactional
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
            // Get prerequisites for this mapping from the ModuleKCPrerequisite table
            List<ModuleKCPrerequisite> prerequisites = StreamSupport.stream(moduleKCPrerequisiteRepository.findAll().spliterator(), false)
                    .filter(p -> p.getId().getModuleId().equals(moduleId) && p.getId().getKcId().equals(mapping.getKnowledgeComponent().getKc_id()))
                    .collect(Collectors.toList());
            
            // Remove prerequisites that reference the KC being deleted
            for (ModuleKCPrerequisite prerequisite : prerequisites) {
                if (prerequisite.getId().getPrerequisiteKcId().equals(kcId)) {
                    moduleKCPrerequisiteRepository.delete(prerequisite);
                }
            }
        }
        
        // Step 2: Delete all prerequisite relationships for the KC being deleted
        List<ModuleKCPrerequisite> prerequisitesToDelete = StreamSupport.stream(moduleKCPrerequisiteRepository.findAll().spliterator(), false)
                .filter(p -> p.getId().getModuleId().equals(moduleId) && p.getId().getKcId().equals(kcId))
                .collect(Collectors.toList());
        moduleKCPrerequisiteRepository.deleteAll(prerequisitesToDelete);
        
        // Step 3: Delete the mapping record
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
    @Transactional
    public ModuleKCMappingDto patchModuleKCMapping(UUID moduleId, UUID kcId, ModuleKCMappingPatchDto patchDto) {
        ModuleKCMappingId mappingId = ModuleKCMappingId.builder()
                .moduleId(moduleId)
                .kcId(kcId)
                .build();

        ModuleKCMapping existingMapping = moduleKCMappingRepository.findById(mappingId)
                .orElseThrow(() -> new ItemNotFoundException("Module KC mapping not found"));

        // Handle prerequisites if provided
        if (patchDto.getPrerequisitesWithRationale() != null) {
            // Clear existing prerequisites first
            List<ModuleKCPrerequisite> existingPrerequisites = StreamSupport.stream(moduleKCPrerequisiteRepository.findAll().spliterator(), false)
                    .filter(p -> p.getId().getModuleId().equals(moduleId) && p.getId().getKcId().equals(kcId))
                    .collect(Collectors.toList());
            moduleKCPrerequisiteRepository.deleteAll(existingPrerequisites);

            // Add new prerequisites
            handlePrerequisitesWithRationale(existingMapping.getModule(), existingMapping.getKnowledgeComponent(), 
                                           patchDto.getPrerequisitesWithRationale(), existingMapping);
        }

        return moduleKCMappingMapper.mapTo(existingMapping);
    }

    @Override
    @Transactional
    public ModuleKCMappingDto addSinglePrerequisite(Module module, KnowledgeComponent kc, PrerequisiteWithRationaleDto prerequisite) {
        // Verify the prerequisite KC exists
        KnowledgeComponent prerequisiteKc = knowledgeComponentRepository.findById(prerequisite.getPrerequisiteKcId())
                .orElseThrow(() -> new ItemNotFoundException("Prerequisite Knowledge Component not found: " + prerequisite.getPrerequisiteKcId()));
        
        // Check for self-reference
        if (kc.getKc_id().equals(prerequisite.getPrerequisiteKcId())) {
            throw new IllegalArgumentException("A knowledge component cannot be its own prerequisite.");
        }
        
        // Check if prerequisite relationship already exists
        ModuleKCPrerequisiteId prerequisiteId = ModuleKCPrerequisiteId.builder()
                .moduleId(module.getModule_id())
                .kcId(kc.getKc_id())
                .prerequisiteKcId(prerequisite.getPrerequisiteKcId())
                .build();

        Optional<ModuleKCPrerequisite> existingPrerequisite = moduleKCPrerequisiteRepository.findById(prerequisiteId);
        
        if (existingPrerequisite.isPresent()) {
            throw new IllegalArgumentException("Prerequisite relationship already exists for KC: " + prerequisite.getPrerequisiteKcId());
        }
        
        // Build current graph for cycle detection
        List<ModuleKCMapping> existingMappings = moduleKCMappingRepository.findByModule(module);
        Map<UUID, Set<UUID>> adjList = buildAdjacencyList(existingMappings);
        
        // Temporarily add the new edge for cycle detection
        adjList.computeIfAbsent(kc.getKc_id(), k -> new HashSet<>()).add(prerequisite.getPrerequisiteKcId());

        if (hasCycle(module.getModule_id(), kc.getKc_id(), prerequisite.getPrerequisiteKcId(), adjList)) {
            throw new IllegalArgumentException("Adding KC " + prerequisite.getPrerequisiteKcId() + " as prerequisite would create a circular dependency for KC: " + kc.getKc_name());
        }
        
        // Create new prerequisite relationship with rationale
        ModuleKCPrerequisite newPrerequisite = ModuleKCPrerequisite.builder()
                .id(prerequisiteId)
                .rationale(prerequisite.getRationale())
                .build();

        moduleKCPrerequisiteRepository.save(newPrerequisite);
        
        // Return the updated mapping
        ModuleKCMappingId mappingId = ModuleKCMappingId.builder()
                .moduleId(module.getModule_id())
                .kcId(kc.getKc_id())
                .build();
        
        ModuleKCMapping mapping = moduleKCMappingRepository.findById(mappingId)
                .orElseThrow(() -> new ItemNotFoundException("Module KC mapping not found"));
        
        return moduleKCMappingMapper.mapTo(mapping);
    }

    @Override
    @Transactional
    public void removeSinglePrerequisite(Module module, KnowledgeComponent kc, UUID prerequisiteKcId) {
        // Check if prerequisite relationship exists
        ModuleKCPrerequisiteId prerequisiteId = ModuleKCPrerequisiteId.builder()
                .moduleId(module.getModule_id())
                .kcId(kc.getKc_id())
                .prerequisiteKcId(prerequisiteKcId)
                .build();

        Optional<ModuleKCPrerequisite> existingPrerequisite = moduleKCPrerequisiteRepository.findById(prerequisiteId);
        
        if (existingPrerequisite.isEmpty()) {
            throw new ItemNotFoundException("Prerequisite relationship not found for KC: " + prerequisiteKcId);
        }
        
        // Remove the prerequisite relationship
        moduleKCPrerequisiteRepository.delete(existingPrerequisite.get());
    }

    // Helper method to build adjacency list from existing mappings
    private Map<UUID, Set<UUID>> buildAdjacencyList(List<ModuleKCMapping> mappings) {
        Map<UUID, Set<UUID>> adjList = new HashMap<>();
        
        if (mappings.isEmpty()) {
            return adjList;
        }
        
        UUID moduleId = mappings.get(0).getModule().getModule_id();
        
        // Get all prerequisites for this specific module in one query
        List<ModuleKCPrerequisite> modulePrerequisites = moduleKCPrerequisiteRepository
                .findById_ModuleId(moduleId);
        
        // Build adjacency list efficiently
        for (ModuleKCPrerequisite prerequisite : modulePrerequisites) {
            UUID kcId = prerequisite.getId().getKcId();
            UUID prerequisiteKcId = prerequisite.getId().getPrerequisiteKcId();
            
            adjList.computeIfAbsent(kcId, k -> new HashSet<>()).add(prerequisiteKcId);
        }
        
        return adjList;
    }

    // Helper method for cycle detection using DFS
    private boolean hasCycle(UUID moduleId, UUID startKcId, UUID targetKcId, Map<UUID, Set<UUID>> adjList) {
        Set<UUID> visited = new HashSet<>();
        Set<UUID> recursionStack = new HashSet<>();
        return dfs(targetKcId, startKcId, visited, recursionStack, adjList, 0, 100); // Max depth of 100
    }

    private boolean dfs(UUID currentKcId, UUID targetKcId, Set<UUID> visited, Set<UUID> recursionStack, Map<UUID, Set<UUID>> adjList, int depth, int maxDepth) {
        // Prevent infinite recursion with depth limit
        if (depth > maxDepth) {
            return false; // Assume no cycle if we've gone too deep
        }
        
        visited.add(currentKcId);
        recursionStack.add(currentKcId);

        // If we found the target KC in the current path, it means a cycle exists
        if (currentKcId.equals(targetKcId)) {
            return true;
        }

        Set<UUID> prerequisites = adjList.getOrDefault(currentKcId, java.util.Collections.emptySet());
        for (UUID prerequisiteKcId : prerequisites) {
            if (!visited.contains(prerequisiteKcId)) {
                if (dfs(prerequisiteKcId, targetKcId, visited, recursionStack, adjList, depth + 1, maxDepth)) {
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
