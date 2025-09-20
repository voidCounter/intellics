package org.intellics.backend.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.Instant;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReplayResultDto {
    
    private UUID userId;
    private UUID kcId;  // Can be null for interactions without KC mappings
    private String kcName;  // Can be null for interactions without KC mappings
    private UUID interactionId;
    private String interactionType;
    private Boolean isCorrect;
    private Instant timestamp;
    private Double masteryBefore;  // Can be null for interactions without KC mappings
    private Double masteryAfter;   // Can be null for interactions without KC mappings
    private Double effectiveWeight;
    private Boolean shouldUpdate;
}
