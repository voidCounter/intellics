package org.intellics.backend.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;

import java.math.BigDecimal;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LessonKCLinkRequestDto {
    @NotNull(message = "KC ID is required")
    private UUID kcId;
    
    @NotNull(message = "Target mastery is required")
    @DecimalMin(value = "0.01", message = "Target mastery must be at least 0.01")
    @DecimalMax(value = "1.00", message = "Target mastery must be at most 1.00")
    private BigDecimal targetMastery;
}
