package org.intellics.backend.mappers;

import org.intellics.backend.domain.dto.ModuleLessonMappingDto;
import org.intellics.backend.domain.entities.ModuleLessonMapping;

import java.util.List;

public interface ModuleLessonMappingMapper extends Mapper<ModuleLessonMapping, ModuleLessonMappingDto> {
    List<ModuleLessonMappingDto> toDtoList(List<ModuleLessonMapping> entities);
}
