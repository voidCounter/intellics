package org.intellics.backend.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class QuestionRecommendationDto {
    
    private UUID questionId;
    private String questionText;
    private UUID primaryKc;
    private BigDecimal priorityScore;
    private BigDecimal masteryGap;
    private BigDecimal recencyFactor;
    private Instant lastCorrectAnswer;
    
    // Additional fields for enhanced context
    private String kcName;
    private String questionType;
    private Integer difficultyLevel;
}
