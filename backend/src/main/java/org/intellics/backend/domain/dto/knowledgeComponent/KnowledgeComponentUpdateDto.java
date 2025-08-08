package org.intellics.backend.domain.dto.knowledgeComponent;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class KnowledgeComponentUpdateDto {
    @NotNull(message = "Knowledge Component ID cannot be null")
    private UUID kc_id;

    @NotBlank(message = "Knowledge Component name cannot be blank")
    @Size(max = 255, message = "Knowledge Component name cannot exceed 255 characters")
    private String kc_name;

    @NotBlank(message = "Description cannot be blank")
    @Size(max = 1000, message = "Description cannot exceed 1000 characters")
    private String description;
}
