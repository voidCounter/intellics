package org.intellics.backend.mappers.impl;

import org.intellics.backend.domain.dto.LessonDto;
import org.intellics.backend.domain.entities.Lesson;
import org.intellics.backend.mappers.Mapper;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
public class LessonMapperImpl implements Mapper<LessonDto, Lesson> {

    private final ModelMapper modelMapper;

    public LessonMapperImpl(ModelMapper modelMapper) {
        this.modelMapper = modelMapper;
    }

    @Override
    public LessonDto mapTo(Lesson lesson) {
        return modelMapper.map(lesson, LessonDto.class);
    }

    @Override
    public Lesson mapFrom(LessonDto lessonDto) {
        return modelMapper.map(lessonDto, Lesson.class);
    }
}
