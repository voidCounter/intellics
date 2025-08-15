package org.intellics.backend.repositories;

import java.util.List;
import java.util.UUID;
import org.intellics.backend.domain.entities.QuestionEntity;
import org.intellics.backend.domain.dto.QuestionTitleProjection;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface QuestionRepository extends JpaRepository<QuestionEntity, UUID>,
    PagingAndSortingRepository<QuestionEntity, UUID> {
    
    /**
     * Fetch only question IDs and text for efficient dropdown usage
     * This avoids loading the full question content from the database
     * Uses Spring Data JPA projection for better performance and type safety
     */
    @Query("SELECT q.question_id as question_id, q.question_text as question_text FROM QuestionEntity q ORDER BY q.question_text")
    List<QuestionTitleProjection> findQuestionTitlesOnly();
}
