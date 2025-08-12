package org.intellics.backend.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.Instant;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserSessionDto {
    private UUID sessionId;
    private String username; // Include username for easier frontend display
    private String userAgent;
    private String deviceType;
    private Instant startTime;
    private Instant endTime;
    private Instant createdAt;
    private Instant updatedAt;
    
    // Include interaction count for session overview
    private Long interactionCount;
}
