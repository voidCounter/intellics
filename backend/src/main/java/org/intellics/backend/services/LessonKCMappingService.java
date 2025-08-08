package org.intellics.backend.services;

import org.intellics.backend.domain.dto.LessonKCMappingDto;
import org.intellics.backend.domain.dto.LessonKCMappingPatchDto;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

public interface LessonKCMappingService {
    List<LessonKCMappingDto> getKCsByLessonId(UUID lessonId);
    LessonKCMappingDto addKCToLesson(UUID lessonId, UUID kcId, BigDecimal targetMastery);
    LessonKCMappingDto updateTargetMastery(UUID lessonId, UUID kcId, BigDecimal targetMastery);
    void removeKCFromLesson(UUID lessonId, UUID kcId);
}
