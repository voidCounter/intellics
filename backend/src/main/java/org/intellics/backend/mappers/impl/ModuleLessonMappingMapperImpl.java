package org.intellics.backend.mappers.impl;

import org.intellics.backend.domain.dto.ModuleLessonMappingDto;
import org.intellics.backend.domain.entities.ModuleLessonMapping;
import org.intellics.backend.mappers.ModuleLessonMappingMapper;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class ModuleLessonMappingMapperImpl implements ModuleLessonMappingMapper {

    @Override
    public ModuleLessonMapping mapTo(ModuleLessonMappingDto dto) {
        if (dto == null) {
            return null;
        }

        // Note: This is a simplified mapping. In practice, you'd need to fetch the actual entities
        return ModuleLessonMapping.builder()
                .mappingId(org.intellics.backend.domain.entities.ModuleLessonMappingId.builder()
                        .moduleId(dto.getModuleId())
                        .lessonId(dto.getLessonId())
                        .build())
                .orderIndex(dto.getOrderIndex())
                .build();
    }

    @Override
    public ModuleLessonMappingDto mapFrom(ModuleLessonMapping entity) {
        if (entity == null) {
            return null;
        }

        return ModuleLessonMappingDto.builder()
                .moduleId(entity.getMappingId().getModuleId())
                .lessonId(entity.getMappingId().getLessonId())
                .moduleName(entity.getModule() != null ? entity.getModule().getModule_name() : null)
                .lessonName(entity.getLesson() != null ? entity.getLesson().getLesson_name() : null)
                .orderIndex(entity.getOrderIndex())
                .build();
    }

    @Override
    public List<ModuleLessonMappingDto> toDtoList(List<ModuleLessonMapping> entities) {
        if (entities == null) {
            return null;
        }

        return entities.stream()
                .map(this::mapFrom)
                .collect(Collectors.toList());
    }
}
