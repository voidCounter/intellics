package org.intellics.backend.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import java.util.UUID;
import org.intellics.backend.api.ApiResponseDto;
import org.intellics.backend.api.ApiResponseStatus;
import org.intellics.backend.api.PaginatedResponseDto;
import org.intellics.backend.domain.dto.QuestionDto;
import org.intellics.backend.domain.dto.QuestionKCMappingDto;
import org.intellics.backend.domain.dto.QuestionKCMappingRequestDto;
import org.intellics.backend.domain.dto.QuestionKCMappingPatchDto;
import org.intellics.backend.domain.dto.QuestionTitleDto;
import org.intellics.backend.domain.dto.ScaffoldDto;
import org.intellics.backend.domain.dto.ScaffoldReorderDto;
import org.intellics.backend.domain.entities.QuestionEntity;
import org.intellics.backend.domain.entities.Scaffold;
import org.intellics.backend.mappers.Mapper;
import org.intellics.backend.mappers.ScaffoldMapper;
import org.intellics.backend.services.QuestionKCMappingService;
import org.intellics.backend.services.QuestionService;
import org.intellics.backend.services.ScaffoldService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import java.util.List;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.validation.annotation.Validated;

@RestController
@RequestMapping("/api/v1/questions")
@Tag(name = "Question Management", description = "API for managing educational questions and their properties.")
public class QuestionController {
    private final Mapper<QuestionDto, QuestionEntity> questionMapper;
    private final QuestionService questionService;
    private final QuestionKCMappingService questionKCMappingService;
    private final ScaffoldService scaffoldService;
    private final ScaffoldMapper scaffoldMapper;
    
    public QuestionController(Mapper<QuestionDto, QuestionEntity> questionMapper,
                              QuestionService questionService,
                              QuestionKCMappingService questionKCMappingService,
                              ScaffoldService scaffoldService,
                              ScaffoldMapper scaffoldMapper) {
        this.questionMapper = questionMapper;
        this.questionService = questionService;
        this.questionKCMappingService = questionKCMappingService;
        this.scaffoldService = scaffoldService;
        this.scaffoldMapper = scaffoldMapper;
    }
    
    @Operation(summary = "Create a new question", description = "Creates a new question of any available type (multiple choice or written)")
    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<QuestionDto>> createQuestion(
        @Valid @RequestBody QuestionDto questionDto) {
        QuestionEntity questionEntity = questionMapper.mapFrom(questionDto);
        QuestionEntity savedQuestionEntity = questionService.createQuestion(questionEntity);
        return ResponseEntity.ok(
            ApiResponseDto.<QuestionDto>builder().status(ApiResponseStatus.SUCCESS).message(
                    "Question created successfully").data(questionMapper.mapTo(savedQuestionEntity))
                .build()
        );
    }
    
    @Operation(summary = "Get all questions", description = "Retrieves a paginated list of all questions. Use titlesOnly=true for lightweight data suitable for dropdowns.")
    @GetMapping
    public ResponseEntity<ApiResponseDto<?>> getQuestions(
            @Parameter(description = "If true, returns only question titles (ID and text) for efficient dropdown usage") 
            @RequestParam(required = false, defaultValue = "false") boolean titlesOnly,
            Pageable pageable) {
        
        if (titlesOnly) {
            List<QuestionTitleDto> titles = questionService.getQuestionTitles();
            return ResponseEntity.ok(
                ApiResponseDto.<List<QuestionTitleDto>>builder()
                    .status(ApiResponseStatus.SUCCESS)
                    .message("Question titles retrieved successfully")
                    .data(titles)
                    .build()
            );
        } else {
            Page<QuestionEntity> result = questionService.findAll(pageable);
            Page<QuestionDto> questionDtos = result.map(questionMapper::mapTo);
            PaginatedResponseDto<QuestionDto> paginatedResponse = PaginatedResponseDto.from(questionDtos);
            
            return ResponseEntity.ok(
                ApiResponseDto.<PaginatedResponseDto<QuestionDto>>builder()
                    .status(ApiResponseStatus.SUCCESS)
                    .message("Questions retrieved successfully")
                    .data(paginatedResponse)
                    .build()
            );
        }
    }
    
    @Operation(summary = "Get question by ID", description = "Retrieves a specific question by its ID")
    @GetMapping("/{questionId}")
    public ResponseEntity<ApiResponseDto<QuestionDto>> getQuestion(@PathVariable UUID questionId) {
        QuestionEntity questionEntity = questionService.getQuestion(questionId);
        return ResponseEntity.ok(
            ApiResponseDto.<QuestionDto>builder().status(ApiResponseStatus.SUCCESS).message(
                    "Question retrieved successfully").data(questionMapper.mapTo(questionEntity))
                .build()
        );
    }
    
