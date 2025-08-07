package org.intellics.backend.mappers.impl;

import org.intellics.backend.domain.dto.ModuleDto;
import org.intellics.backend.domain.entities.Module;
import org.intellics.backend.mappers.Mapper;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
public class ModuleMapperImpl implements Mapper<ModuleDto, Module> {

    private final ModelMapper modelMapper;

    public ModuleMapperImpl(ModelMapper modelMapper) {
        this.modelMapper = modelMapper;
    }

    @Override
    public ModuleDto mapTo(Module module) {
        return modelMapper.map(module, ModuleDto.class);
    }

    @Override
    public Module mapFrom(ModuleDto moduleDto) {
        return modelMapper.map(moduleDto, Module.class);
    }
}
