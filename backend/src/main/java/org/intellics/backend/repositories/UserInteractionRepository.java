package org.intellics.backend.repositories;

import org.intellics.backend.domain.entities.InteractionType;
import org.intellics.backend.domain.entities.UserInteraction;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

@Repository
public interface UserInteractionRepository extends JpaRepository<UserInteraction, UUID> {

    @Query("""
        SELECT DISTINCT ui FROM UserInteraction ui
        LEFT JOIN FETCH ui.session s
        LEFT JOIN FETCH ui.user u
        LEFT JOIN FETCH ui.module m
        LEFT JOIN FETCH ui.lesson l
        LEFT JOIN FETCH ui.question q
        LEFT JOIN FETCH ui.scaffold sc
        LEFT JOIN InteractionKCMapping ikm ON ui.interaction_id = ikm.interaction.interaction_id
        WHERE (:userId IS NULL OR ui.user.user_id = :userId)
        AND (:sessionId IS NULL OR ui.session.session_id = :sessionId)
        AND (:moduleId IS NULL OR ui.module.module_id = :moduleId)
        AND (:lessonId IS NULL OR ui.lesson.lesson_id = :lessonId)
        AND (:questionId IS NULL OR ui.question.question_id = :questionId)
        AND (:scaffoldId IS NULL OR ui.scaffold.scaffold_id = :scaffoldId)
        AND (:kcId IS NULL OR ikm.knowledgeComponent.kc_id = :kcId)
        AND (:interactionType IS NULL OR ui.interactionType = :interactionType)
        AND (:isCorrect IS NULL OR ui.is_correct = :isCorrect)
        AND (:timestampAfter IS NULL OR ui.timestamp >= :timestampAfter)
        AND (:timestampBefore IS NULL OR ui.timestamp <= :timestampBefore)
        ORDER BY ui.timestamp DESC
        """)
    Page<UserInteraction> findWithFilters(
        @Param("userId") UUID userId,
        @Param("sessionId") UUID sessionId,
        @Param("moduleId") UUID moduleId,
        @Param("lessonId") UUID lessonId,
        @Param("questionId") UUID questionId,
        @Param("scaffoldId") UUID scaffoldId,
        @Param("kcId") UUID kcId,
        @Param("interactionType") InteractionType interactionType,
        @Param("isCorrect") Boolean isCorrect,
        @Param("timestampAfter") Instant timestampAfter,
        @Param("timestampBefore") Instant timestampBefore,
        Pageable pageable
    );

    /**
     * Count interactions for a specific session
     */
    @Query(value = "SELECT COUNT(*) FROM user_interactions WHERE session_id = :sessionId", nativeQuery = true)
    long countBySessionId(@Param("sessionId") UUID sessionId);
    
    /**
     * Find all interactions for a user ordered by timestamp
     */
    @Query("""
        SELECT ui FROM UserInteraction ui
        LEFT JOIN FETCH ui.session s
        LEFT JOIN FETCH ui.user u
        LEFT JOIN FETCH ui.module m
        LEFT JOIN FETCH ui.lesson l
        LEFT JOIN FETCH ui.question q
        LEFT JOIN FETCH ui.scaffold sc
        WHERE ui.user.user_id = :userId
        ORDER BY ui.timestamp ASC
        """)
    List<UserInteraction> findByUserIdOrderByTimestamp(@Param("userId") UUID userId);
    
    /**
     * Find the earliest mastery_before value for each KC for a user
     * This is used to initialize replay with historical mastery values
     */
    @Query("""
        SELECT ikm.knowledgeComponent.kc_id, ikm.kcMasteryBefore
        FROM InteractionKCMapping ikm
        JOIN ikm.interaction ui
        WHERE ui.user.user_id = :userId
        AND ikm.kcMasteryBefore IS NOT NULL
        AND ui.timestamp = (
            SELECT MIN(ui2.timestamp)
            FROM UserInteraction ui2
            JOIN InteractionKCMapping ikm2 ON ui2.interaction_id = ikm2.interaction.interaction_id
            WHERE ui2.user.user_id = :userId
            AND ikm2.knowledgeComponent.kc_id = ikm.knowledgeComponent.kc_id
            AND ikm2.kcMasteryBefore IS NOT NULL
        )
        """)
    List<Object[]> findEarliestMasteryBeforeByUserId(@Param("userId") UUID userId);
}