    @Operation(summary = "Update a question", description = "Updates a complete question including type-specific fields (options for MC, answers for written).")
    @PutMapping("/{questionId}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<QuestionDto>> updateQuestion(
        @PathVariable UUID questionId,
        @Valid @RequestBody QuestionDto questionDto) {
        
        // Convert DTO to entity using mapper
        QuestionEntity questionEntity = questionMapper.mapFrom(questionDto);
        
        // Update the question with complete replacement
        QuestionEntity updatedQuestion = questionService.updateQuestion(questionId, questionEntity);
        
        return ResponseEntity.ok(
            ApiResponseDto.<QuestionDto>builder().status(ApiResponseStatus.SUCCESS).message(
                    "Question updated successfully").data(questionMapper.mapTo(updatedQuestion))
                .build()
        );
    }
    

    
    @Operation(summary = "Delete a question", description = "ADMIN-only endpoint to delete a question")
    @DeleteMapping("/{questionId}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<Void>> deleteQuestion(@PathVariable UUID questionId) {
        questionService.deleteQuestion(questionId);
        return ResponseEntity.ok(
            ApiResponseDto.<Void>builder().status(ApiResponseStatus.SUCCESS).message(
                    "Question deleted successfully").build()
        );
    }
    
    // Question-KC Mapping endpoints
    
    @Operation(summary = "Map question to knowledge component", description = "ADMIN-only endpoint to map a question to a knowledge component with a weight")
    @PostMapping("/{questionId}/kcs")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<QuestionKCMappingDto>> addQuestionKCMapping(
        @PathVariable UUID questionId,
        @Valid @RequestBody QuestionKCMappingRequestDto mappingRequest) {
        
        QuestionKCMappingDto mappingDto = questionKCMappingService.addKCToQuestion(
            questionId, 
            mappingRequest.getKc_id(), 
            mappingRequest.getWeight()
        );
            
        return ResponseEntity.ok(
            ApiResponseDto.<QuestionKCMappingDto>builder().status(ApiResponseStatus.SUCCESS).message(
                    "Question mapped to knowledge component successfully").data(mappingDto)
                .build()
        );
    }
    
    @Operation(summary = "Get question knowledge component mappings", description = "ADMIN-only endpoint to retrieve all knowledge components mapped to a question")
    @GetMapping("/{questionId}/kcs")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<List<QuestionKCMappingDto>>> getQuestionKCMappings(
        @PathVariable UUID questionId) {
        
        List<QuestionKCMappingDto> mappingDtos = questionKCMappingService.getKCsByQuestionId(questionId);
            
        return ResponseEntity.ok(
            ApiResponseDto.<List<QuestionKCMappingDto>>builder().status(ApiResponseStatus.SUCCESS).message(
                    "Question knowledge component mappings retrieved successfully").data(mappingDtos)
                .build()
        );
    }
    
    @PatchMapping("/{questionId}/kcs/{kcId}")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Update question knowledge component weight", description = "Updates the weight value for a KC in a question")
    public ResponseEntity<ApiResponseDto<QuestionKCMappingDto>> updateQuestionKCWeight(
            @PathVariable("questionId") UUID questionId,
            @PathVariable("kcId") UUID kcId,
            @Validated @RequestBody QuestionKCMappingPatchDto patchDto) {
        QuestionKCMappingDto updatedMapping = questionKCMappingService.updateQuestionKCWeight(questionId, kcId, patchDto.getWeight());
        return ResponseEntity.ok(
            ApiResponseDto.<QuestionKCMappingDto>builder().status(ApiResponseStatus.SUCCESS).message(
                    "Question KC weight updated successfully").data(updatedMapping)
                .build()
        );
    }

    @Operation(summary = "Remove question knowledge component mapping", description = "ADMIN-only endpoint to remove a mapping between a question and knowledge component")
    @DeleteMapping("/{questionId}/kcs/{kcId}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<Void>> removeQuestionKCMapping(
        @PathVariable UUID questionId,
        @PathVariable UUID kcId) {
        
        questionKCMappingService.removeKCFromQuestion(questionId, kcId);
        
        return ResponseEntity.ok(
            ApiResponseDto.<Void>builder().status(ApiResponseStatus.SUCCESS).message(
                    "Question knowledge component mapping removed successfully").build()
        );
    }
    
    // Scaffold endpoints
    
