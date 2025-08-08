package org.intellics.backend.services;

import org.intellics.backend.domain.dto.ModuleLessonMappingDto;
import org.intellics.backend.domain.dto.ModuleLessonLinkRequestDto;

import java.util.List;
import java.util.UUID;

public interface ModuleLessonMappingService {
    List<ModuleLessonMappingDto> getLessonsByModuleId(UUID moduleId);
    List<ModuleLessonMappingDto> getModulesByLessonId(UUID lessonId);
    ModuleLessonMappingDto addLessonToModule(UUID moduleId, UUID lessonId);
    void removeLessonFromModule(UUID moduleId, UUID lessonId);
    boolean isLessonInModule(UUID moduleId, UUID lessonId);
}
