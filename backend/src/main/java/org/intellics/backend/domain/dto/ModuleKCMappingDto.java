package org.intellics.backend.domain.dto;

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
public class ModuleKCMappingDto {
    private UUID moduleId;
    private UUID kcId;
    private List<UUID> prerequisiteKcIds;
    
    // Optional: Prerequisites with rationale (if provided, this takes precedence over prerequisiteKcIds)
    private List<PrerequisiteWithRationaleDto> prerequisitesWithRationale;
}
