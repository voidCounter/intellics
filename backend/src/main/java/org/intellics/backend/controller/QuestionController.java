package org.intellics.backend.controller;

import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.intellics.backend.api.ApiResponseDto;
import org.intellics.backend.api.ApiResponseStatus;
import org.intellics.backend.domain.dto.QuestionDto;
import org.intellics.backend.domain.entities.QuestionEntity;
import org.intellics.backend.mappers.Mapper;
import org.intellics.backend.services.QuestionService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Tag(name = "Question Management", description = "API for managing educational questions and their properties.")
public class QuestionController {
    private final Mapper<QuestionDto, QuestionEntity> questionMapper;
    private final QuestionService questionService;
    
    public QuestionController(Mapper<QuestionDto, QuestionEntity> questionMapper,
                              QuestionService questionService) {
        this.questionMapper = questionMapper;
        this.questionService = questionService;
    }
    
    @PostMapping(path = "/questions")
    public ResponseEntity<ApiResponseDto<QuestionDto>> createQuestion(
        @Valid @RequestBody QuestionDto questionDto) {
        QuestionEntity questionEntity = questionMapper.mapFrom(questionDto);
        QuestionEntity savedQuestionEntity = questionService.createQuestion(questionEntity);
        return ResponseEntity.ok(
            ApiResponseDto.<QuestionDto>builder().status(ApiResponseStatus.SUCCESS).message(
                    "Question created Successfully").data(questionMapper.mapTo(savedQuestionEntity))
                .build()
        );
    }
    
    @GetMapping(path = "/questions")
    public Page<QuestionDto> getQuestions(Pageable pageable) {
        Page<QuestionEntity> result = questionService.findAll(pageable);
        return result.map(questionMapper::mapTo);
    }
}
