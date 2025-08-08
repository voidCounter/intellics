package org.intellics.backend.mappers.impl;

import org.intellics.backend.domain.dto.ModuleKCMappingDto;
import org.intellics.backend.domain.entities.KnowledgeComponent;
import org.intellics.backend.domain.entities.ModuleKCMapping;
import org.intellics.backend.domain.entities.ModuleKCMappingId;
import org.intellics.backend.mappers.ModuleKCMappingMapper;
import org.intellics.backend.repositories.KnowledgeComponentRepository;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import java.util.Collections;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Component
public class ModuleKCMappingMapperImpl implements ModuleKCMappingMapper {

    private final KnowledgeComponentRepository knowledgeComponentRepository;

    public ModuleKCMappingMapperImpl(ModelMapper modelMapper, KnowledgeComponentRepository knowledgeComponentRepository) {
        this.knowledgeComponentRepository = knowledgeComponentRepository;
    }

    @Override
    public ModuleKCMappingDto mapTo(ModuleKCMapping moduleKCMapping) {
        ModuleKCMappingDto dto = ModuleKCMappingDto.builder()
                .moduleId(moduleKCMapping.getModule().getModule_id())
                .kcId(moduleKCMapping.getKnowledgeComponent().getKc_id())
                .build();

        if (moduleKCMapping.getPrerequisiteKnowledgeComponents() != null) {
            dto.setPrerequisiteKcIds(moduleKCMapping.getPrerequisiteKnowledgeComponents().stream()
                .map(KnowledgeComponent::getKc_id)
                .collect(Collectors.toList()));
        } else {
            dto.setPrerequisiteKcIds(Collections.emptyList());
        }
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
        // Prerequisite KCs are handled below

        if (moduleKCMappingDto.getPrerequisiteKcIds() != null && !moduleKCMappingDto.getPrerequisiteKcIds().isEmpty()) {
            Set<KnowledgeComponent> prerequisites = moduleKCMappingDto.getPrerequisiteKcIds().stream()
                .map(knowledgeComponentRepository::findById)
                .filter(Optional::isPresent)
                .map(Optional::get)
                .collect(Collectors.toSet());
            entity.setPrerequisiteKnowledgeComponents(prerequisites);
        } else {
            entity.setPrerequisiteKnowledgeComponents(Collections.emptySet());
        }
        return entity;
    }
}
