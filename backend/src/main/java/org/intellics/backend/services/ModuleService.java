package org.intellics.backend.services;

import org.intellics.backend.domain.dto.ModuleDto;

import java.util.List;
import java.util.UUID;

public interface ModuleService {
    ModuleDto getModuleById(UUID id);
    List<ModuleDto> getAllModules();
    ModuleDto createModule(ModuleDto moduleDto);
    ModuleDto updateModule(UUID id, ModuleDto moduleDto);
    void deleteModule(UUID id);
    ModuleDto patchModule(UUID id, ModuleDto moduleDto);
}
