package org.intellics.backend.repositories;

import java.util.List;
import java.util.UUID;
import org.intellics.backend.domain.entities.QuestionKCMapping;
import org.intellics.backend.domain.entities.QuestionKCMappingId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface QuestionKCMappingRepository extends JpaRepository<QuestionKCMapping, QuestionKCMappingId> {
    
    @Query("SELECT qkm FROM QuestionKCMapping qkm WHERE qkm.mappingId.question_id = :questionId")
    List<QuestionKCMapping> findByQuestionId(@Param("questionId") UUID questionId);
    
    @Modifying
    @Query("DELETE FROM QuestionKCMapping qkm WHERE qkm.mappingId.question_id = :questionId AND qkm.mappingId.kc_id = :kcId")
    void deleteByQuestionIdAndKcId(@Param("questionId") UUID questionId, @Param("kcId") UUID kcId);
    
    @Query("SELECT COUNT(qkm) > 0 FROM QuestionKCMapping qkm WHERE qkm.mappingId.question_id = :questionId AND qkm.mappingId.kc_id = :kcId")
    boolean existsByQuestionIdAndKcId(@Param("questionId") UUID questionId, @Param("kcId") UUID kcId);
}
