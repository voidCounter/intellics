package org.intellics.backend.domain.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.PositiveOrZero;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class QuestionRecommendationRequestDto {
    
    @NotNull(message = "Context is required")
    @JsonProperty("context")
    private String context; // 'lesson' or 'global'
    
    @JsonProperty("lesson_id")
    private UUID lessonId; // Required when context = 'lesson'
    
    @JsonProperty("module_id")
    private UUID moduleId; // Optional module filter
    
    @Positive(message = "Limit must be positive")
    @JsonProperty("limit")
    private Integer limit = 10; // Default to 10 questions
    
    @JsonProperty("include_prerequisites")
    private Boolean includePrerequisites; // NULL = auto by context
    
    @PositiveOrZero(message = "Max recency days must be zero or positive")
    @JsonProperty("max_recency_days")
    private Integer maxRecencyDays = 30; // Default to 30 days
    
    @Positive(message = "Per KC limit must be positive")
    @JsonProperty("per_kc_limit")
    private Integer perKcLimit = 2; // Default to 2 questions per KC
}
