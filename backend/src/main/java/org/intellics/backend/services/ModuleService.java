package org.intellics.backend.services;

import java.util.List;
import java.util.UUID;

import org.intellics.backend.domain.dto.LessonDto;
import org.intellics.backend.domain.dto.ModuleDto;
import org.intellics.backend.domain.dto.ModuleKCMappingDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentCreateDto;

public interface ModuleService {
    ModuleDto getModuleById(UUID id);
    List<ModuleDto> getAllModules();
    ModuleDto createModule(ModuleDto moduleDto);
    ModuleDto updateModule(UUID id, ModuleDto moduleDto);
    void deleteModule(UUID id);
    ModuleDto patchModule(UUID id, ModuleDto moduleDto);
    List<org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentPrerequisiteDto> getKnowledgeComponentsByModule(UUID moduleId);
    org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentPrerequisiteDto getKnowledgeComponentByModule(UUID moduleId, UUID kcId);
    ModuleKCMappingDto addKnowledgeComponentToModule(UUID moduleId, UUID kcId, List<UUID> prerequisiteKcIds);
    void removeKnowledgeComponentFromModule(UUID moduleId, UUID kcId);
    void removeAllKnowledgeComponentsFromModule(UUID moduleId);
    org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentPrerequisiteDto createAndAddKnowledgeComponentToModule(UUID moduleId, KnowledgeComponentCreateDto kcCreateDto);
    LessonDto createLessonForModule(UUID moduleId, LessonDto lessonDto);
}
