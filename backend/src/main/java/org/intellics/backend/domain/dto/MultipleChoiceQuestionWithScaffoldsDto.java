package org.intellics.backend.domain.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import org.intellics.backend.domain.entities.QuestionType;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class MultipleChoiceQuestionWithScaffoldsDto extends QuestionWithScaffoldsDto {
    
    @NotEmpty(message = "At least two options are required for a multiple choice question.")
    @Valid
    @Size(min = 2, message = "A multiple choice question must have at least 2 options.")
    private List<QuestionOptionDto> options;
    
    @Pattern(regexp = "[A-Z]", message = "Correct option key must be a single uppercase letter (A-Z).")
    @Size(min = 1, max = 1, message = "Correct option key must be a single character (e.g., 'A', 'B').")
    private String correct_option_key;
    
    @Override
    public QuestionType getType() {
        return QuestionType.MULTIPLE_CHOICE;
    }
}
