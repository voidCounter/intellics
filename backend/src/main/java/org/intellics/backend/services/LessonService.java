package org.intellics.backend.services;

import org.intellics.backend.domain.dto.LessonDto;
import org.intellics.backend.domain.dto.LessonTitleDto;
import org.intellics.backend.domain.dto.LessonWithKCsDto;

import java.util.List;
import java.util.UUID;

public interface LessonService {
    LessonDto getLessonById(UUID id);
    LessonWithKCsDto getLessonByIdWithKCs(UUID id);
    List<LessonDto> getAllLessons();
    List<LessonTitleDto> getLessonTitles();
    LessonDto createLesson(LessonDto lessonDto);
    LessonDto updateLesson(UUID id, LessonDto lessonDto);
    LessonDto patchLesson(UUID id, LessonDto lessonDto);
    void deleteLesson(UUID id);
}
