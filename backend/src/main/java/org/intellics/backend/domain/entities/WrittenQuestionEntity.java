package org.intellics.backend.domain.entities;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@Entity
@DiscriminatorValue(value = "WRITTEN")
public class WrittenQuestionEntity extends QuestionEntity {
    private String correct_answer_text;
    private String answer_explanation;
    
    @Override
    public QuestionType getType() {
        return QuestionType.WRITTEN;
    }
}
