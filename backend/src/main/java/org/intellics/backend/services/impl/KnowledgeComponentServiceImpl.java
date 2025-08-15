package org.intellics.backend.services.impl;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import org.intellics.backend.domain.dto.KnowledgeComponentWithRelationshipsDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentCreateDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentPatchDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentSimpleDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentUpdateDto;
import org.intellics.backend.domain.entities.KnowledgeComponent;
import org.intellics.backend.mappers.Mapper;
import org.intellics.backend.repositories.KnowledgeComponentRepository;
import org.intellics.backend.repositories.LessonKCMappingRepository;
import org.intellics.backend.repositories.ModuleKCMappingRepository;
import org.intellics.backend.repositories.QuestionKCMappingRepository;
import org.intellics.backend.services.KnowledgeComponentService;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class KnowledgeComponentServiceImpl implements KnowledgeComponentService {

    private final KnowledgeComponentRepository knowledgeComponentRepository;
    private final ModuleKCMappingRepository moduleKCMappingRepository;
    private final LessonKCMappingRepository lessonKCMappingRepository;
    private final QuestionKCMappingRepository questionKCMappingRepository;
    private final Mapper<KnowledgeComponentSimpleDto, KnowledgeComponent> knowledgeComponentSimpleMapper;
    private final ModelMapper modelMapper;

    public KnowledgeComponentServiceImpl(
            KnowledgeComponentRepository knowledgeComponentRepository,
            ModuleKCMappingRepository moduleKCMappingRepository,
            LessonKCMappingRepository lessonKCMappingRepository,
            QuestionKCMappingRepository questionKCMappingRepository,
            Mapper<KnowledgeComponentSimpleDto, KnowledgeComponent> knowledgeComponentSimpleMapper,
            ModelMapper modelMapper) {
        this.knowledgeComponentRepository = knowledgeComponentRepository;
        this.moduleKCMappingRepository = moduleKCMappingRepository;
        this.lessonKCMappingRepository = lessonKCMappingRepository;
        this.questionKCMappingRepository = questionKCMappingRepository;
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
    public Page<KnowledgeComponentSimpleDto> findAllPaginated(Pageable pageable) {
        Page<KnowledgeComponent> kcPage = knowledgeComponentRepository.findAll(pageable);
        List<KnowledgeComponentSimpleDto> kcDtos = kcPage.getContent().stream()
                .map(knowledgeComponentSimpleMapper::mapTo)
                .collect(Collectors.toList());
        
        return new org.springframework.data.domain.PageImpl<>(
            kcDtos, 
            pageable, 
            kcPage.getTotalElements()
        );
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

    @Override
    public Page<KnowledgeComponentWithRelationshipsDto> findAllWithRelationshipsPaginated(Pageable pageable) {
        Page<KnowledgeComponent> kcPage = knowledgeComponentRepository.findAll(pageable);
        List<KnowledgeComponentWithRelationshipsDto> kcDtos = kcPage.getContent().stream()
                .map(this::buildKCWithRelationships)
                .collect(Collectors.toList());
        
        // Create a new Page with the DTOs while preserving pagination info
        return new org.springframework.data.domain.PageImpl<>(
            kcDtos, 
            pageable, 
            kcPage.getTotalElements()
        );
    }

    private KnowledgeComponentWithRelationshipsDto buildKCWithRelationships(KnowledgeComponent kc) {
        // Get linked modules - need to find by KC ID since repository doesn't have findByKnowledgeComponent
        List<KnowledgeComponentWithRelationshipsDto.LinkedModuleDto> linkedModules = StreamSupport
                .stream(moduleKCMappingRepository.findAll().spliterator(), false)
                .filter(mapping -> mapping.getKnowledgeComponent().getKc_id().equals(kc.getKc_id()))
                .map(mapping -> KnowledgeComponentWithRelationshipsDto.LinkedModuleDto.builder()
                        .module_id(mapping.getModule().getModule_id())
                        .module_name(mapping.getModule().getModule_name())
                        .build())
                .collect(Collectors.toList());

        // Get linked lessons - use the existing findByKnowledgeComponentId method
        List<KnowledgeComponentWithRelationshipsDto.LinkedLessonDto> linkedLessons = lessonKCMappingRepository
                .findByKnowledgeComponentId(kc.getKc_id())
                .stream()
                .map(mapping -> KnowledgeComponentWithRelationshipsDto.LinkedLessonDto.builder()
                        .lesson_id(mapping.getLesson().getLesson_id())
                        .lesson_name(mapping.getLesson().getLesson_name())
                        .target_mastery(mapping.getTarget_mastery().doubleValue())
                        .build())
                .collect(Collectors.toList());

        // Get linked questions - need to find by KC ID since repository doesn't have findByKnowledgeComponent
        List<KnowledgeComponentWithRelationshipsDto.LinkedQuestionDto> linkedQuestions = StreamSupport
                .stream(questionKCMappingRepository.findAll().spliterator(), false)
                .filter(mapping -> mapping.getKnowledge_component().getKc_id().equals(kc.getKc_id()))
                .map(mapping -> KnowledgeComponentWithRelationshipsDto.LinkedQuestionDto.builder()
                        .question_id(mapping.getQuestion().getQuestion_id())
                        .question_text(mapping.getQuestion().getQuestion_text())
                        .weight(mapping.getWeight())
                        .build())
                .collect(Collectors.toList());

        return KnowledgeComponentWithRelationshipsDto.builder()
                .kc_id(kc.getKc_id())
                .kc_name(kc.getKc_name())
                .description(kc.getDescription())
                .linkedModules(linkedModules)
                .linkedLessons(linkedLessons)
                .linkedQuestions(linkedQuestions)
                .build();
    }
}
