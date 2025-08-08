package org.intellics.backend.repositories;

import org.intellics.backend.domain.entities.ModuleLessonMapping;
import org.intellics.backend.domain.entities.ModuleLessonMappingId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface ModuleLessonMappingRepository extends JpaRepository<ModuleLessonMapping, ModuleLessonMappingId> {
    
    @Query("SELECT m FROM ModuleLessonMapping m WHERE m.mappingId.moduleId = :moduleId")
    List<ModuleLessonMapping> findByModuleId(@Param("moduleId") UUID moduleId);
    
    @Query("SELECT m FROM ModuleLessonMapping m WHERE m.mappingId.lessonId = :lessonId")
    List<ModuleLessonMapping> findByLessonId(@Param("lessonId") UUID lessonId);
    
    @Query("SELECT COUNT(m) > 0 FROM ModuleLessonMapping m WHERE m.mappingId.moduleId = :moduleId AND m.mappingId.lessonId = :lessonId")
    boolean existsByModuleIdAndLessonId(@Param("moduleId") UUID moduleId, @Param("lessonId") UUID lessonId);
}
