package org.intellics.backend.mappers.impl;

import org.intellics.backend.domain.dto.ModuleKCMappingDto;
import org.intellics.backend.domain.entities.KnowledgeComponent;
import org.intellics.backend.domain.entities.ModuleKCMapping;
import org.intellics.backend.domain.entities.ModuleKCMappingId;
import org.intellics.backend.domain.entities.ModuleKCPrerequisite;
import org.intellics.backend.mappers.ModuleKCMappingMapper;
import org.intellics.backend.repositories.KnowledgeComponentRepository;
import org.intellics.backend.repositories.ModuleKCPrerequisiteRepository;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

@Component
public class ModuleKCMappingMapperImpl implements ModuleKCMappingMapper {

    private final KnowledgeComponentRepository knowledgeComponentRepository;
    private final ModuleKCPrerequisiteRepository moduleKCPrerequisiteRepository;

    public ModuleKCMappingMapperImpl(ModelMapper modelMapper, 
                                   KnowledgeComponentRepository knowledgeComponentRepository,
                                   ModuleKCPrerequisiteRepository moduleKCPrerequisiteRepository) {
        this.knowledgeComponentRepository = knowledgeComponentRepository;
        this.moduleKCPrerequisiteRepository = moduleKCPrerequisiteRepository;
    }

    @Override
    public ModuleKCMappingDto mapTo(ModuleKCMapping moduleKCMapping) {
        ModuleKCMappingDto dto = ModuleKCMappingDto.builder()
                .moduleId(moduleKCMapping.getModule().getModule_id())
                .kcId(moduleKCMapping.getKnowledgeComponent().getKc_id())
                .build();

        // Get prerequisites from the ModuleKCPrerequisite table
        List<UUID> prerequisiteKcIds = StreamSupport.stream(moduleKCPrerequisiteRepository.findAll().spliterator(), false)
                .filter(p -> p.getId().getModuleId().equals(moduleKCMapping.getModule().getModule_id()) 
                         && p.getId().getKcId().equals(moduleKCMapping.getKnowledgeComponent().getKc_id()))
                .map(p -> p.getId().getPrerequisiteKcId())
                .collect(Collectors.toList());
        
        dto.setPrerequisiteKcIds(prerequisiteKcIds);
        return dto;
    }

    @Override
    public ModuleKCMapping mapFrom(ModuleKCMappingDto moduleKCMappingDto) {
        ModuleKCMapping entity = ModuleKCMapping.builder()
                .mappingId(ModuleKCMappingId.builder()
                        .moduleId(moduleKCMappingDto.getModuleId())
                        .kcId(moduleKCMappingDto.getKcId())
                        .build())
                .build();

        // Module and KnowledgeComponent will be set in the service layer based on IDs
        // Prerequisites are handled separately in the service layer
        return entity;
    }
}
