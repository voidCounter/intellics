package org.intellics.backend.domain.dto;

import java.util.UUID;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ScaffoldDto {
    private UUID id; // Assuming an ID for the scaffold entity itself
    private String scaffoldText;
    private int order; // E.g., step 1, step 2
    // Add other relevant fields like scaffold type, hints etc.
}
