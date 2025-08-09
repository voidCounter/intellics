package org.intellics.backend.mappers.impl;

import org.intellics.backend.domain.dto.MultipleChoiceQuestionDto;
import org.intellics.backend.domain.dto.QuestionDto;
import org.intellics.backend.domain.dto.WrittenQuestionDto;
import org.intellics.backend.domain.entities.MultipleChoiceQuestionEntity;
import org.intellics.backend.domain.entities.QuestionEntity;
import org.intellics.backend.domain.entities.WrittenQuestionEntity;
import org.intellics.backend.mappers.Mapper;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
public class QuestionMapperImpl implements Mapper<QuestionDto, QuestionEntity> {
    private final ModelMapper modelMapper;
    
    public QuestionMapperImpl(ModelMapper modelMapper) {
        this.modelMapper = modelMapper;
    }
    
    @Override
    public QuestionDto mapTo(QuestionEntity questionEntity) {
        if (questionEntity instanceof MultipleChoiceQuestionEntity) {
            return modelMapper.map(questionEntity, MultipleChoiceQuestionDto.class);
        } else if (questionEntity instanceof WrittenQuestionEntity) {
            return modelMapper.map(questionEntity, WrittenQuestionDto.class);
        }
        throw new IllegalArgumentException(
            "Unknown Question entity type: " + questionEntity.getClass().getName());
    }
    
    @Override
    public QuestionEntity mapFrom(QuestionDto questionDto) {
        if (questionDto instanceof MultipleChoiceQuestionDto) {
            return modelMapper.map(questionDto, MultipleChoiceQuestionEntity.class);
        } else if (questionDto instanceof WrittenQuestionDto) {
            return modelMapper.map(questionDto, WrittenQuestionEntity.class);
        }
        throw new IllegalArgumentException(
            "Unknown QuestionDto type: " + questionDto.getClass().getName());
    }
}
