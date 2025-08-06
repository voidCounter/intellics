package org.intellics.backend.domain.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class QuestionOptionDto {
    @NotBlank(message = "Option key is required and cannot be blank.")
    @Size(min = 1, max = 1, message = "Option key must be a single character (e.g., 'A', 'B').")
    @Pattern(regexp = "[A-Z]", message = "Option key must be a single uppercase letter (A-Z).")
    private String option_key;
    
    @NotBlank
    private String option_text;
    private String option_explanation;
}
