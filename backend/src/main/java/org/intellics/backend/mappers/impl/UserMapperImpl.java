package org.intellics.backend.mappers.impl;

import org.intellics.backend.domain.dto.RoleDto;
import org.intellics.backend.domain.dto.UserDto;
import org.intellics.backend.domain.entities.Role;
import org.intellics.backend.domain.entities.User;
import org.intellics.backend.mappers.UserMapper;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import java.util.Set;
import java.util.stream.Collectors;

@Component
public class UserMapperImpl implements UserMapper {

    private final ModelMapper modelMapper;

    public UserMapperImpl(ModelMapper modelMapper) {
        this.modelMapper = modelMapper;
    }

    @Override
    public UserDto mapTo(User user) {
        UserDto userDto = modelMapper.map(user, UserDto.class);
        
        // Map roles manually to exclude roleId
        if (user.getRoles() != null) {
            Set<RoleDto> roleDtos = user.getRoles().stream()
                .map(role -> RoleDto.builder()
                    .name(role.getName())
                    .build())
                .collect(Collectors.toSet());
            userDto.setRoles(roleDtos);
        }
        
        return userDto;
    }

    @Override
    public User mapFrom(UserDto userDto) {
        return modelMapper.map(userDto, User.class);
    }
}
