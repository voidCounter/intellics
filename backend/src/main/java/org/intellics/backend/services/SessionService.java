package org.intellics.backend.services;

import java.time.Instant;
import java.util.UUID;

import org.intellics.backend.domain.dto.SessionCreateDto;
import org.intellics.backend.domain.dto.SessionDto;
import org.intellics.backend.domain.dto.UserSessionDto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface SessionService {
    
    /**
     * Create a new session for the current user
     */
    SessionDto createSessionForCurrentUser(UUID currentUserId, SessionCreateDto sessionCreateDto);

    /**
     * Get or create a session for the current user (prevents duplicates)
     * Returns existing active session if found, otherwise creates new one.
     * Matches by user ID, device type, and user agent to support multiple devices.
     */
    SessionDto getOrCreateSessionForCurrentUser(UUID currentUserId, SessionCreateDto sessionCreateDto);

    /**
     * Get a session by ID
     */
    SessionDto getSessionById(UUID sessionId);
    
    /**
     * Get sessions with filters and pagination (admin endpoint)
     */
    Page<SessionDto> getSessionsWithFilters(
        UUID userId,
        String deviceType,
        Instant startTimeAfter,
        Instant startTimeBefore,
        Instant endTimeAfter,
        Instant endTimeBefore,
        Boolean isActive,
        Pageable pageable
    );

    /**
     * Get sessions by user ID with filters and pagination (user endpoint - returns UserSessionDto for privacy)
     */
    Page<UserSessionDto> getSessionsByUserIdWithFilters(
        UUID userId,
        String deviceType,
        Instant startTimeAfter,
        Instant startTimeBefore,
        Instant endTimeAfter,
        Instant endTimeBefore,
        Boolean isActive,
        Pageable pageable
    );

    /**
     * Update session heartbeat (last active time)
     */
    SessionDto updateSessionHeartbeat(UUID sessionId);

    /**
     * End a session for the current user (set end_time)
     */
    void endSessionForCurrentUser(UUID sessionId);


    
    /**
     * Delete a session
     */
    void deleteSession(UUID sessionId);
}
