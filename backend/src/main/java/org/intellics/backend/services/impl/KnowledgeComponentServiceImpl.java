package org.intellics.backend.services.impl;

import lombok.extern.slf4j.Slf4j;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentCreateDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentPatchDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentSimpleDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentUpdateDto;
import org.intellics.backend.domain.entities.KnowledgeComponent;
import org.intellics.backend.mappers.Mapper;
import org.intellics.backend.repositories.KnowledgeComponentRepository;
import org.intellics.backend.services.KnowledgeComponentService;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class KnowledgeComponentServiceImpl implements KnowledgeComponentService {

    private final KnowledgeComponentRepository knowledgeComponentRepository;
    private final Mapper<KnowledgeComponentSimpleDto, KnowledgeComponent> knowledgeComponentSimpleMapper;
    private final ModelMapper modelMapper;

    public KnowledgeComponentServiceImpl(KnowledgeComponentRepository knowledgeComponentRepository, Mapper<KnowledgeComponentSimpleDto,KnowledgeComponent> knowledgeComponentSimpleMapper, ModelMapper modelMapper) {
        this.knowledgeComponentRepository = knowledgeComponentRepository;
        this.knowledgeComponentSimpleMapper = knowledgeComponentSimpleMapper;
        this.modelMapper = modelMapper;
    }

    @Override
    public KnowledgeComponentSimpleDto createKnowledgeComponent(
        KnowledgeComponentCreateDto knowledgeComponentCreateDto) {
        KnowledgeComponent knowledgeComponent = modelMapper.map(knowledgeComponentCreateDto, KnowledgeComponent.class);
        
        KnowledgeComponent savedKnowledgeComponent = knowledgeComponentRepository.save(knowledgeComponent);
        log.info(savedKnowledgeComponent.toString());
        return knowledgeComponentSimpleMapper.mapTo(savedKnowledgeComponent);
    }

    @Override
    public List<KnowledgeComponentSimpleDto> findAll() {
        return knowledgeComponentRepository.findAll().stream()
                .map(knowledgeComponentSimpleMapper::mapTo)
                .collect(Collectors.toList());
    }

    @Override
    public Optional<KnowledgeComponentSimpleDto> findOne(UUID id) {
        return knowledgeComponentRepository.findById(id).map(knowledgeComponentSimpleMapper::mapTo);
    }

    @Override
    public KnowledgeComponentSimpleDto updateKnowledgeComponent(UUID id, KnowledgeComponentUpdateDto knowledgeComponentUpdateDto) {
        
        KnowledgeComponent knowledgeComponent = modelMapper.map(knowledgeComponentUpdateDto, KnowledgeComponent.class);
        knowledgeComponent.setKc_id(id);
        
        KnowledgeComponent updatedKnowledgeComponent = knowledgeComponentRepository.save(knowledgeComponent);
        return knowledgeComponentSimpleMapper.mapTo(updatedKnowledgeComponent);
    }

    @Override
    public void delete(UUID id) {
        knowledgeComponentRepository.deleteById(id);
    }

    @Override
    public boolean isExists(UUID id) {
        return knowledgeComponentRepository.existsById(id);
    }

    @Override
    public KnowledgeComponentSimpleDto patchKnowledgeComponent(UUID id, KnowledgeComponentPatchDto knowledgeComponentPatchDto) {
        return knowledgeComponentRepository.findById(id).map(existingKc -> {
            Optional.ofNullable(knowledgeComponentPatchDto.getKc_name()).ifPresent(existingKc::setKc_name);
            Optional.ofNullable(knowledgeComponentPatchDto.getDescription()).ifPresent(existingKc::setDescription);
            KnowledgeComponent updatedKc = knowledgeComponentRepository.save(existingKc);
            return knowledgeComponentSimpleMapper.mapTo(updatedKc);
        }).orElseThrow(() -> new RuntimeException("Knowledge Component not found"));
    }
}
