package org.intellics.backend.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.intellics.backend.api.ApiResponseDto;
import org.intellics.backend.api.ApiResponseStatus;
import org.intellics.backend.api.PaginatedResponseDto;
import org.intellics.backend.domain.dto.SessionCreateDto;
import org.intellics.backend.domain.dto.SessionDto;
import org.intellics.backend.domain.dto.UserSessionDto;
import org.intellics.backend.services.SessionService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.time.Instant;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/sessions")
@RequiredArgsConstructor
@Tag(name = "Session Management", description = "API for managing user learning sessions")
public class SessionController {

    private final SessionService sessionService;

    @Operation(
        summary = "Create a new session", 
        description = "Creates a new learning session for the current user. Start time is automatically set by server for security."
    )
    @ApiResponses(value = {
        @ApiResponse(responseCode = "201", description = "Session created successfully"),
        @ApiResponse(responseCode = "400", description = "Invalid request data")
    })
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public ResponseEntity<ApiResponseDto<SessionDto>> createSession(
            @Valid @RequestBody SessionCreateDto sessionCreateDto) {
        
        UUID currentUserId = getCurrentUserId();
        SessionDto createdSession = sessionService.createSessionForCurrentUser(currentUserId, sessionCreateDto);
        
        return ResponseEntity.status(HttpStatus.CREATED)
            .body(ApiResponseDto.<SessionDto>builder()
                .status(ApiResponseStatus.SUCCESS)
                .message("Session created successfully")
                .data(createdSession)
                .build());
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
        summary = "End session", 
        description = "Ends a session by setting the end time to current timestamp (only if it belongs to current user)"
    )
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Session ended successfully"),
        @ApiResponse(responseCode = "400", description = "Session is already ended"),
        @ApiResponse(responseCode = "404", description = "Session not found"),
        @ApiResponse(responseCode = "403", description = "Access denied - Session does not belong to user")
    })
    @PatchMapping("/{sessionId}/end")
    @PreAuthorize("@sessionSecurity.isOwner(#sessionId)")
    public ResponseEntity<ApiResponseDto<SessionDto>> endSession(
            @Parameter(description = "Session ID") 
            @PathVariable UUID sessionId) {
        
        SessionDto endedSession = sessionService.endSession(sessionId);
        
        return ResponseEntity.ok(
            ApiResponseDto.<SessionDto>builder()
                .status(ApiResponseStatus.SUCCESS)
                .message("Session ended successfully")
                .data(endedSession)
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

    /**
     * Helper method to get current user ID from authentication context
     */
    private UUID getCurrentUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return UUID.fromString(authentication.getName());
    }
}
