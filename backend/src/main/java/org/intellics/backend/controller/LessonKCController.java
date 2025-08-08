package org.intellics.backend.controller;

import org.intellics.backend.api.ApiResponseDto;
import org.intellics.backend.api.ApiResponseStatus;
import org.intellics.backend.domain.dto.LessonKCMappingDto;
import org.intellics.backend.domain.dto.LessonKCMappingPatchDto;
import org.intellics.backend.domain.dto.LessonKCLinkRequestDto;
import org.intellics.backend.services.LessonKCMappingService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/lessons/{lessonId}/kcs")
public class LessonKCController {

    private final LessonKCMappingService lessonKCMappingService;

    public LessonKCController(LessonKCMappingService lessonKCMappingService) {
        this.lessonKCMappingService = lessonKCMappingService;
    }

    @GetMapping
    public ResponseEntity<ApiResponseDto<List<LessonKCMappingDto>>> getKCsByLessonId(@PathVariable("lessonId") UUID lessonId) {
        List<LessonKCMappingDto> kcMappings = lessonKCMappingService.getKCsByLessonId(lessonId);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, kcMappings, "KCs retrieved successfully for lesson."), HttpStatus.OK);
    }

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<LessonKCMappingDto>> addKCToLesson(
            @PathVariable("lessonId") UUID lessonId,
            @Validated @RequestBody LessonKCLinkRequestDto requestDto) {
        LessonKCMappingDto createdMapping = lessonKCMappingService.addKCToLesson(lessonId, requestDto.getKcId(), requestDto.getTargetMastery());
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, createdMapping, "KC added to lesson successfully."), HttpStatus.CREATED);
    }

    @PatchMapping("/{kcId}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<LessonKCMappingDto>> updateTargetMastery(
            @PathVariable("lessonId") UUID lessonId,
            @PathVariable("kcId") UUID kcId,
            @Validated @RequestBody LessonKCMappingPatchDto patchDto) {
        LessonKCMappingDto updatedMapping = lessonKCMappingService.updateTargetMastery(lessonId, kcId, patchDto.getTargetMastery());
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, updatedMapping, "Target mastery updated successfully."), HttpStatus.OK);
    }

    @DeleteMapping("/{kcId}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<Void>> removeKCFromLesson(
            @PathVariable("lessonId") UUID lessonId,
            @PathVariable("kcId") UUID kcId) {
        lessonKCMappingService.removeKCFromLesson(lessonId, kcId);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, null, "KC removed from lesson successfully."), HttpStatus.NO_CONTENT);
    }
}
