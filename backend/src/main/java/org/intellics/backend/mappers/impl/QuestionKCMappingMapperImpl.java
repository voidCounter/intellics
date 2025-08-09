package org.intellics.backend.mappers.impl;

import org.intellics.backend.domain.dto.QuestionKCMappingDto;
import org.intellics.backend.domain.entities.QuestionKCMapping;
import org.intellics.backend.mappers.QuestionKCMappingMapper;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
public class QuestionKCMappingMapperImpl implements QuestionKCMappingMapper {
    private final ModelMapper modelMapper;
    
    public QuestionKCMappingMapperImpl(ModelMapper modelMapper) {
        this.modelMapper = modelMapper;
    }
    
    @Override
    public QuestionKCMappingDto mapTo(QuestionKCMapping questionKCMapping) {
        QuestionKCMappingDto dto = new QuestionKCMappingDto();
        dto.setId(questionKCMapping.getKnowledge_component().getKc_id());
        dto.setKcCode(questionKCMapping.getKnowledge_component().getKc_name());
        dto.setKcName(questionKCMapping.getKnowledge_component().getKc_name());
        return dto;
    }
    
    @Override
    public QuestionKCMapping mapFrom(QuestionKCMappingDto questionKCMappingDto) {
        // This method is typically not used for mapping DTOs, 
        // as mappings are created via the service layer with specific logic
        return modelMapper.map(questionKCMappingDto, QuestionKCMapping.class);
    }
}
