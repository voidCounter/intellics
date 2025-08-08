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
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentCreateDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentPatchDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentSimpleDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentUpdateDto;
import org.intellics.backend.services.KnowledgeComponentService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/kcs")
@Tag(name = "Knowledge Components", description = "APIs for managing knowledge components (KCs)")
public class KnowledgeComponentController {

    private final KnowledgeComponentService knowledgeComponentService;

    public KnowledgeComponentController(KnowledgeComponentService knowledgeComponentService) {
        this.knowledgeComponentService = knowledgeComponentService;
    }

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Create a new knowledge component", description = "Creates a new knowledge component (KC) with the provided details")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Knowledge component created successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "400", description = "Invalid input data"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required")
    })
    public ResponseEntity<ApiResponseDto<KnowledgeComponentSimpleDto>> createKnowledgeComponent(
            @Parameter(description = "Knowledge component data to create") @Validated @RequestBody KnowledgeComponentCreateDto knowledgeComponentCreateDto) {
        KnowledgeComponentSimpleDto savedKnowledgeComponentDto = knowledgeComponentService.createKnowledgeComponent(knowledgeComponentCreateDto);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, savedKnowledgeComponentDto, "Knowledge Component created successfully."), HttpStatus.CREATED);
    }

    @GetMapping
    @Operation(summary = "Get all knowledge components", description = "Retrieves all available knowledge components")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Knowledge components retrieved successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class)))
    })
    public ResponseEntity<ApiResponseDto<List<KnowledgeComponentSimpleDto>>> getAllKnowledgeComponents() {
        List<KnowledgeComponentSimpleDto> knowledgeComponents = knowledgeComponentService.findAll();
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, knowledgeComponents, "Knowledge Components retrieved successfully."), HttpStatus.OK);
    }

    @GetMapping(path = "/{id}")
    @Operation(summary = "Get knowledge component by ID", description = "Retrieves a specific knowledge component by its unique identifier")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Knowledge component found successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "404", description = "Knowledge component not found")
    })
    public ResponseEntity<ApiResponseDto<KnowledgeComponentSimpleDto>> getKnowledgeComponentById(
            @Parameter(description = "Unique identifier of the knowledge component") @PathVariable("id") UUID id) {
        KnowledgeComponentSimpleDto knowledgeComponentDto = knowledgeComponentService.findOne(id)
                .orElseThrow(() -> new RuntimeException("Knowledge Component not found"));
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, knowledgeComponentDto, "Knowledge Component retrieved successfully."), HttpStatus.OK);
    }

    @PutMapping(path = "/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Update knowledge component", description = "Updates an existing knowledge component with new data")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Knowledge component updated successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "400", description = "Invalid input data"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required"),
            @ApiResponse(responseCode = "404", description = "Knowledge component not found")
    })
    public ResponseEntity<ApiResponseDto<KnowledgeComponentSimpleDto>> updateKnowledgeComponent(
            @Parameter(description = "Unique identifier of the knowledge component") @PathVariable("id") UUID id,
            @Parameter(description = "Updated knowledge component data") @Validated @RequestBody KnowledgeComponentUpdateDto knowledgeComponentUpdateDto) {
        KnowledgeComponentSimpleDto updatedKnowledgeComponentDto = knowledgeComponentService.updateKnowledgeComponent(id, knowledgeComponentUpdateDto);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, updatedKnowledgeComponentDto, "Knowledge Component updated successfully."), HttpStatus.OK);
    }

    @DeleteMapping(path = "/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Delete knowledge component", description = "Permanently deletes a knowledge component")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Knowledge component deleted successfully"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required"),
            @ApiResponse(responseCode = "404", description = "Knowledge component not found")
    })
    public ResponseEntity<ApiResponseDto<Void>> deleteKnowledgeComponent(
            @Parameter(description = "Unique identifier of the knowledge component to delete") @PathVariable("id") UUID id) {
        knowledgeComponentService.delete(id);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, null, "Knowledge Component deleted successfully."), HttpStatus.NO_CONTENT);
    }

    @PatchMapping(path = "/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Patch knowledge component", description = "Partially updates a knowledge component with only the provided fields")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Knowledge component patched successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "400", description = "Invalid input data"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required"),
            @ApiResponse(responseCode = "404", description = "Knowledge component not found")
    })
    public ResponseEntity<ApiResponseDto<KnowledgeComponentSimpleDto>> patchKnowledgeComponent(
            @Parameter(description = "Unique identifier of the knowledge component") @PathVariable("id") UUID id,
            @Parameter(description = "Partial knowledge component data to update") @Validated @RequestBody KnowledgeComponentPatchDto knowledgeComponentPatchDto) {
        KnowledgeComponentSimpleDto patchedKnowledgeComponent = knowledgeComponentService.patchKnowledgeComponent(id, knowledgeComponentPatchDto);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, patchedKnowledgeComponent, "Knowledge Component patched successfully."), HttpStatus.OK);
    }
}
