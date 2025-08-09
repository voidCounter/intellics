package org.intellics.backend.domain.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.PositiveOrZero;
import jakarta.validation.constraints.Size;
import java.util.UUID;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ScaffoldDto {
    private UUID scaffoldId;
    
    @NotBlank(message = "Scaffold text cannot be blank")
    @Size(max = 5000, message = "Scaffold text cannot exceed 5000 characters")
    private String scaffoldText;
    
    @NotBlank(message = "Scaffold correct answer cannot be blank")
    @Size(max = 2000, message = "Scaffold correct answer cannot exceed 2000 characters")
    private String scaffoldCorrectAnswer;
    
    @PositiveOrZero(message = "Order index must be zero or positive")
    private int orderIndex;
}
