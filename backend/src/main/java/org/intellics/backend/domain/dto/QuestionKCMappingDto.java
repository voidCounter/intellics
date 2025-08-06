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
public class QuestionKCMappingDto {
    private UUID id; // Assuming an ID for the mapping entity itself
    private String kcCode; // Example: "K001"
    private String kcName; // Example: "Algebra Basics"
    // In a real app, you might include a KCDto object here instead of just ID/code.
}

