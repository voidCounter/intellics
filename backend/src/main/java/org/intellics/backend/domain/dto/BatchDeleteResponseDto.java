package org.intellics.backend.domain.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "Response DTO for batch deletion operations")
public class BatchDeleteResponseDto {

    @Schema(description = "Total number of items requested for deletion")
    private int totalRequested;

    @Schema(description = "Number of items successfully deleted")
    private int successfullyDeleted;

    @Schema(description = "Number of items that could not be deleted")
    private int failedToDelete;

    @Schema(description = "List of IDs that were successfully deleted")
    private List<UUID> deletedIds;

    @Schema(description = "List of IDs that failed to delete (if any)")
    private List<UUID> failedIds;
}
