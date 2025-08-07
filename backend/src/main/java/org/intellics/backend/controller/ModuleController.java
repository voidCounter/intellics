package org.intellics.backend.controller;

import java.util.List;
import java.util.UUID;

import org.intellics.backend.api.ApiResponseDto;
import org.intellics.backend.api.ApiResponseStatus;
import org.intellics.backend.domain.dto.ModuleDto;
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

    public ModuleController(ModuleService moduleService) {
        this.moduleService = moduleService;
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
}
