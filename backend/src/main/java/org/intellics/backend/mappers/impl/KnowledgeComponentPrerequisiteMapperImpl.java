package org.intellics.backend.mappers.impl;

import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentPrerequisiteDto;
import org.intellics.backend.domain.entities.KnowledgeComponent;
import org.intellics.backend.mappers.KnowledgeComponentPrerequisiteMapper;
import org.intellics.backend.mappers.Mapper;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
public class KnowledgeComponentPrerequisiteMapperImpl implements Mapper<KnowledgeComponentPrerequisiteDto, KnowledgeComponent> {

    private final ModelMapper modelMapper;

    public KnowledgeComponentPrerequisiteMapperImpl(ModelMapper modelMapper) {
        this.modelMapper = modelMapper;
    }

    @Override
    public KnowledgeComponentPrerequisiteDto mapTo(KnowledgeComponent knowledgeComponent) {
        return modelMapper.map(knowledgeComponent, KnowledgeComponentPrerequisiteDto.class);
    }

    @Override
    public KnowledgeComponent mapFrom(KnowledgeComponentPrerequisiteDto knowledgeComponentPrerequisiteDto) {
        return modelMapper.map(knowledgeComponentPrerequisiteDto, KnowledgeComponent.class);
    }
}