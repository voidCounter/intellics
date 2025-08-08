package org.intellics.backend.controller;

import java.util.List;
import java.util.UUID;

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
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/kcs")
public class KnowledgeComponentController {

    private final KnowledgeComponentService knowledgeComponentService;

    public KnowledgeComponentController(KnowledgeComponentService knowledgeComponentService) {
        this.knowledgeComponentService = knowledgeComponentService;
    }

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<KnowledgeComponentSimpleDto>> createKnowledgeComponent(@Validated @RequestBody KnowledgeComponentCreateDto knowledgeComponentCreateDto) {
        KnowledgeComponentSimpleDto savedKnowledgeComponentDto = knowledgeComponentService.createKnowledgeComponent(knowledgeComponentCreateDto);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, savedKnowledgeComponentDto, "Knowledge Component created successfully."), HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<ApiResponseDto<List<KnowledgeComponentSimpleDto>>> getAllKnowledgeComponents() {
        List<KnowledgeComponentSimpleDto> knowledgeComponents = knowledgeComponentService.findAll();
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, knowledgeComponents, "Knowledge Components retrieved successfully."), HttpStatus.OK);
    }

    @GetMapping(path = "/{id}")
    public ResponseEntity<ApiResponseDto<KnowledgeComponentSimpleDto>> getKnowledgeComponentById(@PathVariable("id") UUID id) {
        KnowledgeComponentSimpleDto knowledgeComponentDto = knowledgeComponentService.findOne(id)
                .orElseThrow(() -> new RuntimeException("Knowledge Component not found"));
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, knowledgeComponentDto, "Knowledge Component retrieved successfully."), HttpStatus.OK);
    }

    @PutMapping(path = "/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<KnowledgeComponentSimpleDto>> updateKnowledgeComponent(@PathVariable("id") UUID id, @Validated @RequestBody KnowledgeComponentUpdateDto knowledgeComponentUpdateDto) {
        KnowledgeComponentSimpleDto updatedKnowledgeComponentDto = knowledgeComponentService.updateKnowledgeComponent(id, knowledgeComponentUpdateDto);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, updatedKnowledgeComponentDto, "Knowledge Component updated successfully."), HttpStatus.OK);
    }

    @DeleteMapping(path = "/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<Void>> deleteKnowledgeComponent(@PathVariable("id") UUID id) {
        knowledgeComponentService.delete(id);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, null, "Knowledge Component deleted successfully."), HttpStatus.NO_CONTENT);
    }

    @PatchMapping(path = "/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<KnowledgeComponentSimpleDto>> patchKnowledgeComponent(@PathVariable("id") UUID id, @Validated @RequestBody KnowledgeComponentPatchDto knowledgeComponentPatchDto) {
        KnowledgeComponentSimpleDto patchedKnowledgeComponent = knowledgeComponentService.patchKnowledgeComponent(id, knowledgeComponentPatchDto);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, patchedKnowledgeComponent, "Knowledge Component patched successfully."), HttpStatus.OK);
    }
}
