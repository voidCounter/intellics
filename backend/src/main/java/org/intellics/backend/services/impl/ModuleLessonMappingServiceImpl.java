package org.intellics.backend.services.impl;

import org.intellics.backend.domain.dto.ModuleLessonMappingDto;
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

import java.util.List;
import java.util.UUID;

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
    public ModuleLessonMappingDto addLessonToModule(UUID moduleId, UUID lessonId) {
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

        ModuleLessonMapping mapping = ModuleLessonMapping.builder()
                .mappingId(ModuleLessonMappingId.builder()
                        .moduleId(moduleId)
                        .lessonId(lessonId)
                        .build())
                .module(module)
                .lesson(lesson)
                .build();

        ModuleLessonMapping savedMapping = moduleLessonMappingRepository.save(mapping);
        return moduleLessonMappingMapper.mapFrom(savedMapping);
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
