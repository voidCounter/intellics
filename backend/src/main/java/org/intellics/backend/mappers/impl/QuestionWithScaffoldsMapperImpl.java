package org.intellics.backend.mappers.impl;

import org.intellics.backend.domain.dto.MultipleChoiceQuestionWithScaffoldsDto;
import org.intellics.backend.domain.dto.QuestionWithScaffoldsDto;
import org.intellics.backend.domain.dto.WrittenQuestionWithScaffoldsDto;
import org.intellics.backend.domain.entities.MultipleChoiceQuestionEntity;
import org.intellics.backend.domain.entities.QuestionEntity;
import org.intellics.backend.domain.entities.WrittenQuestionEntity;
import org.intellics.backend.mappers.QuestionWithScaffoldsMapper;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
public class QuestionWithScaffoldsMapperImpl implements QuestionWithScaffoldsMapper {
    private final ModelMapper modelMapper;
    
    public QuestionWithScaffoldsMapperImpl(ModelMapper modelMapper) {
        this.modelMapper = modelMapper;
    }
    
    @Override
    public QuestionEntity mapFrom(QuestionWithScaffoldsDto questionDto) {
        if (questionDto instanceof MultipleChoiceQuestionWithScaffoldsDto) {
            return modelMapper.map(questionDto, MultipleChoiceQuestionEntity.class);
        } else if (questionDto instanceof WrittenQuestionWithScaffoldsDto) {
            return modelMapper.map(questionDto, WrittenQuestionEntity.class);
        }
        throw new IllegalArgumentException(
            "Unknown QuestionWithScaffoldsDto type: " + questionDto.getClass().getName());
    }
    
    @Override
    public QuestionWithScaffoldsDto mapTo(QuestionEntity questionEntity) {
        if (questionEntity instanceof MultipleChoiceQuestionEntity) {
            return modelMapper.map(questionEntity, MultipleChoiceQuestionWithScaffoldsDto.class);
        } else if (questionEntity instanceof WrittenQuestionEntity) {
            return modelMapper.map(questionEntity, WrittenQuestionWithScaffoldsDto.class);
        }
        throw new IllegalArgumentException(
            "Unknown Question entity type: " + questionEntity.getClass().getName());
    }
}
