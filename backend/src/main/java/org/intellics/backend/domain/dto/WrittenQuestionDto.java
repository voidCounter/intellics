package org.intellics.backend.domain.dto;

import jakarta.validation.constraints.NotBlank;
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
public class WrittenQuestionDto extends QuestionDto {
    @NotBlank(message = "Correct answer text cannot be blank.")
    private String correct_answer_text;
    private String answer_explanation;
    
    @Override
    public QuestionType getType() {
        return QuestionType.WRITTEN;
    }
}
