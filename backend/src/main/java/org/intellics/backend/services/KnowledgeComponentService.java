package org.intellics.backend.services;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentCreateDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentPatchDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentSimpleDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentUpdateDto;

public interface KnowledgeComponentService {
    KnowledgeComponentSimpleDto createKnowledgeComponent(KnowledgeComponentCreateDto knowledgeComponentCreateDto);

    List<KnowledgeComponentSimpleDto> findAll();

    Optional<KnowledgeComponentSimpleDto> findOne(UUID id);

    KnowledgeComponentSimpleDto updateKnowledgeComponent(UUID id, KnowledgeComponentUpdateDto knowledgeComponentUpdateDto);

    void delete(UUID id);

    boolean isExists(UUID id);

    KnowledgeComponentSimpleDto patchKnowledgeComponent(UUID id, KnowledgeComponentPatchDto knowledgeComponentPatchDto);
}
