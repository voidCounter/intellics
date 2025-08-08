package org.intellics.backend.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.intellics.backend.api.ApiResponseDto;
import org.intellics.backend.api.ApiResponseStatus;
import org.intellics.backend.domain.dto.LessonDto;
import org.intellics.backend.domain.dto.LessonKCMappingDto;
import org.intellics.backend.domain.dto.LessonKCMappingPatchDto;
import org.intellics.backend.domain.dto.LessonKCLinkRequestDto;
import org.intellics.backend.domain.dto.LessonWithKCsDto;
import org.intellics.backend.services.LessonService;
import org.intellics.backend.services.LessonKCMappingService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/lessons")
@Tag(name = "Lessons", description = "APIs for managing independent lessons")
public class LessonController {

    private final LessonService lessonService;
    private final LessonKCMappingService lessonKCMappingService;

    public LessonController(LessonService lessonService, LessonKCMappingService lessonKCMappingService) {
        this.lessonService = lessonService;
        this.lessonKCMappingService = lessonKCMappingService;
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get lesson by ID", description = "Retrieves a specific lesson by its unique identifier")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Lesson found successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "404", description = "Lesson not found")
    })
    public ResponseEntity<ApiResponseDto<LessonDto>> getLessonById(
            @Parameter(description = "Unique identifier of the lesson") @PathVariable("id") UUID id) {
        LessonDto lessonDto = lessonService.getLessonById(id);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, lessonDto, "Lesson retrieved successfully."), HttpStatus.OK);
    }

    @GetMapping("/{id}/with-kcs")
    @Operation(summary = "Get lesson by ID with KCs", description = "Retrieves a specific lesson by its unique identifier including all associated knowledge components with their names and target mastery levels")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Lesson with KCs found successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "404", description = "Lesson not found")
    })
    public ResponseEntity<ApiResponseDto<LessonWithKCsDto>> getLessonByIdWithKCs(
            @Parameter(description = "Unique identifier of the lesson") @PathVariable("id") UUID id) {
        LessonWithKCsDto lessonWithKCs = lessonService.getLessonByIdWithKCs(id);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, lessonWithKCs, "Lesson with KCs retrieved successfully."), HttpStatus.OK);
    }

    @GetMapping
    @Operation(summary = "Get all lessons", description = "Retrieves all available lessons")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Lessons retrieved successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class)))
    })
    public ResponseEntity<ApiResponseDto<List<LessonDto>>> getAllLessons() {
        List<LessonDto> lessons = lessonService.getAllLessons();
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, lessons, "Lessons retrieved successfully."), HttpStatus.OK);
    }

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Create a new lesson", description = "Creates a new independent lesson")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Lesson created successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "400", description = "Invalid input data"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required")
    })
    public ResponseEntity<ApiResponseDto<LessonDto>> createLesson(
            @Parameter(description = "Lesson data to create") @Validated @RequestBody LessonDto lessonDto) {
        LessonDto createdLesson = lessonService.createLesson(lessonDto);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, createdLesson, "Lesson created successfully."), HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Update lesson", description = "Updates an existing lesson with new data")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Lesson updated successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "400", description = "Invalid input data"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required"),
            @ApiResponse(responseCode = "404", description = "Lesson not found")
    })
    public ResponseEntity<ApiResponseDto<LessonDto>> updateLesson(
            @Parameter(description = "Unique identifier of the lesson") @PathVariable("id") UUID id,
            @Parameter(description = "Updated lesson data") @Validated @RequestBody LessonDto lessonDto) {
        LessonDto updatedLesson = lessonService.updateLesson(id, lessonDto);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, updatedLesson, "Lesson updated successfully."), HttpStatus.OK);
    }

    @PatchMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Patch lesson", description = "Partially updates a lesson with only the provided fields")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Lesson patched successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "400", description = "Invalid input data"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required"),
            @ApiResponse(responseCode = "404", description = "Lesson not found")
    })
    public ResponseEntity<ApiResponseDto<LessonDto>> patchLesson(
            @Parameter(description = "Unique identifier of the lesson") @PathVariable("id") UUID id,
            @Parameter(description = "Partial lesson data to update") @RequestBody LessonDto lessonDto) {
        LessonDto patchedLesson = lessonService.patchLesson(id, lessonDto);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, patchedLesson, "Lesson patched successfully."), HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Delete lesson", description = "Permanently deletes a lesson")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Lesson deleted successfully"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required"),
            @ApiResponse(responseCode = "404", description = "Lesson not found")
    })
    public ResponseEntity<ApiResponseDto<Void>> deleteLesson(
            @Parameter(description = "Unique identifier of the lesson to delete") @PathVariable("id") UUID id) {
        lessonService.deleteLesson(id);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, null, "Lesson deleted successfully."), HttpStatus.NO_CONTENT);
    }

    // Knowledge Component Operations for Lessons

    @GetMapping("/{lessonId}/kcs")
    @Operation(summary = "Get KCs by lesson ID", description = "Retrieves all knowledge components assigned to a specific lesson")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Knowledge components retrieved successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "404", description = "Lesson not found")
    })
    public ResponseEntity<ApiResponseDto<List<LessonKCMappingDto>>> getKCsByLessonId(
            @Parameter(description = "Unique identifier of the lesson") @PathVariable("lessonId") UUID lessonId) {
        List<LessonKCMappingDto> kcMappings = lessonKCMappingService.getKCsByLessonId(lessonId);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, kcMappings, "KCs retrieved successfully for lesson."), HttpStatus.OK);
    }

    @PostMapping("/{lessonId}/kcs")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Add KC to lesson", description = "Assigns a knowledge component to a lesson with a target mastery level")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Knowledge component added to lesson successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "400", description = "Invalid input data or KC not available in lesson's module"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required"),
            @ApiResponse(responseCode = "404", description = "Lesson or KC not found")
    })
    public ResponseEntity<ApiResponseDto<LessonKCMappingDto>> addKCToLesson(
            @Parameter(description = "Unique identifier of the lesson") @PathVariable("lessonId") UUID lessonId,
            @Parameter(description = "KC assignment data including KC ID and target mastery") @Validated @RequestBody LessonKCLinkRequestDto requestDto) {
        LessonKCMappingDto createdMapping = lessonKCMappingService.addKCToLesson(lessonId, requestDto.getKcId(), requestDto.getTargetMastery());
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, createdMapping, "KC added to lesson successfully."), HttpStatus.CREATED);
    }

    @PatchMapping("/{lessonId}/kcs/{kcId}")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Update target mastery", description = "Updates the target mastery level for a KC in a lesson")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Target mastery updated successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "400", description = "Invalid target mastery value"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required"),
            @ApiResponse(responseCode = "404", description = "Lesson-KC mapping not found")
    })
    public ResponseEntity<ApiResponseDto<LessonKCMappingDto>> updateTargetMastery(
            @Parameter(description = "Unique identifier of the lesson") @PathVariable("lessonId") UUID lessonId,
            @Parameter(description = "Unique identifier of the knowledge component") @PathVariable("kcId") UUID kcId,
            @Parameter(description = "New target mastery value") @Validated @RequestBody LessonKCMappingPatchDto patchDto) {
        LessonKCMappingDto updatedMapping = lessonKCMappingService.updateTargetMastery(lessonId, kcId, patchDto.getTargetMastery());
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, updatedMapping, "Target mastery updated successfully."), HttpStatus.OK);
    }

    @DeleteMapping("/{lessonId}/kcs/{kcId}")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Remove KC from lesson", description = "Removes a knowledge component assignment from a lesson")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Knowledge component removed from lesson successfully"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required"),
            @ApiResponse(responseCode = "404", description = "Lesson-KC mapping not found")
    })
    public ResponseEntity<ApiResponseDto<Void>> removeKCFromLesson(
            @Parameter(description = "Unique identifier of the lesson") @PathVariable("lessonId") UUID lessonId,
            @Parameter(description = "Unique identifier of the knowledge component") @PathVariable("kcId") UUID kcId) {
        lessonKCMappingService.removeKCFromLesson(lessonId, kcId);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, null, "KC removed from lesson successfully."), HttpStatus.NO_CONTENT);
    }
}
