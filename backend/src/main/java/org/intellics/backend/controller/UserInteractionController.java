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
import org.intellics.backend.domain.dto.UserInteractionDto;
import org.intellics.backend.domain.entities.InteractionType;
import org.intellics.backend.services.UserInteractionService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/interactions")
@RequiredArgsConstructor
@Tag(name = "User Interactions", description = "API for managing and viewing user learning interactions")
public class UserInteractionController {

    private final UserInteractionService userInteractionService;

    @Operation(
        summary = "Get user interactions with filters", 
        description = "ADMIN-only endpoint to retrieve user interactions with comprehensive filtering and pagination"
    )
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Interactions retrieved successfully"),
        @ApiResponse(responseCode = "403", description = "Access denied - Admin role required")
    })
    @GetMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<PaginatedResponseDto<UserInteractionDto>>> getInteractions(
            @Parameter(description = "Filter by user ID") 
            @RequestParam(required = false) UUID userId,
            
            @Parameter(description = "Filter by session ID") 
            @RequestParam(required = false) UUID sessionId,
            
            @Parameter(description = "Filter by module ID") 
            @RequestParam(required = false) UUID moduleId,
            
            @Parameter(description = "Filter by lesson ID") 
            @RequestParam(required = false) UUID lessonId,
            
            @Parameter(description = "Filter by question ID") 
            @RequestParam(required = false) UUID questionId,
            
            @Parameter(description = "Filter by scaffold ID") 
            @RequestParam(required = false) UUID scaffoldId,
            
            @Parameter(description = "Filter by knowledge component ID") 
            @RequestParam(required = false) UUID kcId,
            
            @Parameter(description = "Filter by interaction type") 
            @RequestParam(required = false) InteractionType interactionType,
            
            @Parameter(description = "Filter by correctness (for quiz answers)") 
            @RequestParam(required = false) Boolean isCorrect,
            
            @Parameter(description = "Filter interactions after this timestamp (ISO format)") 
            @RequestParam(required = false) Instant timestampAfter,
            
            @Parameter(description = "Filter interactions before this timestamp (ISO format)") 
            @RequestParam(required = false) Instant timestampBefore,
            
            @Parameter(description = "Pagination parameters (page, size, sort)")
            @PageableDefault(size = 20, sort = "timestamp") Pageable pageable) {

        Page<UserInteractionDto> interactions = userInteractionService.getInteractionsWithFilters(
            userId, sessionId, moduleId, lessonId, questionId, scaffoldId, kcId, 
            interactionType, isCorrect, timestampAfter, timestampBefore, pageable
        );

        PaginatedResponseDto<UserInteractionDto> response = PaginatedResponseDto.<UserInteractionDto>builder()
            .content(interactions.getContent())
            .page(interactions.getNumber())
            .size(interactions.getSize())
            .totalPages(interactions.getTotalPages())
            .totalElements(interactions.getTotalElements())
            .first(interactions.isFirst())
            .last(interactions.isLast())
            .empty(interactions.isEmpty())
            .build();

        return ResponseEntity.ok(
            ApiResponseDto.<PaginatedResponseDto<UserInteractionDto>>builder()
                .status(ApiResponseStatus.SUCCESS)
                .message("User interactions retrieved successfully")
                .data(response)
                .build()
        );
    }
}
