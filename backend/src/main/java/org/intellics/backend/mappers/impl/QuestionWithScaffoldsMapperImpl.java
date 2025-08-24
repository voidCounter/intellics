package org.intellics.backend.mappers.impl;

import org.intellics.backend.domain.dto.MultipleChoiceQuestionWithScaffoldsDto;
import org.intellics.backend.domain.dto.QuestionWithScaffoldsDto;
import org.intellics.backend.domain.dto.WrittenQuestionWithScaffoldsDto;
import org.intellics.backend.domain.entities.MultipleChoiceQuestionEntity;
import org.intellics.backend.domain.entities.QuestionEntity;
import org.intellics.backend.domain.entities.WrittenQuestionEntity;
import org.intellics.backend.mappers.QuestionWithScaffoldsMapper;
import org.intellics.backend.mappers.ScaffoldMapper;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import java.util.stream.Collectors;

@Component
public class QuestionWithScaffoldsMapperImpl implements QuestionWithScaffoldsMapper {
    private final ModelMapper modelMapper;
    private final ScaffoldMapper scaffoldMapper;
    
    public QuestionWithScaffoldsMapperImpl(ModelMapper modelMapper, ScaffoldMapper scaffoldMapper) {
        this.modelMapper = modelMapper;
        this.scaffoldMapper = scaffoldMapper;
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
        QuestionWithScaffoldsDto questionDto;
        
        if (questionEntity instanceof MultipleChoiceQuestionEntity) {
            questionDto = modelMapper.map(questionEntity, MultipleChoiceQuestionWithScaffoldsDto.class);
        } else if (questionEntity instanceof WrittenQuestionEntity) {
            questionDto = modelMapper.map(questionEntity, WrittenQuestionWithScaffoldsDto.class);
        } else {
            throw new IllegalArgumentException(
                "Unknown Question entity type: " + questionEntity.getClass().getName());
        }
        
        // Manually map scaffolds using our custom ScaffoldMapper to ensure correct field mapping
        if (questionEntity.getScaffolds() != null) {
            questionDto.setScaffolds(
                questionEntity.getScaffolds().stream()
                    .map(scaffoldMapper::mapTo)
                    .collect(Collectors.toList())
            );
        }
        
        return questionDto;
    }
}
