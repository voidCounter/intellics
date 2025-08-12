package org.intellics.backend.domain.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.intellics.backend.domain.entities.InteractionType;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserInteractionRequestDto {
    
    @NotNull(message = "Session ID is required")
    private UUID sessionId;
    
    @NotNull(message = "User ID is required")
    private UUID userId;
    
    private UUID moduleId;  // Optional - can be derived from lesson
    
    private UUID lessonId;  // Required for lesson interactions
    
    private UUID questionId;  // Required for question interactions
    
    private UUID scaffoldId;  // Optional - for scaffold interactions
    
    @NotNull(message = "Interaction type is required")
    private InteractionType interactionType;
    
    private String studentAnswer;  // For quiz/scaffold answers
    
    private Boolean isCorrect;  // For quiz/scaffold answers
    
    @PositiveOrZero(message = "Hint level must be zero or positive")
    private Integer hintLevel;  // For hint requests
    
    @PositiveOrZero(message = "Time spent must be zero or positive")
    private Integer timeSpentSeconds;  // Optional thinking time
}
