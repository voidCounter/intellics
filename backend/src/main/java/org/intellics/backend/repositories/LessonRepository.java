package org.intellics.backend.repositories;

import org.intellics.backend.domain.entities.Lesson;
import org.intellics.backend.domain.dto.LessonTitleProjection;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface LessonRepository extends CrudRepository<Lesson, UUID> {
    
    /**
     * Fetch only lesson IDs and names for efficient dropdown usage
     * This avoids loading the full lesson content from the database
     * Uses Spring Data JPA projection for better performance and type safety
     */
    @Query("SELECT l.lesson_id as lesson_id, l.lesson_name as lesson_name FROM Lesson l ORDER BY l.lesson_name")
    List<LessonTitleProjection> findLessonTitlesOnly();
}
