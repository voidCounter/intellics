package org.intellics.backend.domain.dto;

import java.util.UUID;

/**
 * Spring Data JPA projection interface for lesson titles
 * This is more efficient than using Object[] as it provides type safety
 * and better performance
 */
public interface LessonTitleProjection {
    UUID getLesson_id();
    String getLesson_name();
}
