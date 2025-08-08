package org.intellics.backend.services.impl;

import org.intellics.backend.api.error.exceptions.ItemNotFoundException;
import org.intellics.backend.domain.dto.LessonDto;
import org.intellics.backend.domain.entities.Lesson;
import org.intellics.backend.domain.entities.Module;
import org.intellics.backend.mappers.Mapper;
import org.intellics.backend.repositories.LessonRepository;
import org.intellics.backend.repositories.ModuleRepository;
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
    private final ModuleRepository moduleRepository;
    private final Mapper<LessonDto, Lesson> lessonMapper;

    public LessonServiceImpl(LessonRepository lessonRepository, 
                           ModuleRepository moduleRepository,
                           Mapper<LessonDto, Lesson> lessonMapper) {
        this.lessonRepository = lessonRepository;
        this.moduleRepository = moduleRepository;
        this.lessonMapper = lessonMapper;
    }

    @Override
    public LessonDto getLessonById(UUID id) {
        Lesson lesson = lessonRepository.findById(id)
                .orElseThrow(() -> new ItemNotFoundException("Lesson not found with id: " + id));
        return lessonMapper.mapTo(lesson);
    }

    @Override
    public List<LessonDto> getAllLessons() {
        return StreamSupport.stream(lessonRepository.findAll().spliterator(), false)
                .map(lessonMapper::mapTo)
                .collect(Collectors.toList());
    }

    @Override
    public List<LessonDto> getLessonsByModule(UUID moduleId) {
        Module module = moduleRepository.findById(moduleId)
                .orElseThrow(() -> new ItemNotFoundException("Module not found with id: " + moduleId));
        
        return lessonRepository.findByModule(module).stream()
                .map(lessonMapper::mapTo)
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
        if (lessonContent.length() > 10000) {
            throw new IllegalArgumentException("Lesson content cannot exceed 10000 characters");
        }
        
        Lesson lesson = lessonMapper.mapFrom(lessonDto);
        lesson.setLesson_id(null); // Ensure ID is null for new entity
        lesson.setLesson_name(lessonName);
        lesson.setLesson_content(lessonContent);
        
        // Validate module exists if module_id is provided
        if (lessonDto.getModule_id() != null) {
            Module module = moduleRepository.findById(lessonDto.getModule_id())
                    .orElseThrow(() -> new ItemNotFoundException("Module not found with id: " + lessonDto.getModule_id()));
            lesson.setModule(module);
        }
        
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
        if (lessonContent.length() > 10000) {
            throw new IllegalArgumentException("Lesson content cannot exceed 10000 characters");
        }
        existingLesson.setLesson_content(lessonContent);
        
        // Update module if provided
        if (lessonDto.getModule_id() != null) {
            Module module = moduleRepository.findById(lessonDto.getModule_id())
                    .orElseThrow(() -> new ItemNotFoundException("Module not found with id: " + lessonDto.getModule_id()));
            existingLesson.setModule(module);
        }
        
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
        
        // Update module if provided
        if (lessonDto.getModule_id() != null) {
            Module module = moduleRepository.findById(lessonDto.getModule_id())
                    .orElseThrow(() -> new ItemNotFoundException("Module not found with id: " + lessonDto.getModule_id()));
            existingLesson.setModule(module);
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
