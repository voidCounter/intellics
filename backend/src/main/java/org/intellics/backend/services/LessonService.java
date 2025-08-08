package org.intellics.backend.services;

import org.intellics.backend.domain.dto.LessonDto;

import java.util.List;
import java.util.UUID;

public interface LessonService {
    LessonDto getLessonById(UUID id);
    List<LessonDto> getAllLessons();
    List<LessonDto> getLessonsByModule(UUID moduleId);
    LessonDto createLesson(LessonDto lessonDto);
    LessonDto updateLesson(UUID id, LessonDto lessonDto);
    LessonDto patchLesson(UUID id, LessonDto lessonDto);
    void deleteLesson(UUID id);
}
