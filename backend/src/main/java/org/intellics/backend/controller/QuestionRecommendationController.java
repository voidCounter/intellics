package org.intellics.backend.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.intellics.backend.api.ApiResponseDto;
import org.intellics.backend.api.ApiResponseStatus;
import org.intellics.backend.domain.dto.QuestionRecommendationDto;
import org.intellics.backend.domain.dto.QuestionDto;
import org.intellics.backend.domain.dto.QuestionWithScaffoldsDto;
import org.intellics.backend.services.QuestionRecommendationService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/recommendations")
@RequiredArgsConstructor
@Tag(name = "Question Recommendations", description = "API for getting personalized question recommendations")
public class QuestionRecommendationController {

    private final QuestionRecommendationService questionRecommendationService;

    @Operation(
        summary = "Get next question for practice",
        description = "Get the next recommended question based on user mastery and learning context. " +
                     "This endpoint handles all recommendation logic internally."
    )
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Next question retrieved successfully"),
        @ApiResponse(responseCode = "204", description = "No more questions available"),
        @ApiResponse(responseCode = "403", description = "Access denied")
    })
    @GetMapping("/next-question")
    @PreAuthorize("hasRole('USER')")
    public ResponseEntity<ApiResponseDto<QuestionDto>> getNextQuestion(
            @Parameter(description = "Lesson ID for lesson-specific practice") 
            @RequestParam(required = false) UUID lessonId,
            
            @Parameter(description = "Module ID for module-specific practice") 
            @RequestParam(required = false) UUID moduleId,
            
            @Parameter(description = "Include prerequisites (default: true for global, false for lesson)") 
            @RequestParam(required = false) Boolean includePrerequisites,
            
            @Parameter(description = "Scope for module practice: 'all' for all KCs, 'current' for current mastery level") 
            @RequestParam(required = false, defaultValue = "current") String scope) {
        
        UUID userId = getCurrentUserId();
        QuestionDto nextQuestion = questionRecommendationService.getNextQuestion(userId, lessonId, moduleId, includePrerequisites, scope);
        
        if (nextQuestion == null) {
            return ResponseEntity.noContent().build();
        }
        
        return ResponseEntity.ok(
            ApiResponseDto.<QuestionDto>builder()
                .status(ApiResponseStatus.SUCCESS)
                .message("Next question retrieved successfully")
                .data(nextQuestion)
                .build()
        );
    }

    @Operation(
        summary = "Get next question for practice with scaffolds",
        description = "Get the next recommended question with scaffolds based on user mastery and learning context. " +
                     "This endpoint returns the complete question data including scaffolds for better user experience."
    )
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Next question with scaffolds retrieved successfully"),
        @ApiResponse(responseCode = "204", description = "No more questions available"),
        @ApiResponse(responseCode = "403", description = "Access denied")
    })
    @GetMapping("/next-question-with-scaffolds")
    @PreAuthorize("hasRole('USER')")
    public ResponseEntity<ApiResponseDto<QuestionWithScaffoldsDto>> getNextQuestionWithScaffolds(
            @Parameter(description = "Lesson ID for lesson-specific practice") 
            @RequestParam(required = false) UUID lessonId,
            
            @Parameter(description = "Module ID for module-specific practice") 
            @RequestParam(required = false) UUID moduleId,
            
            @Parameter(description = "Include prerequisites (default: true for global, false for lesson)") 
            @RequestParam(required = false) Boolean includePrerequisites,
            
            @Parameter(description = "Scope for module practice: 'all' for all KCs, 'current' for current mastery level") 
            @RequestParam(required = false, defaultValue = "current") String scope) {
        
        UUID userId = getCurrentUserId();
        QuestionWithScaffoldsDto nextQuestion = questionRecommendationService.getNextQuestionWithScaffolds(userId, lessonId, moduleId, includePrerequisites, scope);
        
        if (nextQuestion == null) {
            return ResponseEntity.noContent().build();
        }
        
        return ResponseEntity.ok(
            ApiResponseDto.<QuestionWithScaffoldsDto>builder()
                .status(ApiResponseStatus.SUCCESS)
                .message("Next question with scaffolds retrieved successfully")
                .data(nextQuestion)
                .build()
        );
    }

    @Operation(
        summary = "Get multiple questions for practice session",
        description = "Get a set of recommended questions for a practice session. " +
                     "Useful for pre-loading questions or batch practice."
    )
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Questions retrieved successfully"),
        @ApiResponse(responseCode = "403", description = "Access denied")
    })
    @GetMapping("/practice-session")
    @PreAuthorize("hasRole('USER')")
    public ResponseEntity<ApiResponseDto<List<QuestionRecommendationDto>>> getPracticeSession(
            @Parameter(description = "Lesson ID for lesson-specific practice") 
            @RequestParam(required = false) UUID lessonId,
            
            @Parameter(description = "Module ID for module-specific practice") 
            @RequestParam(required = false) UUID moduleId,
            
            @Parameter(description = "Number of questions to get") 
            @RequestParam(defaultValue = "5") int count,
            
            @Parameter(description = "Include prerequisites (default: true for global, false for lesson)") 
            @RequestParam(required = false) Boolean includePrerequisites,
            
            @Parameter(description = "Scope for module practice: 'all' for all KCs, 'current' for current mastery level") 
            @RequestParam(required = false, defaultValue = "current") String scope) {
        
        UUID userId = getCurrentUserId();
        List<QuestionRecommendationDto> questions = questionRecommendationService.getPracticeSession(userId, lessonId, moduleId, count, includePrerequisites, scope);
        
        return ResponseEntity.ok(
            ApiResponseDto.<List<QuestionRecommendationDto>>builder()
                .status(ApiResponseStatus.SUCCESS)
                .message("Practice session questions retrieved successfully")
                .data(questions)
                .build()
        );
    }

    private UUID getCurrentUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            throw new RuntimeException("User not authenticated");
        }
        return UUID.fromString(authentication.getName());
    }
}
