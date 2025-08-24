package org.intellics.backend.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.intellics.backend.domain.entities.InteractionType;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserInteractionDto {
    private UUID interactionId;
    private UUID sessionId;
    private UUID userId;
    private UUID moduleId;
    private UUID lessonId;
    private UUID questionId;
    private UUID scaffoldId;
    private InteractionType interactionType;
    private String studentAnswer;
    private Boolean isCorrect;
    private Integer hintLevel;
    private Integer timeSpentSeconds;
    private Instant timestamp;
    
    // AI evaluation results
    private BigDecimal answerCorrectness; // AI-evaluated correctness score (0.0 to 1.0)
    private String answerAnalysis; // Detailed AI feedback and analysis
    
    // Include KC mappings for comprehensive view
    private List<InteractionKCMappingDto> kcMappings;
}
