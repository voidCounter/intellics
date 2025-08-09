package org.intellics.backend.domain.dto;

import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import java.util.UUID;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class QuestionKCMappingRequestDto {
    @NotNull(message = "Knowledge component ID is required")
    private UUID kc_id;
    
    @NotNull(message = "Weight is required")
    @DecimalMin(value = "0.0", message = "Weight must be between 0.0 and 1.0")
    @DecimalMax(value = "1.0", message = "Weight must be between 0.0 and 1.0")
    private Double weight;
}
