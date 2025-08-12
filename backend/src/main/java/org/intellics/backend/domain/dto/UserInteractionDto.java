package org.intellics.backend.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.intellics.backend.domain.entities.InteractionType;

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
    
    // Include KC mappings for comprehensive view
    private List<InteractionKCMappingDto> kcMappings;
}
