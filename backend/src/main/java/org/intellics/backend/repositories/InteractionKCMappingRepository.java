package org.intellics.backend.repositories;

import org.intellics.backend.domain.entities.InteractionKCMapping;
import org.intellics.backend.domain.entities.InteractionKCMappingId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface InteractionKCMappingRepository extends JpaRepository<InteractionKCMapping, InteractionKCMappingId> {

    /**
     * Find all KC mappings for a specific interaction
     */
    @Query("""
        SELECT ikm FROM InteractionKCMapping ikm
        JOIN FETCH ikm.knowledgeComponent kc
        WHERE ikm.interaction.interaction_id = :interactionId
        ORDER BY ikm.weight DESC
        """)
    List<InteractionKCMapping> findByInteractionId(@Param("interactionId") UUID interactionId);

    /**
     * Find all interactions for a specific KC (useful for KC-based analytics)
     */
    @Query("""
        SELECT ikm FROM InteractionKCMapping ikm
        JOIN FETCH ikm.interaction i
        WHERE ikm.knowledgeComponent.kc_id = :kcId
        ORDER BY i.timestamp DESC
        """)
    List<InteractionKCMapping> findByKnowledgeComponentId(@Param("kcId") UUID kcId);

    /**
     * Find KC mappings for a user and KC (useful for mastery tracking)
     */
    @Query("""
        SELECT ikm FROM InteractionKCMapping ikm
        JOIN FETCH ikm.interaction i
        WHERE ikm.knowledgeComponent.kc_id = :kcId
        AND i.user.user_id = :userId
        ORDER BY i.timestamp DESC
        """)
    List<InteractionKCMapping> findByUserIdAndKcId(
        @Param("userId") UUID userId, 
        @Param("kcId") UUID kcId
    );
}
