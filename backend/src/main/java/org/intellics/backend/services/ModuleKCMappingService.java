package org.intellics.backend.services;

import org.intellics.backend.domain.dto.ModuleKCMappingDto;
import org.intellics.backend.domain.dto.ModuleKCMappingPatchDto;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ModuleKCMappingService {
    ModuleKCMappingDto createModuleKCMapping(ModuleKCMappingDto moduleKCMappingDto);
    List<ModuleKCMappingDto> findAll();
    Optional<ModuleKCMappingDto> findOne(UUID moduleId, UUID kcId);
    void delete(UUID moduleId, UUID kcId);
    boolean isExists(UUID moduleId, UUID kcId);
    ModuleKCMappingDto patchModuleKCMapping(UUID moduleId, UUID kcId, ModuleKCMappingPatchDto patchDto);
    ModuleKCMappingDto addSinglePrerequisite(org.intellics.backend.domain.entities.Module module, org.intellics.backend.domain.entities.KnowledgeComponent kc, org.intellics.backend.domain.dto.PrerequisiteWithRationaleDto prerequisite);
    void removeSinglePrerequisite(org.intellics.backend.domain.entities.Module module, org.intellics.backend.domain.entities.KnowledgeComponent kc, UUID prerequisiteKcId);
}
