package org.intellics.backend.domain.dto.knowledgeComponent;

import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class KnowledgeComponentPatchDto {
    @Size(max = 255, message = "Knowledge Component name cannot exceed 255 characters")
    private String kc_name;

    @Size(max = 1000, message = "Description cannot exceed 1000 characters")
    private String description;
}
