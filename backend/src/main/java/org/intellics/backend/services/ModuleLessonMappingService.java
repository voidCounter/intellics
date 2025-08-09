package org.intellics.backend.services;

import org.intellics.backend.domain.dto.ModuleLessonMappingDto;
import org.intellics.backend.domain.dto.ModuleLessonLinkRequestDto;
import org.intellics.backend.domain.dto.ModuleLessonOrderUpdateDto;

import java.util.List;
import java.util.UUID;

public interface ModuleLessonMappingService {
    List<ModuleLessonMappingDto> getLessonsByModuleId(UUID moduleId);
    List<ModuleLessonMappingDto> getModulesByLessonId(UUID lessonId);
    ModuleLessonMappingDto addLessonToModule(UUID moduleId, UUID lessonId, Integer orderIndex);
    void updateAllLessonOrders(UUID moduleId, ModuleLessonOrderUpdateDto orderUpdateDto);
    void removeLessonFromModule(UUID moduleId, UUID lessonId);
    boolean isLessonInModule(UUID moduleId, UUID lessonId);
}
