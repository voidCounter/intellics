package org.intellics.backend.domain.dto;

import jakarta.validation.constraints.NotBlank;
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
public class ModuleDto {

    private UUID module_id;

    @NotBlank(message = "Module name cannot be blank")
    @Size(max = 255, message = "Module name cannot exceed 255 characters")
    private String module_name;

    @Size(max = 1000, message = "Description cannot exceed 1000 characters")
    private String description;
}