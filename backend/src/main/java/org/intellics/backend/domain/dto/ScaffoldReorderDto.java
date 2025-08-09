package org.intellics.backend.domain.dto;

import jakarta.validation.constraints.NotNull;
import java.util.List;
import java.util.UUID;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ScaffoldReorderDto {
    @NotNull(message = "Scaffold IDs list is required")
    private List<UUID> scaffoldIds;
}