    @Operation(summary = "Get question scaffolds", description = "Retrieves all scaffolds for a specific question, ordered by their index")
    @GetMapping("/{questionId}/scaffolds")
    public ResponseEntity<ApiResponseDto<List<ScaffoldDto>>> getQuestionScaffolds(
        @PathVariable UUID questionId) {
        
        List<Scaffold> scaffolds = scaffoldService.getScaffoldsByQuestionId(questionId);
        List<ScaffoldDto> scaffoldDtos = scaffolds.stream()
            .map(scaffoldMapper::mapTo)
            .toList();
            
        return ResponseEntity.ok(
            ApiResponseDto.<List<ScaffoldDto>>builder().status(ApiResponseStatus.SUCCESS).message(
                    "Question scaffolds retrieved successfully").data(scaffoldDtos)
                .build()
        );
    }
    
    @Operation(summary = "Create a new scaffold", description = "ADMIN-only endpoint to create a new scaffold for a question")
    @PostMapping("/{questionId}/scaffolds")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<ScaffoldDto>> createScaffold(
        @PathVariable UUID questionId,
        @Valid @RequestBody ScaffoldDto scaffoldDto) {
        
        Scaffold scaffold = scaffoldMapper.mapFrom(scaffoldDto);
        Scaffold savedScaffold = scaffoldService.createScaffold(questionId, scaffold);
        
        return ResponseEntity.ok(
            ApiResponseDto.<ScaffoldDto>builder().status(ApiResponseStatus.SUCCESS).message(
                    "Scaffold created successfully").data(scaffoldMapper.mapTo(savedScaffold))
                .build()
        );
    }
    
    @Operation(summary = "Get specific scaffold", description = "Retrieves a specific scaffold by ID for a question")
    @GetMapping("/{questionId}/scaffolds/{scaffoldId}")
    public ResponseEntity<ApiResponseDto<ScaffoldDto>> getScaffold(
        @PathVariable UUID questionId,
        @PathVariable UUID scaffoldId) {
        
        Scaffold scaffold = scaffoldService.getScaffold(questionId, scaffoldId);
        
        return ResponseEntity.ok(
            ApiResponseDto.<ScaffoldDto>builder().status(ApiResponseStatus.SUCCESS).message(
                    "Scaffold retrieved successfully").data(scaffoldMapper.mapTo(scaffold))
                .build()
        );
    }
    
    @Operation(summary = "Update a scaffold", description = "ADMIN-only endpoint to update a scaffold's content")
    @PutMapping("/{questionId}/scaffolds/{scaffoldId}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<ScaffoldDto>> updateScaffold(
        @PathVariable UUID questionId,
        @PathVariable UUID scaffoldId,
        @Valid @RequestBody ScaffoldDto scaffoldDto) {
        
        Scaffold scaffold = scaffoldMapper.mapFrom(scaffoldDto);
        Scaffold updatedScaffold = scaffoldService.updateScaffold(questionId, scaffoldId, scaffold);
        
        return ResponseEntity.ok(
            ApiResponseDto.<ScaffoldDto>builder().status(ApiResponseStatus.SUCCESS).message(
                    "Scaffold updated successfully").data(scaffoldMapper.mapTo(updatedScaffold))
                .build()
        );
    }
    
    @Operation(summary = "Delete a scaffold", description = "ADMIN-only endpoint to delete a scaffold")
    @DeleteMapping("/{questionId}/scaffolds/{scaffoldId}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<Void>> deleteScaffold(
        @PathVariable UUID questionId,
        @PathVariable UUID scaffoldId) {
        
        scaffoldService.deleteScaffold(questionId, scaffoldId);
        
        return ResponseEntity.ok(
            ApiResponseDto.<Void>builder().status(ApiResponseStatus.SUCCESS).message(
                    "Scaffold deleted successfully").build()
        );
    }
    
    @Operation(summary = "Reorder scaffolds", description = "ADMIN-only endpoint to reorder all scaffolds for a question")
    @PutMapping("/{questionId}/scaffolds/reorder")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<List<ScaffoldDto>>> reorderScaffolds(
        @PathVariable UUID questionId,
        @Valid @RequestBody ScaffoldReorderDto reorderDto) {
        
        List<Scaffold> reorderedScaffolds = scaffoldService.reorderScaffolds(questionId, reorderDto.getScaffoldIds());
        List<ScaffoldDto> scaffoldDtos = reorderedScaffolds.stream()
            .map(scaffoldMapper::mapTo)
            .toList();
        
        return ResponseEntity.ok(
            ApiResponseDto.<List<ScaffoldDto>>builder().status(ApiResponseStatus.SUCCESS).message(
                    "Scaffolds reordered successfully").data(scaffoldDtos)
                .build()
        );
    }
}
