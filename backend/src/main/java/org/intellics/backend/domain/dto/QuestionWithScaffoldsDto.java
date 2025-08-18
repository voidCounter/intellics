package org.intellics.backend.domain.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import java.util.List;
import java.util.UUID;
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
@JsonTypeInfo(
    use = JsonTypeInfo.Id.NAME,
    include = JsonTypeInfo.As.EXISTING_PROPERTY,
    property = "type",
    visible = true
)
@JsonSubTypes({
    @JsonSubTypes.Type(value = MultipleChoiceQuestionWithScaffoldsDto.class, name = "MULTIPLE_CHOICE"),
    @JsonSubTypes.Type(value = WrittenQuestionWithScaffoldsDto.class, name = "WRITTEN")
})
public abstract class QuestionWithScaffoldsDto extends QuestionDto {
    
    @Valid
    private List<ScaffoldDto> scaffolds;
    
    // This abstract method will be implemented by subclasses to provide their specific type
    @JsonProperty("type") // Maps this method to a JSON property named "type"
    public abstract QuestionType getType();
}
