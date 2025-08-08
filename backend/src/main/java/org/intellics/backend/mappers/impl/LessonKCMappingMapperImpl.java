package org.intellics.backend.mappers.impl;

import org.intellics.backend.domain.dto.LessonKCMappingDto;
import org.intellics.backend.domain.entities.LessonKCMapping;
import org.intellics.backend.domain.entities.LessonKCMappingId;
import org.intellics.backend.mappers.LessonKCMappingMapper;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;

@Component
public class LessonKCMappingMapperImpl implements LessonKCMappingMapper {

    public LessonKCMappingMapperImpl(ModelMapper modelMapper) {
        // ModelMapper is injected but not used in this implementation
    }

    @Override
    public LessonKCMappingDto mapTo(LessonKCMapping lessonKCMapping) {
        return LessonKCMappingDto.builder()
                .lessonId(lessonKCMapping.getLesson().getLesson_id())
                .kcId(lessonKCMapping.getKnowledge_component().getKc_id())
                .targetMastery(lessonKCMapping.getTarget_mastery())
                .build();
    }

    @Override
    public LessonKCMapping mapFrom(LessonKCMappingDto lessonKCMappingDto) {
        return LessonKCMapping.builder()
                .mapping_id(LessonKCMappingId.builder()
                        .lesson_id(lessonKCMappingDto.getLessonId())
                        .kc_id(lessonKCMappingDto.getKcId())
                        .build())
                .target_mastery(lessonKCMappingDto.getTargetMastery())
                .build();
    }
}
