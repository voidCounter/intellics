package org.intellics.backend.controller;

import java.util.List;
import java.util.UUID;

import org.intellics.backend.api.ApiResponseDto;
import org.intellics.backend.api.ApiResponseStatus;
import org.intellics.backend.domain.dto.ModuleDto;
import org.intellics.backend.domain.dto.ModuleKCLinkRequestDto;
import org.intellics.backend.domain.dto.ModuleKCMappingDto;
import org.intellics.backend.domain.dto.ModuleKCMappingPatchDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentCreateDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentPrerequisiteDto;
import org.intellics.backend.services.ModuleKCMappingService;
import org.intellics.backend.services.ModuleService;
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
@RequestMapping("/api/v1/modules")
public class ModuleController {

    private final ModuleService moduleService;
    private final ModuleKCMappingService moduleKCMappingService;

    public ModuleController(ModuleService moduleService, ModuleKCMappingService moduleKCMappingService) {
        this.moduleService = moduleService;
        this.moduleKCMappingService = moduleKCMappingService;
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponseDto<ModuleDto>> getModuleById(@PathVariable("id") UUID id) {
        ModuleDto moduleDto = moduleService.getModuleById(id);
        return new ResponseEntity<>(new ApiResponseDto<ModuleDto>(ApiResponseStatus.SUCCESS, moduleDto, "Module retrieved successfully."), HttpStatus.OK);
    }

    @GetMapping
    public ResponseEntity<ApiResponseDto<List<ModuleDto>>> getAllModules() {
        List<ModuleDto> modules = moduleService.getAllModules();
        return new ResponseEntity<>(new ApiResponseDto<List<ModuleDto>>(ApiResponseStatus.SUCCESS, modules, "Modules retrieved successfully."), HttpStatus.OK);
    }

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<ModuleDto>> createModule(@Validated @RequestBody ModuleDto moduleDto) {
        ModuleDto createdModule = moduleService.createModule(moduleDto);
        return new ResponseEntity<>(new ApiResponseDto<ModuleDto>(ApiResponseStatus.SUCCESS, createdModule, "Module created successfully."), HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<ModuleDto>> updateModule(@PathVariable("id") UUID id, @Validated @RequestBody ModuleDto moduleDto) {
        ModuleDto updatedModule = moduleService.updateModule(id, moduleDto);
        return new ResponseEntity<>(new ApiResponseDto<ModuleDto>(ApiResponseStatus.SUCCESS, updatedModule, "Module updated successfully."), HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<Void>> deleteModule(@PathVariable("id") UUID id) {
        moduleService.deleteModule(id);
        return new ResponseEntity<>(new ApiResponseDto<Void>(ApiResponseStatus.SUCCESS, null, "Module deleted successfully."), HttpStatus.NO_CONTENT);
    }

    @PatchMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<ModuleDto>> patchModule(@PathVariable("id") UUID id, @RequestBody ModuleDto moduleDto) {
        ModuleDto patchedModule = moduleService.patchModule(id, moduleDto);
        return new ResponseEntity<>(new ApiResponseDto<ModuleDto>(ApiResponseStatus.SUCCESS, patchedModule, "Module patched successfully."), HttpStatus.OK);
    }

    @GetMapping("/{moduleId}/kcs")
    public ResponseEntity<ApiResponseDto<List<KnowledgeComponentPrerequisiteDto>>> getKnowledgeComponentsByModule(@PathVariable("moduleId") UUID moduleId) {
        List<KnowledgeComponentPrerequisiteDto> kcs = moduleService.getKnowledgeComponentsByModule(moduleId);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, kcs, "Knowledge Components for module retrieved successfully."), HttpStatus.OK);
    }

    @GetMapping("/{moduleId}/kcs/{kcId}")
    public ResponseEntity<ApiResponseDto<KnowledgeComponentPrerequisiteDto>> getKnowledgeComponentByModule(@PathVariable("moduleId") UUID moduleId, @PathVariable("kcId") UUID kcId) {
        KnowledgeComponentPrerequisiteDto kc = moduleService.getKnowledgeComponentByModule(moduleId, kcId);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, kc, "Knowledge Component retrieved successfully."), HttpStatus.OK);
    }

    @PostMapping("/{moduleId}/kcs/link")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<ModuleKCMappingDto>> addKnowledgeComponentToModule(
            @PathVariable("moduleId") UUID moduleId,
            @Validated @RequestBody ModuleKCLinkRequestDto linkRequestDto) {
        ModuleKCMappingDto mapping = moduleService.addKnowledgeComponentToModule(moduleId, linkRequestDto.getKcId(), null);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, mapping, "Knowledge Component added to module successfully."), HttpStatus.CREATED);
    }

    @DeleteMapping("/{moduleId}/kcs/{kcId}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<Void>> removeKnowledgeComponentFromModule(@PathVariable("moduleId") UUID moduleId, @PathVariable("kcId") UUID kcId) {
        moduleService.removeKnowledgeComponentFromModule(moduleId, kcId);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, null, "Knowledge Component removed from module successfully."), HttpStatus.NO_CONTENT);
    }

    @DeleteMapping("/{moduleId}/kcs")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<Void>> removeAllKnowledgeComponentsFromModule(@PathVariable("moduleId") UUID moduleId) {
        moduleService.removeAllKnowledgeComponentsFromModule(moduleId);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, null, "All Knowledge Components removed from module successfully."), HttpStatus.NO_CONTENT);
    }

    @PostMapping("/{moduleId}/kcs")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<KnowledgeComponentPrerequisiteDto>> createAndAddKnowledgeComponentToModule(
            @PathVariable("moduleId") UUID moduleId,
            @Validated @RequestBody KnowledgeComponentCreateDto kcCreateDto) {
        KnowledgeComponentPrerequisiteDto newKc = moduleService.createAndAddKnowledgeComponentToModule(moduleId, kcCreateDto);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, newKc, "New Knowledge Component created and added to module successfully."), HttpStatus.CREATED);
    }

    @PatchMapping("/{moduleId}/kcs/{kcId}/prerequisites")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDto<ModuleKCMappingDto>> patchModuleKCMapping(
            @PathVariable("moduleId") UUID moduleId,
            @PathVariable("kcId") UUID kcId,
            @RequestBody ModuleKCMappingPatchDto patchDto) {
        ModuleKCMappingDto updatedMapping = moduleKCMappingService.patchModuleKCMapping(moduleId, kcId, patchDto);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, updatedMapping, "Prerequisites updated successfully."), HttpStatus.OK);
    }
}
