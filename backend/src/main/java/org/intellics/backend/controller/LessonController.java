package org.intellics.backend.controller;

import org.intellics.backend.api.ApiResponseDto;
import org.intellics.backend.api.ApiResponseStatus;
import org.intellics.backend.domain.dto.LessonDto;
import org.intellics.backend.services.LessonService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/lessons")
public class LessonController {

    private final LessonService lessonService;

    public LessonController(LessonService lessonService) {
        this.lessonService = lessonService;
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponseDto<LessonDto>> getLessonById(@PathVariable("id") UUID id) {
        LessonDto lessonDto = lessonService.getLessonById(id);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, lessonDto, "Lesson retrieved successfully."), HttpStatus.OK);
    }

    @GetMapping
    public ResponseEntity<ApiResponseDto<List<LessonDto>>> getAllLessons() {
        List<LessonDto> lessons = lessonService.getAllLessons();
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, lessons, "Lessons retrieved successfully."), HttpStatus.OK);
    }

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<LessonDto>> createLesson(@Validated @RequestBody LessonDto lessonDto) {
        LessonDto createdLesson = lessonService.createLesson(lessonDto);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, createdLesson, "Lesson created successfully."), HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<LessonDto>> updateLesson(@PathVariable("id") UUID id, @Validated @RequestBody LessonDto lessonDto) {
        LessonDto updatedLesson = lessonService.updateLesson(id, lessonDto);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, updatedLesson, "Lesson updated successfully."), HttpStatus.OK);
    }

    @PatchMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<LessonDto>> patchLesson(@PathVariable("id") UUID id, @RequestBody LessonDto lessonDto) {
        LessonDto patchedLesson = lessonService.patchLesson(id, lessonDto);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, patchedLesson, "Lesson patched successfully."), HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<Void>> deleteLesson(@PathVariable("id") UUID id) {
        lessonService.deleteLesson(id);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, null, "Lesson deleted successfully."), HttpStatus.NO_CONTENT);
    }
}
