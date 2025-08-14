package org.intellics.backend.controller;

import java.time.Instant;
import java.util.UUID;

import org.intellics.backend.api.ApiResponseDto;
import org.intellics.backend.api.ApiResponseStatus;
import org.intellics.backend.api.PaginatedResponseDto;
import org.intellics.backend.domain.dto.SessionCreateDto;
import org.intellics.backend.domain.dto.SessionDto;
import org.intellics.backend.domain.dto.UserSessionDto;
import org.intellics.backend.services.SessionService;
import org.intellics.backend.services.SessionCleanupService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/v1/sessions")
@RequiredArgsConstructor
@Tag(name = "Session Management", description = "API for managing user learning sessions")
public class SessionController {

    private final SessionService sessionService;
    private final SessionCleanupService sessionCleanupService;

    @Operation(
        summary = "Create or get existing session", 
        description = "Creates a new session or returns existing active session to prevent duplicates. " +
                     "Matches by user ID, device type, and user agent to support multiple devices and browser tabs."
    )
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Existing active session returned"),
        @ApiResponse(responseCode = "201", description = "New session created successfully"),
        @ApiResponse(responseCode = "400", description = "Invalid request data")
    })
    @PostMapping
    public ResponseEntity<ApiResponseDto<SessionDto>> createSession(
            @Valid @RequestBody SessionCreateDto sessionCreateDto) {
        
        UUID currentUserId = getCurrentUserId();
        SessionDto session = sessionService.getOrCreateSessionForCurrentUser(currentUserId, sessionCreateDto);
        
        // Check if this is a new session or existing one by comparing creation time
        boolean isNewSession = session.getCreatedAt().equals(session.getStartTime());
        
        if (isNewSession) {
            // New session created
            return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponseDto.<SessionDto>builder()
                    .status(ApiResponseStatus.SUCCESS)
                    .message("Session created successfully")
                    .data(session)
                    .build());
        } else {
            // Existing session returned
            return ResponseEntity.ok(
                ApiResponseDto.<SessionDto>builder()
                    .status(ApiResponseStatus.SUCCESS)
                    .message("Existing active session returned")
                    .data(session)
                    .build());
        }
    }

    @Operation(
        summary = "Get session by ID", 
        description = "Retrieves a specific session by its ID (users can only see their own sessions, admins can see any)"
    )
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Session retrieved successfully"),
        @ApiResponse(responseCode = "404", description = "Session not found"),
        @ApiResponse(responseCode = "403", description = "Access denied - Session does not belong to user")
    })
    @GetMapping("/{sessionId}")
    @PreAuthorize("hasRole('ADMIN') or @sessionSecurity.isOwner(#sessionId)")
    public ResponseEntity<ApiResponseDto<SessionDto>> getSessionById(
            @Parameter(description = "Session ID") 
            @PathVariable UUID sessionId) {
        
        SessionDto session = sessionService.getSessionById(sessionId);
        
        return ResponseEntity.ok(
            ApiResponseDto.<SessionDto>builder()
                .status(ApiResponseStatus.SUCCESS)
                .message("Session retrieved successfully")
                .data(session)
                .build());
    }

    @Operation(
        summary = "Update session heartbeat", 
        description = "Updates the last active time for a session. Returns 404 if session not found or has ended."
    )
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Session heartbeat updated successfully"),
        @ApiResponse(responseCode = "404", description = "Session not found or has ended"),
        @ApiResponse(responseCode = "403", description = "Access denied - Session does not belong to user")
    })
    @PutMapping("/{sessionId}/heartbeat")
    @PreAuthorize("@sessionSecurity.isOwner(#sessionId)")
    public ResponseEntity<ApiResponseDto<SessionDto>> updateSessionHeartbeat(
            @Parameter(description = "Session ID") 
            @PathVariable UUID sessionId) {
        
        SessionDto updatedSession = sessionService.updateSessionHeartbeat(sessionId);
        
        return ResponseEntity.ok(
            ApiResponseDto.<SessionDto>builder()
                .status(ApiResponseStatus.SUCCESS)
                .message("Session heartbeat updated successfully")
                .data(updatedSession)
                .build());
    }

    @Operation(
        summary = "End session", 
        description = "Ends a session for the current user by setting end_time"
    )
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Session ended successfully"),
        @ApiResponse(responseCode = "404", description = "Session not found"),
        @ApiResponse(responseCode = "403", description = "Access denied - Session does not belong to user")
    })
    @PutMapping("/{sessionId}/end")
    @PreAuthorize("@sessionSecurity.isOwner(#sessionId)")
    public ResponseEntity<ApiResponseDto<Object>> endSession(
            @Parameter(description = "Session ID") 
            @PathVariable UUID sessionId) {
        
        sessionService.endSessionForCurrentUser(sessionId);
        
        return ResponseEntity.ok(
            ApiResponseDto.<Object>builder()
                .status(ApiResponseStatus.SUCCESS)
                .message("Session ended successfully")
                .data(new Object() {
                    public final String message = "Session ended successfully";
                })
                .build());
    }

    @Operation(
        summary = "Get sessions with filters and pagination", 
        description = "ADMIN-only endpoint to retrieve sessions with comprehensive filtering and pagination"
    )
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Sessions retrieved successfully"),
        @ApiResponse(responseCode = "403", description = "Access denied - Admin role required")
    })
    @GetMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<PaginatedResponseDto<SessionDto>>> getSessions(
            @Parameter(description = "Filter by user ID") 
            @RequestParam(required = false) UUID userId,
            
            @Parameter(description = "Filter by device type") 
            @RequestParam(required = false) String deviceType,
            
            @Parameter(description = "Filter sessions started after this timestamp (ISO format)") 
            @RequestParam(required = false) Instant startTimeAfter,
            
            @Parameter(description = "Filter sessions started before this timestamp (ISO format)") 
            @RequestParam(required = false) Instant startTimeBefore,
            
            @Parameter(description = "Filter sessions ended after this timestamp (ISO format)") 
            @RequestParam(required = false) Instant endTimeAfter,
            
            @Parameter(description = "Filter sessions ended before this timestamp (ISO format)") 
            @RequestParam(required = false) Instant endTimeBefore,
            
            @Parameter(description = "Filter by active status (true for active, false for ended)") 
            @RequestParam(required = false) Boolean isActive,
            
            @Parameter(description = "Pagination parameters (page, size, sort)")
            @PageableDefault(size = 20) Pageable pageable) {

        Page<SessionDto> sessions = sessionService.getSessionsWithFilters(
            userId, deviceType, startTimeAfter, startTimeBefore, 
            endTimeAfter, endTimeBefore, isActive, pageable
        );

        PaginatedResponseDto<SessionDto> response = PaginatedResponseDto.<SessionDto>builder()
            .content(sessions.getContent())
            .page(sessions.getNumber())
            .size(sessions.getSize())
            .totalPages(sessions.getTotalPages())
            .totalElements(sessions.getTotalElements())
            .first(sessions.isFirst())
            .last(sessions.isLast())
            .empty(sessions.isEmpty())
            .build();

        return ResponseEntity.ok(
            ApiResponseDto.<PaginatedResponseDto<SessionDto>>builder()
                .status(ApiResponseStatus.SUCCESS)
                .message("Sessions retrieved successfully")
                .data(response)
                .build());
    }

    @Operation(
        summary = "Get sessions by current user",
        description = "Retrieve all sessions for the currently authenticated user with optional filtering"
    )
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Sessions retrieved successfully"),
        @ApiResponse(responseCode = "401", description = "Unauthorized")
    })
    @GetMapping("/my")
    public ResponseEntity<ApiResponseDto<PaginatedResponseDto<UserSessionDto>>> getMySessions(
            @Parameter(description = "Filter by active status (true for active, false for ended)")
            @RequestParam(required = false) Boolean isActive,
            
            @Parameter(description = "Filter by device type")
            @RequestParam(required = false) String deviceType,
            
            @Parameter(description = "Pagination parameters (page, size, sort)")
            @PageableDefault(size = 20) Pageable pageable) {
        
        UUID currentUserId = getCurrentUserId();
        
        // Use the service method with filters
        Page<UserSessionDto> sessions = sessionService.getSessionsByUserIdWithFilters(
            currentUserId, deviceType, null, null, null, null, isActive, pageable
        );
        
        PaginatedResponseDto<UserSessionDto> response = PaginatedResponseDto.<UserSessionDto>builder()
            .content(sessions.getContent())
            .page(sessions.getNumber())
            .size(sessions.getSize())
            .totalPages(sessions.getTotalPages())
            .totalElements(sessions.getTotalElements())
            .first(sessions.isFirst())
            .last(sessions.isLast())
            .empty(sessions.isEmpty())
            .build();
        
        return ResponseEntity.ok(
            ApiResponseDto.<PaginatedResponseDto<UserSessionDto>>builder()
                .status(ApiResponseStatus.SUCCESS)
                .message("Sessions retrieved successfully")
                .data(response)
                .build());
    }



    @Operation(
        summary = "Delete session", 
        description = "ADMIN-only endpoint to delete a session"
    )
    @ApiResponses(value = {
        @ApiResponse(responseCode = "204", description = "Session deleted successfully"),
        @ApiResponse(responseCode = "403", description = "Access denied - Admin role required"),
        @ApiResponse(responseCode = "404", description = "Session not found")
    })
    @DeleteMapping("/{sessionId}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Void> deleteSession(
            @Parameter(description = "Session ID") 
            @PathVariable UUID sessionId) {
        
        sessionService.deleteSession(sessionId);
        
        return ResponseEntity.noContent().build();
    }

    @Operation(
        summary = "Manual session cleanup", 
        description = "ADMIN-only endpoint to manually trigger session cleanup (for testing/monitoring)"
    )
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Cleanup completed successfully"),
        @ApiResponse(responseCode = "403", description = "Access denied - Admin role required")
    })
    @PostMapping("/cleanup")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<Object>> manualCleanup() {
        long inactiveCount = sessionCleanupService.getInactiveSessionCount();
        sessionCleanupService.cleanupInactiveSessions();
        
        return ResponseEntity.ok(
            ApiResponseDto.<Object>builder()
                .status(ApiResponseStatus.SUCCESS)
                .message("Session cleanup completed")
                .data(new Object() {
                    public final long inactiveSessionsFound = inactiveCount;
                    public final String message = "Cleanup completed successfully";
                })
                .build());
    }

    /**
     * Helper method to get current user ID from authentication context
     */
    private UUID getCurrentUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return UUID.fromString(authentication.getName());
    }
}
