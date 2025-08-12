package org.intellics.backend.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SessionCreateDto {
    private String userAgent;
    private String deviceType;
    
    // Note: startTime and endTime are set by server for security
    // Users cannot manipulate session timing
}
