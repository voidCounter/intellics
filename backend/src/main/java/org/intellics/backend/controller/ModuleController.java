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
import org.intellics.backend.domain.dto.ModuleDto;
import org.intellics.backend.domain.dto.ModuleKCLinkRequestDto;
import org.intellics.backend.domain.dto.ModuleKCMappingDto;
import org.intellics.backend.domain.dto.ModuleKCMappingPatchDto;
import org.intellics.backend.domain.dto.ModuleLessonLinkRequestDto;
import org.intellics.backend.domain.dto.ModuleLessonMappingDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentCreateDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentPrerequisiteDto;
import org.intellics.backend.services.LessonService;
import org.intellics.backend.services.ModuleKCMappingService;
import org.intellics.backend.services.ModuleLessonMappingService;
import org.intellics.backend.services.ModuleService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/modules")
@Tag(name = "Modules", description = "APIs for managing learning modules")
public class ModuleController {

    private final ModuleService moduleService;
    private final ModuleKCMappingService moduleKCMappingService;
    private final ModuleLessonMappingService moduleLessonMappingService;
    private final LessonService lessonService;

    public ModuleController(ModuleService moduleService, ModuleKCMappingService moduleKCMappingService, ModuleLessonMappingService moduleLessonMappingService, LessonService lessonService) {
        this.moduleService = moduleService;
        this.moduleKCMappingService = moduleKCMappingService;
        this.moduleLessonMappingService = moduleLessonMappingService;
        this.lessonService = lessonService;
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get module by ID", description = "Retrieves a specific module by its unique identifier")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Module found successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "404", description = "Module not found")
    })
    public ResponseEntity<ApiResponseDto<ModuleDto>> getModuleById(
            @Parameter(description = "Unique identifier of the module") @PathVariable("id") UUID id) {
        ModuleDto moduleDto = moduleService.getModuleById(id);
        return new ResponseEntity<>(new ApiResponseDto<ModuleDto>(ApiResponseStatus.SUCCESS, moduleDto, "Module retrieved successfully."), HttpStatus.OK);
    }

    @GetMapping
    @Operation(summary = "Get all modules", description = "Retrieves all available learning modules")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Modules retrieved successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class)))
    })
    public ResponseEntity<ApiResponseDto<List<ModuleDto>>> getAllModules() {
        List<ModuleDto> modules = moduleService.getAllModules();
        return new ResponseEntity<>(new ApiResponseDto<List<ModuleDto>>(ApiResponseStatus.SUCCESS, modules, "Modules retrieved successfully."), HttpStatus.OK);
    }

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Create a new module", description = "Creates a new learning module")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Module created successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "400", description = "Invalid input data"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required")
    })
    public ResponseEntity<ApiResponseDto<ModuleDto>> createModule(
            @Parameter(description = "Module data to create") @Validated @RequestBody ModuleDto moduleDto) {
        ModuleDto createdModule = moduleService.createModule(moduleDto);
        return new ResponseEntity<>(new ApiResponseDto<ModuleDto>(ApiResponseStatus.SUCCESS, createdModule, "Module created successfully."), HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Update module", description = "Updates an existing module with new data")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Module updated successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "400", description = "Invalid input data"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required"),
            @ApiResponse(responseCode = "404", description = "Module not found")
    })
    public ResponseEntity<ApiResponseDto<ModuleDto>> updateModule(
            @Parameter(description = "Unique identifier of the module") @PathVariable("id") UUID id,
            @Parameter(description = "Updated module data") @Validated @RequestBody ModuleDto moduleDto) {
        ModuleDto updatedModule = moduleService.updateModule(id, moduleDto);
        return new ResponseEntity<>(new ApiResponseDto<ModuleDto>(ApiResponseStatus.SUCCESS, updatedModule, "Module updated successfully."), HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Delete module", description = "Permanently deletes a module")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Module deleted successfully"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required"),
            @ApiResponse(responseCode = "404", description = "Module not found")
    })
    public ResponseEntity<ApiResponseDto<Void>> deleteModule(
            @Parameter(description = "Unique identifier of the module to delete") @PathVariable("id") UUID id) {
        moduleService.deleteModule(id);
        return new ResponseEntity<>(new ApiResponseDto<Void>(ApiResponseStatus.SUCCESS, null, "Module deleted successfully."), HttpStatus.NO_CONTENT);
    }

    @PatchMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Patch module", description = "Partially updates a module with only the provided fields")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Module patched successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "400", description = "Invalid input data"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required"),
            @ApiResponse(responseCode = "404", description = "Module not found")
    })
    public ResponseEntity<ApiResponseDto<ModuleDto>> patchModule(
            @Parameter(description = "Unique identifier of the module") @PathVariable("id") UUID id,
            @Parameter(description = "Partial module data to update") @RequestBody ModuleDto moduleDto) {
        ModuleDto patchedModule = moduleService.patchModule(id, moduleDto);
        return new ResponseEntity<>(new ApiResponseDto<ModuleDto>(ApiResponseStatus.SUCCESS, patchedModule, "Module patched successfully."), HttpStatus.OK);
    }

    @GetMapping("/{moduleId}/kcs")
    @Operation(summary = "Get KCs by module ID", description = "Retrieves all knowledge components assigned to a specific module")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Knowledge components retrieved successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "404", description = "Module not found")
    })
    public ResponseEntity<ApiResponseDto<List<KnowledgeComponentPrerequisiteDto>>> getKnowledgeComponentsByModule(
            @Parameter(description = "Unique identifier of the module") @PathVariable("moduleId") UUID moduleId) {
        List<KnowledgeComponentPrerequisiteDto> kcs = moduleService.getKnowledgeComponentsByModule(moduleId);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, kcs, "Knowledge Components for module retrieved successfully."), HttpStatus.OK);
    }

    @GetMapping("/{moduleId}/kcs/{kcId}")
    @Operation(summary = "Get KC by module and KC ID", description = "Retrieves a specific knowledge component within a module")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Knowledge component retrieved successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "404", description = "Module or KC not found")
    })
    public ResponseEntity<ApiResponseDto<KnowledgeComponentPrerequisiteDto>> getKnowledgeComponentByModule(
            @Parameter(description = "Unique identifier of the module") @PathVariable("moduleId") UUID moduleId,
            @Parameter(description = "Unique identifier of the knowledge component") @PathVariable("kcId") UUID kcId) {
        KnowledgeComponentPrerequisiteDto kc = moduleService.getKnowledgeComponentByModule(moduleId, kcId);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, kc, "Knowledge Component retrieved successfully."), HttpStatus.OK);
    }

    @PostMapping("/{moduleId}/kcs/link")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Link KC to module", description = "Links an existing knowledge component to a module")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Knowledge component linked to module successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "400", description = "Invalid input data"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required"),
            @ApiResponse(responseCode = "404", description = "Module or KC not found")
    })
    public ResponseEntity<ApiResponseDto<ModuleKCMappingDto>> addKnowledgeComponentToModule(
            @Parameter(description = "Unique identifier of the module") @PathVariable("moduleId") UUID moduleId,
            @Parameter(description = "KC linking data") @Validated @RequestBody ModuleKCLinkRequestDto linkRequestDto) {
        ModuleKCMappingDto mapping = moduleService.addKnowledgeComponentToModule(moduleId, linkRequestDto.getKcId(), null);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, mapping, "Knowledge Component added to module successfully."), HttpStatus.CREATED);
    }

    @DeleteMapping("/{moduleId}/kcs/{kcId}")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Remove KC from module", description = "Removes a specific knowledge component from a module")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Knowledge component removed from module successfully"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required"),
            @ApiResponse(responseCode = "404", description = "Module or KC not found")
    })
    public ResponseEntity<ApiResponseDto<Void>> removeKnowledgeComponentFromModule(
            @Parameter(description = "Unique identifier of the module") @PathVariable("moduleId") UUID moduleId,
            @Parameter(description = "Unique identifier of the knowledge component") @PathVariable("kcId") UUID kcId) {
        moduleService.removeKnowledgeComponentFromModule(moduleId, kcId);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, null, "Knowledge Component removed from module successfully."), HttpStatus.NO_CONTENT);
    }

    @DeleteMapping("/{moduleId}/kcs")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Remove all KCs from module", description = "Removes all knowledge components from a module")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "All knowledge components removed from module successfully"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required"),
            @ApiResponse(responseCode = "404", description = "Module not found")
    })
    public ResponseEntity<ApiResponseDto<Void>> removeAllKnowledgeComponentsFromModule(
            @Parameter(description = "Unique identifier of the module") @PathVariable("moduleId") UUID moduleId) {
        moduleService.removeAllKnowledgeComponentsFromModule(moduleId);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, null, "All Knowledge Components removed from module successfully."), HttpStatus.NO_CONTENT);
    }

    @PostMapping("/{moduleId}/kcs")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Create and add KC to module", description = "Creates a new knowledge component and adds it to a module")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Knowledge component created and added to module successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "400", description = "Invalid input data"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required"),
            @ApiResponse(responseCode = "404", description = "Module not found")
    })
    public ResponseEntity<ApiResponseDto<KnowledgeComponentPrerequisiteDto>> createAndAddKnowledgeComponentToModule(
            @Parameter(description = "Unique identifier of the module") @PathVariable("moduleId") UUID moduleId,
            @Parameter(description = "Knowledge component data to create") @Validated @RequestBody KnowledgeComponentCreateDto kcCreateDto) {
        KnowledgeComponentPrerequisiteDto newKc = moduleService.createAndAddKnowledgeComponentToModule(moduleId, kcCreateDto);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, newKc, "New Knowledge Component created and added to module successfully."), HttpStatus.CREATED);
    }

    @PatchMapping("/{moduleId}/kcs/{kcId}/prerequisites")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Patch module KC mapping", description = "Partially updates the mapping between a module and knowledge component, including prerequisites")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Module KC mapping patched successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "400", description = "Invalid input data"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required"),
            @ApiResponse(responseCode = "404", description = "Module or KC not found")
    })
    public ResponseEntity<ApiResponseDto<ModuleKCMappingDto>> patchModuleKCMapping(
            @Parameter(description = "Unique identifier of the module") @PathVariable("moduleId") UUID moduleId,
            @Parameter(description = "Unique identifier of the knowledge component") @PathVariable("kcId") UUID kcId,
            @Parameter(description = "Partial mapping data to update") @Validated @RequestBody ModuleKCMappingPatchDto patchDto) {
        ModuleKCMappingDto updatedMapping = moduleKCMappingService.patchModuleKCMapping(moduleId, kcId, patchDto);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, updatedMapping, "Prerequisites updated successfully."), HttpStatus.OK);
    }

    // Lesson-related endpoints
    @GetMapping("/{moduleId}/lessons")
    @Operation(summary = "Get lessons by module ID", description = "Retrieves all lessons assigned to a specific module")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Lessons retrieved successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "404", description = "Module not found")
    })
    public ResponseEntity<ApiResponseDto<List<ModuleLessonMappingDto>>> getLessonsByModuleId(
            @Parameter(description = "Unique identifier of the module") @PathVariable("moduleId") UUID moduleId) {
        List<ModuleLessonMappingDto> lessons = moduleLessonMappingService.getLessonsByModuleId(moduleId);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, lessons, "Lessons retrieved successfully for module."), HttpStatus.OK);
    }

    @PostMapping("/{moduleId}/lessons")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Add lesson to module", description = "Adds an existing lesson to a module")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Lesson added to module successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "400", description = "Invalid input data"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required"),
            @ApiResponse(responseCode = "404", description = "Module or lesson not found")
    })
    public ResponseEntity<ApiResponseDto<ModuleLessonMappingDto>> addLessonToModule(
            @Parameter(description = "Unique identifier of the module") @PathVariable("moduleId") UUID moduleId,
            @Parameter(description = "Lesson linking data") @Validated @RequestBody ModuleLessonLinkRequestDto requestDto) {
        ModuleLessonMappingDto createdMapping = moduleLessonMappingService.addLessonToModule(moduleId, requestDto.getLessonId());
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, createdMapping, "Lesson added to module successfully."), HttpStatus.CREATED);
    }

    @PostMapping("/{moduleId}/lessons/create")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Create lesson and add to module", description = "Creates a new lesson and automatically adds it to the specified module")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Lesson created and added to module successfully",
                    content = @Content(schema = @Schema(implementation = ApiResponseDto.class))),
            @ApiResponse(responseCode = "400", description = "Invalid input data or lesson KCs not available in module"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required"),
            @ApiResponse(responseCode = "404", description = "Module not found")
    })
    public ResponseEntity<ApiResponseDto<LessonDto>> createLessonForModule(
            @Parameter(description = "Unique identifier of the module") @PathVariable("moduleId") UUID moduleId,
            @Parameter(description = "Lesson data to create") @Validated @RequestBody LessonDto lessonDto) {
        
        LessonDto createdLesson = moduleService.createLessonForModule(moduleId, lessonDto);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, createdLesson, "Lesson created and added to module successfully."), HttpStatus.CREATED);
    }

    @DeleteMapping("/{moduleId}/lessons/{lessonId}")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Remove lesson from module", description = "Removes a specific lesson from a module")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Lesson removed from module successfully"),
            @ApiResponse(responseCode = "403", description = "Access denied - Admin role required"),
            @ApiResponse(responseCode = "404", description = "Module or lesson not found")
    })
    public ResponseEntity<ApiResponseDto<Void>> removeLessonFromModule(
            @Parameter(description = "Unique identifier of the module") @PathVariable("moduleId") UUID moduleId,
            @Parameter(description = "Unique identifier of the lesson") @PathVariable("lessonId") UUID lessonId) {
        moduleLessonMappingService.removeLessonFromModule(moduleId, lessonId);
        return new ResponseEntity<>(new ApiResponseDto<>(ApiResponseStatus.SUCCESS, null, "Lesson removed from module successfully."), HttpStatus.NO_CONTENT);
    }


}
