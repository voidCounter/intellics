package org.intellics.backend.domain.entities;

import com.vladmihalcea.hibernate.type.json.JsonBinaryType;
import jakarta.persistence.Column;
import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.Type;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@Entity
@Table(name = "multiple_choice_questions")
@DiscriminatorValue("MULTIPLE_CHOICE")
public class MultipleChoicequestionEntity extends QuestionEntity {
    @Type(JsonBinaryType.class)
    @Column(name = "options", columnDefinition = "jsonb")
    private List<QuestionOption> options;
    
    private String correct_option_key;
    
    @Override
    public QuestionType getType() {
        return QuestionType.MULTIPLE_CHOICE;
    }
}
