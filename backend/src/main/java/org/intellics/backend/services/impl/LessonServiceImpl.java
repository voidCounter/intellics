package org.intellics.backend.services.impl;

import org.intellics.backend.api.error.exceptions.ItemNotFoundException;
import org.intellics.backend.domain.dto.LessonDto;
import org.intellics.backend.domain.dto.LessonWithKCsDto;
import org.intellics.backend.domain.dto.LessonTitleDto;
import org.intellics.backend.domain.dto.LessonTitleProjection;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentSimpleDto;
import org.intellics.backend.domain.entities.Lesson;
import org.intellics.backend.mappers.Mapper;
import org.intellics.backend.repositories.LessonRepository;
import org.intellics.backend.services.KnowledgeComponentService;
import org.intellics.backend.services.LessonKCMappingService;
import org.intellics.backend.services.LessonService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

@Service
public class LessonServiceImpl implements LessonService {

    private final LessonRepository lessonRepository;
    private final Mapper<LessonDto, Lesson> lessonMapper;
    private final LessonKCMappingService lessonKCMappingService;
    private final KnowledgeComponentService knowledgeComponentService;

    public LessonServiceImpl(LessonRepository lessonRepository,
                           Mapper<LessonDto, Lesson> lessonMapper,
                           LessonKCMappingService lessonKCMappingService,
                           KnowledgeComponentService knowledgeComponentService) {
        this.lessonRepository = lessonRepository;
        this.lessonMapper = lessonMapper;
        this.lessonKCMappingService = lessonKCMappingService;
        this.knowledgeComponentService = knowledgeComponentService;
    }

    @Override
    public LessonDto getLessonById(UUID id) {
        Lesson lesson = lessonRepository.findById(id)
                .orElseThrow(() -> new ItemNotFoundException("Lesson not found with id: " + id));
        return lessonMapper.mapTo(lesson);
    }

    @Override
    public LessonWithKCsDto getLessonByIdWithKCs(UUID id) {
        // Get the lesson
        Lesson lesson = lessonRepository.findById(id)
                .orElseThrow(() -> new ItemNotFoundException("Lesson not found with id: " + id));
        
        // Get KC mappings for this lesson
        var kcMappings = lessonKCMappingService.getKCsByLessonId(id);
        
        // Build the response DTO
        LessonWithKCsDto lessonWithKCs = LessonWithKCsDto.builder()
                .lesson_id(lesson.getLesson_id())
                .lesson_name(lesson.getLesson_name())
                .lesson_content(lesson.getLesson_content())
                .knowledgeComponents(kcMappings.stream()
                        .map(mapping -> {
                            // Get KC details - filter out inactive/deleted KCs
                            var kcOptional = knowledgeComponentService.findOne(mapping.getKcId());
                            if (kcOptional.isEmpty()) {
                                // Log inactive/deleted KC for debugging
                                System.out.println("Warning: KC not found (likely inactive/deleted): " + mapping.getKcId());
                                return null;
                            }
                            
                            var kcDetails = kcOptional.get();
                            return LessonWithKCsDto.LessonKCInfoDto.builder()
                                    .kcId(mapping.getKcId())
                                    .kcName(kcDetails.getKc_name())
                                    .description(kcDetails.getDescription())
                                    .targetMastery(mapping.getTargetMastery())
                                    .build();
                        })
                        .filter(kcInfo -> kcInfo != null) // Filter out null entries
                        .collect(java.util.stream.Collectors.toList()))
                .build();
        
        return lessonWithKCs;
    }

    @Override
    public List<LessonDto> getAllLessons() {
        return StreamSupport.stream(lessonRepository.findAll().spliterator(), false)
                .map(lessonMapper::mapTo)
                .collect(Collectors.toList());
    }

    @Override
    public List<LessonTitleDto> getLessonTitles() {
        return lessonRepository.findLessonTitlesOnly().stream()
                .map(projection -> LessonTitleDto.builder()
                        .lesson_id(projection.getLesson_id())
                        .lesson_name(projection.getLesson_name())
                        .build())
                .collect(Collectors.toList());
    }


