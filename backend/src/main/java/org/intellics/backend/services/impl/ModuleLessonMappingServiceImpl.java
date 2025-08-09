package org.intellics.backend.services.impl;

import org.intellics.backend.domain.dto.ModuleLessonMappingDto;
import org.intellics.backend.domain.dto.ModuleLessonOrderUpdateDto;
import org.intellics.backend.domain.entities.Lesson;
import org.intellics.backend.domain.entities.Module;
import org.intellics.backend.domain.entities.ModuleLessonMapping;
import org.intellics.backend.domain.entities.ModuleLessonMappingId;
import org.intellics.backend.domain.entities.LessonKCMapping;
import org.intellics.backend.mappers.ModuleLessonMappingMapper;
import org.intellics.backend.repositories.LessonRepository;
import org.intellics.backend.repositories.ModuleLessonMappingRepository;
import org.intellics.backend.repositories.ModuleRepository;
import org.intellics.backend.repositories.LessonKCMappingRepository;
import org.intellics.backend.repositories.ModuleKCMappingRepository;
import org.intellics.backend.services.ModuleLessonMappingService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@Transactional
public class ModuleLessonMappingServiceImpl implements ModuleLessonMappingService {

    private final ModuleLessonMappingRepository moduleLessonMappingRepository;
    private final ModuleRepository moduleRepository;
    private final LessonRepository lessonRepository;
    private final ModuleLessonMappingMapper moduleLessonMappingMapper;
    private final LessonKCMappingRepository lessonKCMappingRepository;
    private final ModuleKCMappingRepository moduleKCMappingRepository;

    public ModuleLessonMappingServiceImpl(ModuleLessonMappingRepository moduleLessonMappingRepository,
                                       ModuleRepository moduleRepository,
                                       LessonRepository lessonRepository,
                                       ModuleLessonMappingMapper moduleLessonMappingMapper,
                                       LessonKCMappingRepository lessonKCMappingRepository,
                                       ModuleKCMappingRepository moduleKCMappingRepository) {
        this.moduleLessonMappingRepository = moduleLessonMappingRepository;
        this.moduleRepository = moduleRepository;
        this.lessonRepository = lessonRepository;
        this.moduleLessonMappingMapper = moduleLessonMappingMapper;
        this.lessonKCMappingRepository = lessonKCMappingRepository;
        this.moduleKCMappingRepository = moduleKCMappingRepository;
    }

    @Override
    public List<ModuleLessonMappingDto> getLessonsByModuleId(UUID moduleId) {
        List<ModuleLessonMapping> mappings = moduleLessonMappingRepository.findByModuleId(moduleId);
        return moduleLessonMappingMapper.toDtoList(mappings);
    }

    @Override
    public List<ModuleLessonMappingDto> getModulesByLessonId(UUID lessonId) {
        List<ModuleLessonMapping> mappings = moduleLessonMappingRepository.findByLessonId(lessonId);
        return moduleLessonMappingMapper.toDtoList(mappings);
    }

    @Override
    public ModuleLessonMappingDto addLessonToModule(UUID moduleId, UUID lessonId, Integer orderIndex) {
        // Check if both module and lesson exist
        Module module = moduleRepository.findById(moduleId)
                .orElseThrow(() -> new RuntimeException("Module not found"));
        Lesson lesson = lessonRepository.findById(lessonId)
                .orElseThrow(() -> new RuntimeException("Lesson not found"));

        // Check if mapping already exists
        if (moduleLessonMappingRepository.existsByModuleIdAndLessonId(moduleId, lessonId)) {
            throw new RuntimeException("Lesson is already mapped to this module");
        }

        // Validate that all KCs in the lesson are available in the module
        validateLessonKCsInModule(lessonId, moduleId);

        // If order index is not provided, assign the next available index
        if (orderIndex == null) {
            orderIndex = moduleLessonMappingRepository.findNextOrderIndexForModule(moduleId);
        }

        ModuleLessonMapping mapping = ModuleLessonMapping.builder()
                .mappingId(ModuleLessonMappingId.builder()
                        .moduleId(moduleId)
                        .lessonId(lessonId)
                        .build())
                .module(module)
                .lesson(lesson)
                .orderIndex(orderIndex)
                .build();

        ModuleLessonMapping savedMapping = moduleLessonMappingRepository.save(mapping);
        return moduleLessonMappingMapper.mapFrom(savedMapping);
    }
    
