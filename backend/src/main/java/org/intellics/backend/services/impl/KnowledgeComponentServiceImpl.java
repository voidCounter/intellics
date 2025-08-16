package org.intellics.backend.services.impl;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;
import java.util.ArrayList;

import org.intellics.backend.domain.dto.KnowledgeComponentWithRelationshipsDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentCreateDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentPatchDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentSimpleDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentUpdateDto;
import org.intellics.backend.domain.dto.BatchDeleteResponseDto;
import org.intellics.backend.domain.entities.KnowledgeComponent;
import org.intellics.backend.domain.entities.ModuleKCMapping;
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
import org.springframework.transaction.annotation.Transactional;

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
        // Get all KCs and filter by active status
        List<KnowledgeComponent> allKcs = knowledgeComponentRepository.findByIsActiveTrue();
        
        // Apply pagination manually since we're filtering by active status
        int start = (int) pageable.getOffset();
        int end = Math.min(start + pageable.getPageSize(), allKcs.size());
        
        List<KnowledgeComponent> pageContent = allKcs.subList(start, end);
        List<KnowledgeComponentSimpleDto> kcDtos = pageContent.stream()
                .map(knowledgeComponentSimpleMapper::mapTo)
                .collect(Collectors.toList());
        
        return new org.springframework.data.domain.PageImpl<>(
            kcDtos, 
            pageable, 
            allKcs.size()
        );
    }

    @Override
    public Optional<KnowledgeComponentSimpleDto> findOne(UUID id) {
        try {
            KnowledgeComponent kc = knowledgeComponentRepository.findByKcIdAndIsActiveTrue(id);
            return Optional.ofNullable(kc).map(knowledgeComponentSimpleMapper::mapTo);
        } catch (Exception e) {
            return Optional.empty();
        }
    }

    @Override
    public KnowledgeComponentSimpleDto updateKnowledgeComponent(UUID id, KnowledgeComponentUpdateDto knowledgeComponentUpdateDto) {
        
        // First check if the KC exists and is active
        KnowledgeComponent existingKc = knowledgeComponentRepository.findByKcIdAndIsActiveTrue(id);
        if (existingKc == null) {
            throw new RuntimeException("Knowledge Component not found or is inactive");
        }
        
        // Update only the fields that are provided
        if (knowledgeComponentUpdateDto.getKc_name() != null) {
            existingKc.setKc_name(knowledgeComponentUpdateDto.getKc_name());
        }
        if (knowledgeComponentUpdateDto.getDescription() != null) {
            existingKc.setDescription(knowledgeComponentUpdateDto.getDescription());
        }
        
        KnowledgeComponent updatedKnowledgeComponent = knowledgeComponentRepository.save(existingKc);
        return knowledgeComponentSimpleMapper.mapTo(updatedKnowledgeComponent);
    }

    @Override
    public void delete(UUID id) {
        knowledgeComponentRepository.deleteById(id);
    }

    @Override
    public boolean isExists(UUID id) {
        try {
            return knowledgeComponentRepository.findByKcIdAndIsActiveTrue(id) != null;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public KnowledgeComponentSimpleDto patchKnowledgeComponent(UUID id, KnowledgeComponentPatchDto knowledgeComponentPatchDto) {
        KnowledgeComponent existingKc = knowledgeComponentRepository.findByKcIdAndIsActiveTrue(id);
        if (existingKc == null) {
            throw new RuntimeException("Knowledge Component not found or is inactive");
        }
        
        Optional.ofNullable(knowledgeComponentPatchDto.getKc_name()).ifPresent(existingKc::setKc_name);
        Optional.ofNullable(knowledgeComponentPatchDto.getDescription()).ifPresent(existingKc::setDescription);
        
        KnowledgeComponent updatedKc = knowledgeComponentRepository.save(existingKc);
        return knowledgeComponentSimpleMapper.mapTo(updatedKc);
    }

    @Override
    public Page<KnowledgeComponentWithRelationshipsDto> findAllWithRelationshipsPaginated(Pageable pageable) {
        // Get all active KCs and filter by active status
        List<KnowledgeComponent> allKcs = knowledgeComponentRepository.findByIsActiveTrue();
        
        // Apply pagination manually since we're filtering by active status
        int start = (int) pageable.getOffset();
        int end = Math.min(start + pageable.getPageSize(), allKcs.size());
        
        List<KnowledgeComponent> pageContent = allKcs.subList(start, end);
        List<KnowledgeComponentWithRelationshipsDto> kcDtos = pageContent.stream()
                .map(this::buildKCWithRelationships)
                .collect(Collectors.toList());
        
        // Create a new Page with the DTOs while preserving pagination info
        return new org.springframework.data.domain.PageImpl<>(
            kcDtos, 
            pageable, 
            allKcs.size()
        );
    }

    @Override
    @Transactional
    public BatchDeleteResponseDto softDeleteBatch(List<UUID> ids) {
        List<UUID> successfullyDeleted = new ArrayList<>();
        List<UUID> failedToDelete = new ArrayList<>();
        
        for (UUID id : ids) {
            try {
                if (knowledgeComponentRepository.findByKcIdAndIsActiveTrue(id) != null) {
                    softDelete(id);
                    successfullyDeleted.add(id);
                    log.info("Successfully soft deleted KC with ID: {}", id);
                } else {
                    failedToDelete.add(id);
                    log.warn("Failed to soft delete KC with ID: {} - not found or already inactive", id);
                }
            } catch (Exception e) {
                failedToDelete.add(id);
                log.error("Error soft deleting KC with ID: {}", id, e);
            }
        }
        
        return new BatchDeleteResponseDto(
            ids.size(),
            successfullyDeleted.size(),
            failedToDelete.size(),
            successfullyDeleted,
            failedToDelete
        );
    }

    @Override
    @Transactional
    public void softDelete(UUID id) {
        KnowledgeComponent kc = knowledgeComponentRepository.findByKcIdAndIsActiveTrue(id);
        if (kc == null) {
            throw new RuntimeException("Knowledge Component not found or is already inactive");
        }
        
        kc.setIsActive(false);
        knowledgeComponentRepository.save(kc);
        log.info("Soft deleted KC with ID: {}", id);
    }

    @Override
    public boolean canHardDelete(UUID id) {
        // Check if KC has any mappings or is referenced anywhere
        // This would check lesson_kc_mapping, question_kc_mapping, etc.
        // For now, return false to prevent hard deletion
        return false;
    }

    @Override
    @Transactional
    public void hardDelete(UUID id) {
        if (!canHardDelete(id)) {
            throw new RuntimeException("Cannot hard delete KC - it has active references");
        }
        
        knowledgeComponentRepository.deleteById(id);
        log.info("Hard deleted KC with ID: {}", id);
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
