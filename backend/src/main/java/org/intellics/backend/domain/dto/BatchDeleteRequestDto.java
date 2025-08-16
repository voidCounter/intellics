package org.intellics.backend.domain.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "Request DTO for batch deletion operations")
public class BatchDeleteRequestDto {

    @Schema(description = "List of IDs to delete", example = "[\"123e4567-e89b-12d3-a456-426614174000\", \"987fcdeb-51a2-43d1-9f12-345678901234\"]")
    @NotEmpty(message = "IDs list cannot be empty")
    @Size(min = 1, max = 100, message = "IDs list must contain between 1 and 100 items")
    private List<UUID> ids;
}