    @Override
    @Transactional
    public void updateAllLessonOrders(UUID moduleId, ModuleLessonOrderUpdateDto orderUpdateDto) {
        List<ModuleLessonOrderUpdateDto.LessonOrderItem> lessonOrders = orderUpdateDto.getLessonOrders();
        
        // Validate sequential ordering (1, 2, 3, 4... with no gaps)
        validateSequentialOrdering(lessonOrders);
        
        // Verify all lessons belong to this module
        List<ModuleLessonMapping> existingMappings = moduleLessonMappingRepository.findByModuleId(moduleId);
        if (existingMappings.size() != lessonOrders.size()) {
            throw new RuntimeException("Lesson count mismatch. Expected " + existingMappings.size() + 
                    " lessons for module, but received " + lessonOrders.size());
        }
        
        // Verify all provided lessons exist in this module (security check)
        Set<UUID> existingLessonIds = existingMappings.stream()
                .map(mapping -> mapping.getMappingId().getLessonId())
                .collect(Collectors.toSet());
        
        for (ModuleLessonOrderUpdateDto.LessonOrderItem item : lessonOrders) {
            if (!existingLessonIds.contains(item.getLessonId())) {
                throw new RuntimeException("Lesson " + item.getLessonId() + " is not mapped to this module");
            }
        }
        
        // Perform batch update - much more efficient than individual saves!
        for (ModuleLessonOrderUpdateDto.LessonOrderItem item : lessonOrders) {
            moduleLessonMappingRepository.updateSingleLessonOrder(
                moduleId, 
                item.getLessonId(), 
                item.getOrderIndex()
            );
        }
    }
    
    private void validateSequentialOrdering(List<ModuleLessonOrderUpdateDto.LessonOrderItem> lessonOrders) {
        if (lessonOrders.isEmpty()) {
            throw new RuntimeException("Lesson orders list cannot be empty");
        }
        
        // Extract and sort order indexes
        List<Integer> orderIndexes = lessonOrders.stream()
                .map(ModuleLessonOrderUpdateDto.LessonOrderItem::getOrderIndex)
                .sorted()
                .toList();
        
        // Check for duplicates
        Set<Integer> uniqueIndexes = new HashSet<>(orderIndexes);
        if (uniqueIndexes.size() != orderIndexes.size()) {
            throw new RuntimeException("Duplicate order indexes are not allowed");
        }
        
        // Check that ordering starts from 1 and is sequential
        for (int i = 0; i < orderIndexes.size(); i++) {
            int expectedIndex = i + 1;
            if (!orderIndexes.get(i).equals(expectedIndex)) {
                throw new RuntimeException("Order indexes must be sequential starting from 1. " +
                        "Expected " + expectedIndex + " but found " + orderIndexes.get(i));
            }
        }
    }

    @Override
    public void removeLessonFromModule(UUID moduleId, UUID lessonId) {
        ModuleLessonMappingId mappingId = ModuleLessonMappingId.builder()
                .moduleId(moduleId)
                .lessonId(lessonId)
                .build();

        if (!moduleLessonMappingRepository.existsById(mappingId)) {
            throw new RuntimeException("Lesson is not mapped to this module");
        }

        moduleLessonMappingRepository.deleteById(mappingId);
    }

    @Override
    public boolean isLessonInModule(UUID moduleId, UUID lessonId) {
        return moduleLessonMappingRepository.existsByModuleIdAndLessonId(moduleId, lessonId);
    }

    /**
     * Validates that all KCs in a lesson are available in the specified module.
     * This ensures curriculum coherence when adding lessons to modules.
     */
    private void validateLessonKCsInModule(UUID lessonId, UUID moduleId) {
        // Get all KCs mapped to this lesson
        List<LessonKCMapping> lessonKCMappings = lessonKCMappingRepository.findByLessonId(lessonId);
        
        // If lesson has no KCs, it's valid to add to any module
        if (lessonKCMappings.isEmpty()) {
            return;
        }

        // Check each KC in the lesson to ensure it's available in the module
        for (LessonKCMapping lessonKCMapping : lessonKCMappings) {
            UUID kcId = lessonKCMapping.getKnowledge_component().getKc_id();
            
            // Check if this KC is available in the module
            if (!moduleKCMappingRepository.existsByModuleIdAndKnowledgeComponentId(moduleId, kcId)) {
                throw new IllegalArgumentException(
                    String.format("Knowledge Component with ID %s is not available in module %s. " +
                                "Cannot add lesson to module as it contains KCs not covered by the module.", 
                                kcId, moduleId));
            }
        }
    }
}
