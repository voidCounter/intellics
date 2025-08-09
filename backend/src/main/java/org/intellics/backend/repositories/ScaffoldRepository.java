package org.intellics.backend.repositories;

import java.util.List;
import java.util.UUID;
import org.intellics.backend.domain.entities.Scaffold;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ScaffoldRepository extends JpaRepository<Scaffold, UUID> {
    
    @Query("SELECT s FROM Scaffold s WHERE s.question.question_id = :questionId ORDER BY s.order_index")
    List<Scaffold> findByQuestionQuestionIdOrderByOrderIndex(@Param("questionId") UUID questionId);
    
    @Query("SELECT COUNT(s) FROM Scaffold s WHERE s.question.question_id = :questionId")
    int countByQuestionQuestionId(@Param("questionId") UUID questionId);
    
    @Query("SELECT s FROM Scaffold s WHERE s.question.question_id = :questionId AND s.scaffold_id = :scaffoldId")
    Scaffold findByQuestionQuestionIdAndScaffoldId(@Param("questionId") UUID questionId, @Param("scaffoldId") UUID scaffoldId);
    
    @Modifying
    @Query("DELETE FROM Scaffold s WHERE s.question.question_id = :questionId")
    void deleteByQuestionQuestionId(@Param("questionId") UUID questionId);
}
