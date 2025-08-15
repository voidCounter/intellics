package org.intellics.backend.domain.dto;

import java.util.UUID;

/**
 * Spring Data JPA projection interface for question titles
 * This is more efficient than using Object[] as it provides type safety
 * and better performance
 */
public interface QuestionTitleProjection {
    UUID getQuestion_id();
    String getQuestion_text();
}
