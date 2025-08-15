package org.intellics.backend.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class QuestionKCMappingPatchDto {
    @NotNull
    @DecimalMin(value = "0.0", message = "Weight must be at least 0.0")
    @DecimalMax(value = "1.0", message = "Weight must be at most 1.0")
    private BigDecimal weight; // Normalized value between 0.0 and 1.0
}
