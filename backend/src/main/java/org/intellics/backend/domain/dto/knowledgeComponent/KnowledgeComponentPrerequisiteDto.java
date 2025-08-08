package org.intellics.backend.domain.dto.knowledgeComponent;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class KnowledgeComponentPrerequisiteDto {
    private UUID kc_id;

    @NotBlank(message = "Knowledge Component name cannot be blank")
    @Size(max = 255, message = "Knowledge Component name cannot exceed 255 characters")
    private String kc_name;

    @Size(max = 1000, message = "Description cannot exceed 1000 characters")
    private String description;
    private List<UUID> prerequisiteKcIds;
}
