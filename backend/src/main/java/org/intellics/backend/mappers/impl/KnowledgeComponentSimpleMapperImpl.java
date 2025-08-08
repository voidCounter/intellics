package org.intellics.backend.mappers.impl;

import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentSimpleDto;
import org.intellics.backend.domain.entities.KnowledgeComponent;
import org.intellics.backend.mappers.Mapper;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
public class KnowledgeComponentSimpleMapperImpl implements Mapper<KnowledgeComponentSimpleDto, KnowledgeComponent> {

    private final ModelMapper modelMapper;

    public KnowledgeComponentSimpleMapperImpl(ModelMapper modelMapper) {
        this.modelMapper = modelMapper;
    }

    @Override
    public KnowledgeComponentSimpleDto mapTo(KnowledgeComponent knowledgeComponent) {
        return modelMapper.map(knowledgeComponent, KnowledgeComponentSimpleDto.class);
    }

    @Override
    public KnowledgeComponent mapFrom(KnowledgeComponentSimpleDto knowledgeComponentSimpleDto) {
        return modelMapper.map(knowledgeComponentSimpleDto, KnowledgeComponent.class);
    }
}
