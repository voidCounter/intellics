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
public class InteractionKCMappingDto {
    private UUID interactionId;
    private UUID kcId;
    private String kcName;  // Include KC name for easier frontend display
    private Double weight;
    private Double kcMasteryBefore;
    private Double kcMasteryAfter;
    private Instant created_at;
    private Instant updated_at;
}
