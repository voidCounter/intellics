package org.intellics.backend.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import org.intellics.backend.domain.entities.QuestionType;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class WrittenQuestionDto extends QuestionDto {
    private String correct_answer_text;
    private String answer_explanation;
    
    @Override
    public QuestionType getType() {
        return QuestionType.WRITTEN;
    }
}
