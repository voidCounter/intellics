package org.intellics.backend.services;

import org.intellics.backend.domain.dto.UserInteractionDto;
import org.intellics.backend.domain.dto.UserInteractionRequestDto;
import org.intellics.backend.domain.entities.InteractionType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.time.Instant;
import java.util.UUID;

public interface UserInteractionService {
    
    /**
     * Creates a new user interaction
     *
     * @param request The interaction request data
     * @return The created interaction DTO
     */
    UserInteractionDto createInteraction(UserInteractionRequestDto request);
    
    /**
     * Logs when a question is presented to a user
     *
     * @param userId The user ID
     * @param questionId The question ID that was presented
     * @param lessonId Optional lesson ID for context
     * @param moduleId Optional module ID for context
     */
    void logQuestionPresented(UUID userId, UUID questionId, UUID lessonId, UUID moduleId);
    
    /**
     * Retrieves user interactions with comprehensive filtering and pagination
     *
     * @param userId Filter by user ID (optional)
     * @param sessionId Filter by session ID (optional)
     * @param moduleId Filter by module ID (optional)
     * @param lessonId Filter by lesson ID (optional)
     * @param questionId Filter by question ID (optional)
     * @param scaffoldId Filter by scaffold ID (optional)
     * @param kcId Filter by knowledge component ID (optional)
     * @param interactionType Filter by interaction type (optional)
     * @param isCorrect Filter by correctness for quiz answers (optional)
     * @param timestampAfter Filter interactions after this timestamp (optional)
     * @param timestampBefore Filter interactions before this timestamp (optional)
     * @param pageable Pagination parameters
     * @return Page of UserInteractionDto with filters applied
     */
    Page<UserInteractionDto> getInteractionsWithFilters(
        UUID userId,
        UUID sessionId,
        UUID moduleId,
        UUID lessonId,
        UUID questionId,
        UUID scaffoldId,
        UUID kcId,
        InteractionType interactionType,
        Boolean isCorrect,
        Instant timestampAfter,
        Instant timestampBefore,
        Pageable pageable
    );
}
