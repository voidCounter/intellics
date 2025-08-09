package org.intellics.backend.domain.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import jakarta.validation.constraints.NotBlank;
import java.util.UUID;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import org.intellics.backend.domain.entities.QuestionType;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@JsonTypeInfo(
    use = JsonTypeInfo.Id.NAME,
    include = JsonTypeInfo.As.EXISTING_PROPERTY,
    property = "type",
    visible = true
)
@JsonSubTypes({
    @JsonSubTypes.Type(value = MultipleChoiceQuestionDto.class, name = "MULTIPLE_CHOICE"),
    @JsonSubTypes.Type(value = WrittenQuestionDto.class, name = "WRITTEN")
})
public abstract class QuestionDto {
    private UUID question_id;
    @NotBlank(message = "Question text cannot be blank.")
    private String question_text;
    private String hint_level_1;
    private String hint_level_2;
    
    // This abstract method will be implemented by subclasses to provide their specific type
    @JsonProperty("type") // Maps this method to a JSON property named "type"
    public abstract QuestionType getType();
}