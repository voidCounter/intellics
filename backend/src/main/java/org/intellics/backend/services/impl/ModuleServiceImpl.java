package org.intellics.backend.services.impl;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import org.intellics.backend.api.error.exceptions.ItemNotFoundException;
import org.intellics.backend.domain.dto.LessonDto;
import org.intellics.backend.domain.dto.ModuleDto;
import org.intellics.backend.domain.dto.ModuleKCMappingDto;
import org.intellics.backend.domain.dto.PrerequisiteWithRationaleDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentCreateDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentPrerequisiteDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentSimpleDto;
import org.intellics.backend.domain.entities.KnowledgeComponent;
import org.intellics.backend.domain.entities.Module;
import org.intellics.backend.domain.entities.ModuleKCMapping;
import org.intellics.backend.domain.entities.ModuleKCMappingId;
import org.intellics.backend.mappers.Mapper;
import org.intellics.backend.repositories.ModuleKCMappingRepository;
import org.intellics.backend.repositories.ModuleRepository;
import org.intellics.backend.services.KnowledgeComponentService;
import org.intellics.backend.services.LessonService;
import org.intellics.backend.services.ModuleKCMappingService;
import org.intellics.backend.services.ModuleLessonMappingService;
import org.intellics.backend.services.ModuleService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.intellics.backend.repositories.ModuleKCPrerequisiteRepository;
import org.intellics.backend.repositories.KnowledgeComponentRepository;
import org.intellics.backend.domain.entities.ModuleKCPrerequisite;

@Service
public class ModuleServiceImpl implements ModuleService {

    private final ModuleRepository moduleRepository;
    private final Mapper<ModuleDto, Module> moduleMapper;
    private final ModuleKCMappingRepository moduleKCMappingRepository;
    private final ModuleKCMappingService moduleKCMappingService;
    private final KnowledgeComponentService knowledgeComponentService;
    private final ModuleLessonMappingService moduleLessonMappingService;
    private final LessonService lessonService;
    private final KnowledgeComponentRepository knowledgeComponentRepository;
    private final ModuleKCPrerequisiteRepository moduleKCPrerequisiteRepository;

    public ModuleServiceImpl(ModuleRepository moduleRepository,
                             Mapper<ModuleDto, Module> moduleMapper,
                             ModuleKCMappingRepository moduleKCMappingRepository,
                             ModuleKCMappingService moduleKCMappingService,
                             KnowledgeComponentService knowledgeComponentService,
                             ModuleLessonMappingService moduleLessonMappingService,
                             LessonService lessonService,
                             Mapper<KnowledgeComponentPrerequisiteDto, KnowledgeComponent> knowledgeComponentPrerequisiteMapper,
                             KnowledgeComponentRepository knowledgeComponentRepository,
                                                           ModuleKCPrerequisiteRepository moduleKCPrerequisiteRepository) {
        this.moduleRepository = moduleRepository;
        this.moduleMapper = moduleMapper;
        this.moduleKCMappingRepository = moduleKCMappingRepository;
        this.moduleKCMappingService = moduleKCMappingService;
        this.knowledgeComponentService = knowledgeComponentService;
        this.moduleLessonMappingService = moduleLessonMappingService;
        this.lessonService = lessonService;
        this.knowledgeComponentRepository = knowledgeComponentRepository;
        this.moduleKCPrerequisiteRepository = moduleKCPrerequisiteRepository;
    }

    @Override
    public ModuleDto getModuleById(UUID id) {
        Module module = moduleRepository.findById(id)
                .orElseThrow(() -> new ItemNotFoundException("Module not found with id: " + id));
        return moduleMapper.mapTo(module);
    }

