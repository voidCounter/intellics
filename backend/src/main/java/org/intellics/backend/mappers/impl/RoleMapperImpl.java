package org.intellics.backend.mappers.impl;

import org.intellics.backend.domain.dto.RoleDto;
import org.intellics.backend.domain.entities.Role;
import org.intellics.backend.mappers.RoleMapper;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
public class RoleMapperImpl implements RoleMapper {

    private final ModelMapper modelMapper;

    public RoleMapperImpl(ModelMapper modelMapper) {
        this.modelMapper = modelMapper;
    }

    @Override
    public RoleDto mapTo(Role role) {
        return modelMapper.map(role, RoleDto.class);
    }

    @Override
    public Role mapFrom(RoleDto roleDto) {
        return modelMapper.map(roleDto, Role.class);
    }
}
