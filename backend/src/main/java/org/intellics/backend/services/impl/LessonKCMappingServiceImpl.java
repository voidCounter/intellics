package org.intellics.backend.services.impl;

import org.intellics.backend.domain.dto.LessonKCMappingDto;
import org.intellics.backend.domain.entities.Lesson;
import org.intellics.backend.domain.entities.LessonKCMapping;
import org.intellics.backend.domain.entities.LessonKCMappingId;
import org.intellics.backend.domain.entities.KnowledgeComponent;
import org.intellics.backend.api.error.exceptions.ItemNotFoundException;
import org.intellics.backend.mappers.LessonKCMappingMapper;
import org.intellics.backend.repositories.LessonKCMappingRepository;
import org.intellics.backend.repositories.LessonRepository;
import org.intellics.backend.repositories.KnowledgeComponentRepository;

import org.intellics.backend.services.LessonKCMappingService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@Transactional
public class LessonKCMappingServiceImpl implements LessonKCMappingService {

    private final LessonKCMappingRepository lessonKCMappingRepository;
    private final LessonRepository lessonRepository;
    private final KnowledgeComponentRepository knowledgeComponentRepository;
    private final LessonKCMappingMapper lessonKCMappingMapper;

    public LessonKCMappingServiceImpl(LessonKCMappingRepository lessonKCMappingRepository,
                                   LessonRepository lessonRepository,
                                   KnowledgeComponentRepository knowledgeComponentRepository,
                                   LessonKCMappingMapper lessonKCMappingMapper) {
        this.lessonKCMappingRepository = lessonKCMappingRepository;
        this.lessonRepository = lessonRepository;
        this.knowledgeComponentRepository = knowledgeComponentRepository;
        this.lessonKCMappingMapper = lessonKCMappingMapper;
    }

    @Override
    @Transactional(readOnly = true)
    public List<LessonKCMappingDto> getKCsByLessonId(UUID lessonId) {
        // Verify lesson exists
        Lesson lesson = lessonRepository.findById(lessonId)
                .orElseThrow(() -> new ItemNotFoundException("Lesson not found with id: " + lessonId));

        List<LessonKCMapping> mappings = lessonKCMappingRepository.findByLessonId(lessonId);
        
        return mappings.stream()
                .map(lessonKCMappingMapper::mapTo)
                .collect(Collectors.toList());
    }

    @Override
    public LessonKCMappingDto addKCToLesson(UUID lessonId, UUID kcId, BigDecimal targetMastery) {
        // Validate target mastery
        if (targetMastery.compareTo(BigDecimal.ZERO) < 0 || targetMastery.compareTo(new BigDecimal("1.00")) > 0) {
            throw new IllegalArgumentException("Target mastery must be between 0 and 1");
        }
        if (targetMastery.compareTo(new BigDecimal("0.01")) < 0) {
            throw new IllegalArgumentException("Target mastery must be at least 0.01");
        }

        // Verify lesson exists
        Lesson lesson = lessonRepository.findById(lessonId)
                .orElseThrow(() -> new ItemNotFoundException("Lesson not found with id: " + lessonId));

        // Verify knowledge component exists
        KnowledgeComponent kc = knowledgeComponentRepository.findById(kcId)
                .orElseThrow(() -> new ItemNotFoundException("Knowledge component not found with id: " + kcId));

        // No validation needed - Lessons are independent and can have any KCs

        // Check if mapping already exists
        if (lessonKCMappingRepository.existsByLessonIdAndKnowledgeComponentId(lessonId, kcId)) {
            throw new IllegalArgumentException("KC is already mapped to this lesson");
        }

        // Create new mapping
        LessonKCMappingId mappingId = LessonKCMappingId.builder()
                .lesson_id(lessonId)
                .kc_id(kcId)
                .build();

        LessonKCMapping mapping = LessonKCMapping.builder()
                .mapping_id(mappingId)
                .target_mastery(targetMastery)
                .lesson(lesson)
                .knowledge_component(kc)
                .build();

        LessonKCMapping savedMapping = lessonKCMappingRepository.save(mapping);
        return lessonKCMappingMapper.mapTo(savedMapping);
    }

    @Override
    public LessonKCMappingDto updateTargetMastery(UUID lessonId, UUID kcId, BigDecimal targetMastery) {
        // Validate target mastery
        if (targetMastery.compareTo(BigDecimal.ZERO) < 0 || targetMastery.compareTo(new BigDecimal("1.00")) > 0) {
            throw new IllegalArgumentException("Target mastery must be between 0 and 1");
        }
        if (targetMastery.compareTo(new BigDecimal("0.01")) < 0) {
            throw new IllegalArgumentException("Target mastery must be at least 0.01");
        }

        LessonKCMappingId mappingId = LessonKCMappingId.builder()
                .lesson_id(lessonId)
                .kc_id(kcId)
                .build();

        LessonKCMapping mapping = lessonKCMappingRepository.findById(mappingId)
                .orElseThrow(() -> new ItemNotFoundException("Lesson-KC mapping not found"));

        mapping.setTarget_mastery(targetMastery);
        LessonKCMapping updatedMapping = lessonKCMappingRepository.save(mapping);
        
        return lessonKCMappingMapper.mapTo(updatedMapping);
    }

    @Override
    public void removeKCFromLesson(UUID lessonId, UUID kcId) {
        LessonKCMappingId mappingId = LessonKCMappingId.builder()
                .lesson_id(lessonId)
                .kc_id(kcId)
                .build();

        if (!lessonKCMappingRepository.existsById(mappingId)) {
            throw new ItemNotFoundException("Lesson-KC mapping not found");
        }

        lessonKCMappingRepository.deleteById(mappingId);
    }


}