    @Override
    public List<ModuleDto> getAllModules() {
        return StreamSupport.stream(moduleRepository.findAll().spliterator(), false)
                .map(moduleMapper::mapTo)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public ModuleDto createModule(ModuleDto moduleDto) {
        Module module = moduleMapper.mapFrom(moduleDto);
        module.setModule_id(null); // Ensure ID is null for new entity
        Module savedModule = moduleRepository.save(module);
        return moduleMapper.mapTo(savedModule);
    }

    @Override
    @Transactional
    public ModuleDto updateModule(UUID id, ModuleDto moduleDto) {
        Module existingModule = moduleRepository.findById(id)
                .orElseThrow(() -> new ItemNotFoundException("Module not found with id: " + id));
        existingModule.setModule_name(moduleDto.getModule_name());
        existingModule.setDescription(moduleDto.getDescription());
        Module updatedModule = moduleRepository.save(existingModule);
        return moduleMapper.mapTo(updatedModule);
    }

    @Override
    @Transactional
    public void deleteModule(UUID id) {
        if (!moduleRepository.existsById(id)) {
            throw new ItemNotFoundException("Module not found with id: " + id);
        }
        moduleRepository.deleteById(id);
    }

    @Override
    @Transactional
    public ModuleDto patchModule(UUID id, ModuleDto moduleDto) {
        Module existingModule = moduleRepository.findById(id)
                .orElseThrow(() -> new ItemNotFoundException("Module not found with id: " + id));

        if (moduleDto.getModule_name() != null) {
            existingModule.setModule_name(moduleDto.getModule_name());
        }
        if (moduleDto.getDescription() != null) {
            existingModule.setDescription(moduleDto.getDescription());
        }

        Module patchedModule = moduleRepository.save(existingModule);
        return moduleMapper.mapTo(patchedModule);
    }

    @Override
    public List<KnowledgeComponentPrerequisiteDto> getKnowledgeComponentsByModule(UUID moduleId) {
        Module module = moduleRepository.findById(moduleId)
                .orElseThrow(() -> new ItemNotFoundException("Module not found with id: " + moduleId));

        return moduleKCMappingRepository.findByModule(module).stream()
                .filter(mapping -> mapping.getKnowledgeComponent().getIsActive()) // Only include active KCs
                .map(mapping -> {
                    KnowledgeComponent kc = mapping.getKnowledgeComponent();
                    
                    // Get prerequisites from the ModuleKCPrerequisite table
                    List<UUID> prerequisiteKcIds = StreamSupport.stream(moduleKCPrerequisiteRepository.findAll().spliterator(), false)
                            .filter(p -> p.getId().getModuleId().equals(moduleId) && p.getId().getKcId().equals(kc.getKc_id()))
                            .map(p -> p.getId().getPrerequisiteKcId())
                            .collect(Collectors.toList());
                    
                    KnowledgeComponentPrerequisiteDto dto = KnowledgeComponentPrerequisiteDto.builder()
                            .kc_id(kc.getKc_id())
                            .kc_name(kc.getKc_name())
                            .description(kc.getDescription())
                            .prerequisiteKcIds(prerequisiteKcIds)
                            .build();
                    return dto;
                })
                .collect(Collectors.toList());
    }

    @Override
    public KnowledgeComponentPrerequisiteDto getKnowledgeComponentByModule(UUID moduleId, UUID kcId) {
        Module module = moduleRepository.findById(moduleId)
                .orElseThrow(() -> new ItemNotFoundException("Module not found with id: " + moduleId));

        return moduleKCMappingRepository.findByModule(module).stream()
                .filter(mapping -> mapping.getKnowledgeComponent().getKc_id().equals(kcId))
                .filter(mapping -> mapping.getKnowledgeComponent().getIsActive()) // Only include active KCs
                .findFirst()
                .map(mapping -> {
                    KnowledgeComponent kc = mapping.getKnowledgeComponent();
                    
                    // Get prerequisites from the ModuleKCPrerequisite table
                    List<UUID> prerequisiteKcIds = StreamSupport.stream(moduleKCPrerequisiteRepository.findAll().spliterator(), false)
                            .filter(p -> p.getId().getModuleId().equals(moduleId) && p.getId().getKcId().equals(kc.getKc_id()))
                            .map(p -> p.getId().getPrerequisiteKcId())
                            .collect(Collectors.toList());
                    
                    return KnowledgeComponentPrerequisiteDto.builder()
                            .kc_id(kc.getKc_id())
                            .kc_name(kc.getKc_name())
                            .description(kc.getDescription())
                            .prerequisiteKcIds(prerequisiteKcIds)
                            .build();
                })
                .orElseThrow(() -> new ItemNotFoundException("Knowledge Component not found in module with id: " + kcId));
    }

    @Override
    @Transactional
    public ModuleKCMappingDto addKnowledgeComponentToModule(UUID moduleId, UUID kcId, List<UUID> prerequisiteKcIds) {
        ModuleKCMappingDto moduleKCMappingDto = ModuleKCMappingDto.builder()
                .moduleId(moduleId)
                .kcId(kcId)
                .prerequisiteKcIds(prerequisiteKcIds)
                .build();
        return moduleKCMappingService.createModuleKCMapping(moduleKCMappingDto);
    }

    @Override
    @Transactional
    public ModuleKCMappingDto addKnowledgeComponentToModuleWithRationale(UUID moduleId, UUID kcId, List<PrerequisiteWithRationaleDto> prerequisites) {
        ModuleKCMappingDto moduleKCMappingDto = ModuleKCMappingDto.builder()
                .moduleId(moduleId)
                .kcId(kcId)
                .prerequisitesWithRationale(prerequisites)
                .build();
        return moduleKCMappingService.createModuleKCMapping(moduleKCMappingDto);
    }

    @Override
    @Transactional
    public ModuleKCMappingDto addSinglePrerequisiteToKC(UUID moduleId, UUID kcId, PrerequisiteWithRationaleDto prerequisite) {
        // Verify module and KC exist
        Module module = moduleRepository.findById(moduleId)
                .orElseThrow(() -> new ItemNotFoundException("Module not found with id: " + moduleId));
        
        KnowledgeComponent kc = knowledgeComponentRepository.findById(kcId)
                .orElseThrow(() -> new ItemNotFoundException("Knowledge Component not found with id: " + kcId));
        
        // Verify the KC is already mapped to the module
        ModuleKCMappingId mappingId = ModuleKCMappingId.builder()
                .moduleId(moduleId)
                .kcId(kcId)
                .build();
        
        if (!moduleKCMappingRepository.existsById(mappingId)) {
            throw new ItemNotFoundException("Knowledge Component is not mapped to this module. Please add the KC to the module first.");
        }
        
        // Add the single prerequisite using the existing service
        return moduleKCMappingService.addSinglePrerequisite(module, kc, prerequisite);
    }

    @Override
    @Transactional
    public void removeSinglePrerequisiteFromKC(UUID moduleId, UUID kcId, UUID prerequisiteKcId) {
        // Verify module and KC exist
        Module module = moduleRepository.findById(moduleId)
                .orElseThrow(() -> new ItemNotFoundException("Module not found with id: " + moduleId));
        
        KnowledgeComponent kc = knowledgeComponentRepository.findById(kcId)
                .orElseThrow(() -> new ItemNotFoundException("Knowledge Component not found with id: " + kcId));
        
        // Verify the KC is mapped to the module
        ModuleKCMappingId mappingId = ModuleKCMappingId.builder()
                .moduleId(moduleId)
                .kcId(kcId)
                .build();
        
        if (!moduleKCMappingRepository.existsById(mappingId)) {
            throw new ItemNotFoundException("Knowledge Component is not mapped to this module.");
        }
        
        // Remove the prerequisite using the existing service
        moduleKCMappingService.removeSinglePrerequisite(module, kc, prerequisiteKcId);
    }

    @Override
    public List<PrerequisiteWithRationaleDto> getPrerequisitesWithRationale(UUID moduleId, UUID kcId) {
        // Verify module and KC exist
        Module module = moduleRepository.findById(moduleId)
                .orElseThrow(() -> new ItemNotFoundException("Module not found with id: " + moduleId));
        
        KnowledgeComponent kc = knowledgeComponentRepository.findById(kcId)
                .orElseThrow(() -> new ItemNotFoundException("Knowledge Component not found with id: " + kcId));
        
        // Get prerequisites with rationale from the prerequisite table
        return StreamSupport.stream(moduleKCPrerequisiteRepository.findAll().spliterator(), false)
                .filter(p -> p.getId().getModuleId().equals(moduleId) && p.getId().getKcId().equals(kcId))
                .map(p -> PrerequisiteWithRationaleDto.builder()
                        .prerequisiteKcId(p.getId().getPrerequisiteKcId())
                        .rationale(p.getRationale())
                        .build())
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void removeKnowledgeComponentFromModule(UUID moduleId, UUID kcId) {
        moduleKCMappingService.delete(moduleId, kcId);
    }

    @Override
    @Transactional
    public void removeAllKnowledgeComponentsFromModule(UUID moduleId) {
        Module module = moduleRepository.findById(moduleId)
                .orElseThrow(() -> new ItemNotFoundException("Module not found with id: " + moduleId));
        
        List<ModuleKCMapping> allMappings = moduleKCMappingRepository.findByModule(module);
        
        // Clear all prerequisite relationships first to avoid foreign key issues
        for (ModuleKCMapping mapping : allMappings) {
            // Get prerequisites for this mapping from the ModuleKCPrerequisite table
            List<ModuleKCPrerequisite> prerequisites = StreamSupport.stream(moduleKCPrerequisiteRepository.findAll().spliterator(), false)
                    .filter(p -> p.getId().getModuleId().equals(moduleId) && p.getId().getKcId().equals(mapping.getKnowledgeComponent().getKc_id()))
                    .collect(Collectors.toList());
            
            // Delete all prerequisites for this mapping
            moduleKCPrerequisiteRepository.deleteAll(prerequisites);
        }
        
        // Now delete all KC mappings for this module
        for (ModuleKCMapping mapping : allMappings) {
            moduleKCMappingRepository.deleteById(mapping.getMappingId());
        }
    }

    @Override
    @Transactional
    public KnowledgeComponentPrerequisiteDto createAndAddKnowledgeComponentToModule(UUID moduleId, KnowledgeComponentCreateDto kcCreateDto) {
        KnowledgeComponentSimpleDto newKcSimpleDTO= knowledgeComponentService.createKnowledgeComponent(kcCreateDto);
        KnowledgeComponentPrerequisiteDto newKcPreqDTO = KnowledgeComponentPrerequisiteDto.builder()
                .kc_id(newKcSimpleDTO.getKc_id())
                .kc_name(newKcSimpleDTO.getKc_name())
                .description(newKcSimpleDTO.getDescription())
                .prerequisiteKcIds(List.of())
                .build();
        addKnowledgeComponentToModule(moduleId, newKcSimpleDTO.getKc_id(), null); // Assuming no prerequisite when creating new KC
        return newKcPreqDTO;
    }

    @Override
    @Transactional
    public LessonDto createLessonForModule(UUID moduleId, LessonDto lessonDto) {
        // Verify module exists
        moduleRepository.findById(moduleId)
                .orElseThrow(() -> new ItemNotFoundException("Module not found with id: " + moduleId));
        
        // Create the lesson
        LessonDto createdLesson = lessonService.createLesson(lessonDto);
        
        // Add the lesson to the module (this will validate KC availability in a transaction)
        moduleLessonMappingService.addLessonToModule(moduleId, createdLesson.getLesson_id(), null);
        
        return createdLesson;
    }


}
