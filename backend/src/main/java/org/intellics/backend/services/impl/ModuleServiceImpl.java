package org.intellics.backend.services.impl;

import org.intellics.backend.domain.dto.ModuleDto;
import org.intellics.backend.domain.entities.Module;
import org.intellics.backend.api.error.exceptions.ItemNotFoundException;
import org.intellics.backend.mappers.Mapper;
import org.intellics.backend.repositories.ModuleRepository;
import org.intellics.backend.services.ModuleService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

@Service
public class ModuleServiceImpl implements ModuleService {

    private final ModuleRepository moduleRepository;
    private final Mapper<ModuleDto, Module> moduleMapper;

    public ModuleServiceImpl(ModuleRepository moduleRepository, Mapper<ModuleDto, Module> moduleMapper) {
        this.moduleRepository = moduleRepository;
        this.moduleMapper = moduleMapper;
    }

    @Override
    public ModuleDto getModuleById(UUID id) {
        Module module = moduleRepository.findById(id)
                .orElseThrow(() -> new ItemNotFoundException("Module not found with id: " + id));
        return moduleMapper.mapTo(module);
    }

    @Override
    public List<ModuleDto> getAllModules() {
        return StreamSupport.stream(moduleRepository.findAll().spliterator(), false)
                .map(moduleMapper::mapTo)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public ModuleDto createModule(ModuleDto moduleDto) {
        Module module = moduleMapper.mapFrom(moduleDto);
        module.setModule_id(null); // Ensure ID is null for new entity
        Module savedModule = moduleRepository.save(module);
        return moduleMapper.mapTo(savedModule);
    }

    @Override
    @Transactional
    public ModuleDto updateModule(UUID id, ModuleDto moduleDto) {
        Module existingModule = moduleRepository.findById(id)
                .orElseThrow(() -> new ItemNotFoundException("Module not found with id: " + id));
        existingModule.setModule_name(moduleDto.getModule_name());
        existingModule.setDescription(moduleDto.getDescription());
        Module updatedModule = moduleRepository.save(existingModule);
        return moduleMapper.mapTo(updatedModule);
    }

    @Override
    @Transactional
    public void deleteModule(UUID id) {
        if (!moduleRepository.existsById(id)) {
            throw new ItemNotFoundException("Module not found with id: " + id);
        }
        moduleRepository.deleteById(id);
    }

    @Override
    @Transactional
    public ModuleDto patchModule(UUID id, ModuleDto moduleDto) {
        Module existingModule = moduleRepository.findById(id)
                .orElseThrow(() -> new ItemNotFoundException("Module not found with id: " + id));

        if (moduleDto.getModule_name() != null) {
            existingModule.setModule_name(moduleDto.getModule_name());
        }
        if (moduleDto.getDescription() != null) {
            existingModule.setDescription(moduleDto.getDescription());
        }

        Module patchedModule = moduleRepository.save(existingModule);
        return moduleMapper.mapTo(patchedModule);
    }
}
