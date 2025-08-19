package org.intellics.backend.domain.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
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
    @JsonProperty("session_id")
    private UUID sessionId;
    
    // user_id will be extracted from authentication context
    // private UUID userId; // REMOVED - extracted from security context
    
    @JsonProperty("module_id")
    private UUID moduleId;  // Optional - can be derived from lesson
    
    @JsonProperty("lesson_id")
    private UUID lessonId;  // Required for lesson interactions
    
    @JsonProperty("question_id")
    private UUID questionId;  // Required for question interactions
    
    @JsonProperty("scaffold_id")
    private UUID scaffoldId;  // Optional - for scaffold interactions
    
    @NotNull(message = "Interaction type is required")
    @JsonProperty("interaction_type")
    private InteractionType interactionType;
    
    @JsonProperty("student_answer")
    private String studentAnswer;  // For quiz/scaffold answers
    
    @JsonProperty("is_correct")
    private Boolean isCorrect;  // For quiz/scaffold answers
    
    @PositiveOrZero(message = "Hint level must be zero or positive")
    @JsonProperty("hint_level")
    private Integer hintLevel;  // For hint requests
    
    @PositiveOrZero(message = "Time spent must be zero or positive")
    @JsonProperty("time_spent_seconds")
    private Integer timeSpentSeconds;  // Optional thinking time
}
