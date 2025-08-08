package org.intellics.backend.repositories;

import org.intellics.backend.domain.entities.LessonKCMapping;
import org.intellics.backend.domain.entities.LessonKCMappingId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface LessonKCMappingRepository extends JpaRepository<LessonKCMapping, LessonKCMappingId> {
    
    @Query("SELECT lkm FROM LessonKCMapping lkm WHERE lkm.lesson.id = :lessonId")
    List<LessonKCMapping> findByLessonId(@Param("lessonId") UUID lessonId);
    
    @Query("SELECT lkm FROM LessonKCMapping lkm WHERE lkm.knowledge_component.kc_id = :kcId")
    List<LessonKCMapping> findByKnowledgeComponentId(@Param("kcId") UUID kcId);
    
    @Query("SELECT COUNT(lkm) > 0 FROM LessonKCMapping lkm WHERE lkm.lesson.lesson_id = :lessonId AND lkm.knowledge_component.kc_id = :kcId")
    boolean existsByLessonIdAndKnowledgeComponentId(@Param("lessonId") UUID lessonId, @Param("kcId") UUID kcId);
}
