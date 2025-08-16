package org.intellics.backend.services;

import java.util.Optional;
import java.util.UUID;
import java.util.List;

import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentCreateDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentPatchDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentSimpleDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentUpdateDto;
import org.intellics.backend.domain.dto.KnowledgeComponentWithRelationshipsDto;
import org.intellics.backend.domain.dto.BatchDeleteResponseDto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface KnowledgeComponentService {
    KnowledgeComponentSimpleDto createKnowledgeComponent(KnowledgeComponentCreateDto knowledgeComponentCreateDto);

    Page<KnowledgeComponentSimpleDto> findAllPaginated(Pageable pageable);

    Optional<KnowledgeComponentSimpleDto> findOne(UUID id);

    KnowledgeComponentSimpleDto updateKnowledgeComponent(UUID id, KnowledgeComponentUpdateDto knowledgeComponentUpdateDto);

    void delete(UUID id);

    boolean isExists(UUID id);

    KnowledgeComponentSimpleDto patchKnowledgeComponent(UUID id, KnowledgeComponentPatchDto knowledgeComponentPatchDto);
    
    Page<KnowledgeComponentWithRelationshipsDto> findAllWithRelationshipsPaginated(Pageable pageable);

    // Soft delete methods
    BatchDeleteResponseDto softDeleteBatch(List<UUID> ids);
    void softDelete(UUID id);
    boolean canHardDelete(UUID id);
    void hardDelete(UUID id);
}