    @Override
    @Transactional
    public LessonDto createLesson(LessonDto lessonDto) {
        // Validate lesson_name
        String lessonName = lessonDto.getLesson_name().trim();
        if (lessonName.isEmpty()) {
            throw new IllegalArgumentException("Lesson name cannot be empty");
        }
        if (lessonName.length() > 255) {
            throw new IllegalArgumentException("Lesson name cannot exceed 255 characters");
        }
        
        // Validate lesson_content
        String lessonContent = lessonDto.getLesson_content().trim();
        if (lessonContent.isEmpty()) {
            throw new IllegalArgumentException("Lesson content cannot be empty");
        }
        if (lessonContent.length() > 100000) {
            throw new IllegalArgumentException("Lesson content cannot exceed 100000 characters");
        }
        
        Lesson lesson = lessonMapper.mapFrom(lessonDto);
        lesson.setLesson_id(null); // Ensure ID is null for new entity
        lesson.setLesson_name(lessonName);
        lesson.setLesson_content(lessonContent);
        
        Lesson savedLesson = lessonRepository.save(lesson);
        return lessonMapper.mapTo(savedLesson);
    }

    @Override
    @Transactional
    public LessonDto updateLesson(UUID id, LessonDto lessonDto) {
        Lesson existingLesson = lessonRepository.findById(id)
                .orElseThrow(() -> new ItemNotFoundException("Lesson not found with id: " + id));
        
        // Validate lesson_name
        String lessonName = lessonDto.getLesson_name().trim();
        if (lessonName.isEmpty()) {
            throw new IllegalArgumentException("Lesson name cannot be empty");
        }
        if (lessonName.length() > 255) {
            throw new IllegalArgumentException("Lesson name cannot exceed 255 characters");
        }
        existingLesson.setLesson_name(lessonName);
        
        // Validate lesson_content
        String lessonContent = lessonDto.getLesson_content().trim();
        if (lessonContent.isEmpty()) {
            throw new IllegalArgumentException("Lesson content cannot be empty");
        }
        if (lessonContent.length() > 100000) {
            throw new IllegalArgumentException("Lesson content cannot exceed 100000 characters");
        }
        existingLesson.setLesson_content(lessonContent);
        
        Lesson updatedLesson = lessonRepository.save(existingLesson);
        return lessonMapper.mapTo(updatedLesson);
    }

    @Override
    @Transactional
    public LessonDto patchLesson(UUID id, LessonDto lessonDto) {
        Lesson existingLesson = lessonRepository.findById(id)
                .orElseThrow(() -> new ItemNotFoundException("Lesson not found with id: " + id));
        
        // Validate and update lesson_name if provided
        if (lessonDto.getLesson_name() != null) {
            String lessonName = lessonDto.getLesson_name().trim();
            if (lessonName.isEmpty()) {
                throw new IllegalArgumentException("Lesson name cannot be empty");
            }
            if (lessonName.length() > 255) {
                throw new IllegalArgumentException("Lesson name cannot exceed 255 characters");
            }
            existingLesson.setLesson_name(lessonName);
        }
        
        // Validate and update lesson_content if provided
        if (lessonDto.getLesson_content() != null) {
            String lessonContent = lessonDto.getLesson_content().trim();
            if (lessonContent.isEmpty()) {
                throw new IllegalArgumentException("Lesson content cannot be empty");
            }
            if (lessonContent.length() > 10000) {
                throw new IllegalArgumentException("Lesson content cannot exceed 10000 characters");
            }
            existingLesson.setLesson_content(lessonContent);
        }
        
        Lesson patchedLesson = lessonRepository.save(existingLesson);
        return lessonMapper.mapTo(patchedLesson);
    }

    @Override
    @Transactional
    public void deleteLesson(UUID id) {
        if (!lessonRepository.existsById(id)) {
            throw new ItemNotFoundException("Lesson not found with id: " + id);
        }
        lessonRepository.deleteById(id);
    }
}
