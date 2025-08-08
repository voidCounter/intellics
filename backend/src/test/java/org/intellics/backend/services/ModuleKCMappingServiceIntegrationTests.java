package org.intellics.backend.services;

import org.intellics.backend.AbstractIntegrationTests;
import org.intellics.backend.domain.dto.ModuleKCMappingDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentPrerequisiteDto;
import org.intellics.backend.domain.entities.KnowledgeComponent;
import org.intellics.backend.domain.entities.Module;
import org.intellics.backend.repositories.KnowledgeComponentRepository;
import org.intellics.backend.repositories.ModuleRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;

@Transactional
public class ModuleKCMappingServiceIntegrationTests extends AbstractIntegrationTests {

    @Autowired
    private ModuleKCMappingService moduleKCMappingService;

    @Autowired
    private ModuleService moduleService;

    @Autowired
    private ModuleRepository moduleRepository;

    @Autowired
    private KnowledgeComponentRepository knowledgeComponentRepository;

    private Module testModule;
    private KnowledgeComponent kc1, kc2, kc3;

    @BeforeEach
    void setUp() {
        // Create test module
        testModule = Module.builder()
            .module_name("Test Module")
            .description("Test Description")
            .build();
        testModule = moduleRepository.save(testModule);

        // Create test knowledge components
        kc1 = KnowledgeComponent.builder()
            .kc_name("KC1")
            .description("Description 1")
            .build();
        kc2 = KnowledgeComponent.builder()
            .kc_name("KC2")
            .description("Description 2")
            .build();
        kc3 = KnowledgeComponent.builder()
            .kc_name("KC3")
            .description("Description 3")
            .build();
        
        knowledgeComponentRepository.saveAll(List.of(kc1, kc2, kc3));
    }

    @Test
    void testDeleteKCAndCleanupPrerequisites() {
        // Add KCs to module with prerequisites
        ModuleKCMappingDto mapping1 = moduleKCMappingService.createModuleKCMapping(
            ModuleKCMappingDto.builder()
                .moduleId(testModule.getModule_id())
                .kcId(kc1.getKc_id())
                .prerequisiteKcIds(List.of(kc2.getKc_id(), kc3.getKc_id()))
                .build()
        );

        ModuleKCMappingDto mapping2 = moduleKCMappingService.createModuleKCMapping(
            ModuleKCMappingDto.builder()
                .moduleId(testModule.getModule_id())
                .kcId(kc2.getKc_id())
                .prerequisiteKcIds(List.of(kc3.getKc_id()))
                .build()
        );

        ModuleKCMappingDto mapping3 = moduleKCMappingService.createModuleKCMapping(
            ModuleKCMappingDto.builder()
                .moduleId(testModule.getModule_id())
                .kcId(kc3.getKc_id())
                .prerequisiteKcIds(List.of())
                .build()
        );

        // Verify initial state
        List<KnowledgeComponentPrerequisiteDto> initialKCs = moduleService.getKnowledgeComponentsByModule(testModule.getModule_id());
        assertEquals(3, initialKCs.size());

        // Find KC1 and verify it has prerequisites
        KnowledgeComponentPrerequisiteDto kc1Dto = initialKCs.stream()
            .filter(kc -> kc.getKc_id().equals(kc1.getKc_id()))
            .findFirst()
            .orElseThrow();
        assertEquals(2, kc1Dto.getPrerequisiteKcIds().size());
        assertTrue(kc1Dto.getPrerequisiteKcIds().contains(kc2.getKc_id()));
        assertTrue(kc1Dto.getPrerequisiteKcIds().contains(kc3.getKc_id()));

        // Delete KC3 (which is a prerequisite for both KC1 and KC2)
        moduleKCMappingService.delete(testModule.getModule_id(), kc3.getKc_id());

        // Verify KC3 is removed and prerequisites are cleaned up
        List<KnowledgeComponentPrerequisiteDto> afterDeletionKCs = moduleService.getKnowledgeComponentsByModule(testModule.getModule_id());
        assertEquals(2, afterDeletionKCs.size());

        // Verify KC1 no longer has KC3 as prerequisite
        KnowledgeComponentPrerequisiteDto kc1AfterDeletion = afterDeletionKCs.stream()
            .filter(kc -> kc.getKc_id().equals(kc1.getKc_id()))
            .findFirst()
            .orElseThrow();
        assertEquals(1, kc1AfterDeletion.getPrerequisiteKcIds().size());
        assertTrue(kc1AfterDeletion.getPrerequisiteKcIds().contains(kc2.getKc_id()));
        assertFalse(kc1AfterDeletion.getPrerequisiteKcIds().contains(kc3.getKc_id()));

        // Verify KC2 no longer has KC3 as prerequisite
        KnowledgeComponentPrerequisiteDto kc2AfterDeletion = afterDeletionKCs.stream()
            .filter(kc -> kc.getKc_id().equals(kc2.getKc_id()))
            .findFirst()
            .orElseThrow();
        assertEquals(0, kc2AfterDeletion.getPrerequisiteKcIds().size());
    }

    @Test
    void testDeleteKCWithNoPrerequisites() {
        // Add KCs to module
        ModuleKCMappingDto mapping1 = moduleKCMappingService.createModuleKCMapping(
            ModuleKCMappingDto.builder()
                .moduleId(testModule.getModule_id())
                .kcId(kc1.getKc_id())
                .prerequisiteKcIds(List.of())
                .build()
        );

        ModuleKCMappingDto mapping2 = moduleKCMappingService.createModuleKCMapping(
            ModuleKCMappingDto.builder()
                .moduleId(testModule.getModule_id())
                .kcId(kc2.getKc_id())
                .prerequisiteKcIds(List.of())
                .build()
        );

        // Verify initial state
        List<KnowledgeComponentPrerequisiteDto> initialKCs = moduleService.getKnowledgeComponentsByModule(testModule.getModule_id());
        assertEquals(2, initialKCs.size());

        // Delete KC1
        moduleKCMappingService.delete(testModule.getModule_id(), kc1.getKc_id());

        // Verify KC1 is removed
        List<KnowledgeComponentPrerequisiteDto> afterDeletionKCs = moduleService.getKnowledgeComponentsByModule(testModule.getModule_id());
        assertEquals(1, afterDeletionKCs.size());
        assertFalse(afterDeletionKCs.stream().anyMatch(kc -> kc.getKc_id().equals(kc1.getKc_id())));
    }

    @Test
    void testRemoveAllKnowledgeComponentsFromModule() {
        // Add KCs to module with prerequisites
        ModuleKCMappingDto mapping1 = moduleKCMappingService.createModuleKCMapping(
            ModuleKCMappingDto.builder()
                .moduleId(testModule.getModule_id())
                .kcId(kc1.getKc_id())
                .prerequisiteKcIds(List.of(kc2.getKc_id(), kc3.getKc_id()))
                .build()
        );

        ModuleKCMappingDto mapping2 = moduleKCMappingService.createModuleKCMapping(
            ModuleKCMappingDto.builder()
                .moduleId(testModule.getModule_id())
                .kcId(kc2.getKc_id())
                .prerequisiteKcIds(List.of(kc3.getKc_id()))
                .build()
        );

        ModuleKCMappingDto mapping3 = moduleKCMappingService.createModuleKCMapping(
            ModuleKCMappingDto.builder()
                .moduleId(testModule.getModule_id())
                .kcId(kc3.getKc_id())
                .prerequisiteKcIds(List.of())
                .build()
        );

        // Verify initial state
        List<KnowledgeComponentPrerequisiteDto> initialKCs = moduleService.getKnowledgeComponentsByModule(testModule.getModule_id());
        assertEquals(3, initialKCs.size());

        // Remove all KCs from module
        moduleService.removeAllKnowledgeComponentsFromModule(testModule.getModule_id());

        // Verify all KCs are removed
        List<KnowledgeComponentPrerequisiteDto> afterDeletionKCs = moduleService.getKnowledgeComponentsByModule(testModule.getModule_id());
        assertEquals(0, afterDeletionKCs.size());
    }

    @Test
    void testGetKnowledgeComponentByModule() {
        // Add KC to module with prerequisites
        ModuleKCMappingDto mapping = moduleKCMappingService.createModuleKCMapping(
            ModuleKCMappingDto.builder()
                .moduleId(testModule.getModule_id())
                .kcId(kc1.getKc_id())
                .prerequisiteKcIds(List.of(kc2.getKc_id(), kc3.getKc_id()))
                .build()
        );

        // Get specific KC from module
        KnowledgeComponentPrerequisiteDto retrievedKc = moduleService.getKnowledgeComponentByModule(testModule.getModule_id(), kc1.getKc_id());

        // Verify the retrieved KC
        assertEquals(kc1.getKc_id(), retrievedKc.getKc_id());
        assertEquals(kc1.getKc_name(), retrievedKc.getKc_name());
        assertEquals(kc1.getDescription(), retrievedKc.getDescription());
        assertEquals(2, retrievedKc.getPrerequisiteKcIds().size());
        assertTrue(retrievedKc.getPrerequisiteKcIds().contains(kc2.getKc_id()));
        assertTrue(retrievedKc.getPrerequisiteKcIds().contains(kc3.getKc_id()));
    }

    @Test
    void testCascadeDeleteWhenRemovingKC() {
        // Create a complex prerequisite structure:
        // KC1 has KC2 and KC3 as prerequisites
        // KC2 has KC3 as prerequisite
        // KC3 has no prerequisites
        
        ModuleKCMappingDto mapping1 = moduleKCMappingService.createModuleKCMapping(
            ModuleKCMappingDto.builder()
                .moduleId(testModule.getModule_id())
                .kcId(kc1.getKc_id())
                .prerequisiteKcIds(List.of(kc2.getKc_id(), kc3.getKc_id()))
                .build()
        );

        ModuleKCMappingDto mapping2 = moduleKCMappingService.createModuleKCMapping(
            ModuleKCMappingDto.builder()
                .moduleId(testModule.getModule_id())
                .kcId(kc2.getKc_id())
                .prerequisiteKcIds(List.of(kc3.getKc_id()))
                .build()
        );

        ModuleKCMappingDto mapping3 = moduleKCMappingService.createModuleKCMapping(
            ModuleKCMappingDto.builder()
                .moduleId(testModule.getModule_id())
                .kcId(kc3.getKc_id())
                .prerequisiteKcIds(List.of())
                .build()
        );

        // Verify initial state
        List<KnowledgeComponentPrerequisiteDto> initialKCs = moduleService.getKnowledgeComponentsByModule(testModule.getModule_id());
        assertEquals(3, initialKCs.size());

        // Find KC1 and verify it has both KC2 and KC3 as prerequisites
        KnowledgeComponentPrerequisiteDto kc1Initial = initialKCs.stream()
            .filter(kc -> kc.getKc_id().equals(kc1.getKc_id()))
            .findFirst()
            .orElseThrow();
        assertEquals(2, kc1Initial.getPrerequisiteKcIds().size());
        assertTrue(kc1Initial.getPrerequisiteKcIds().contains(kc2.getKc_id()));
        assertTrue(kc1Initial.getPrerequisiteKcIds().contains(kc3.getKc_id()));

        // Find KC2 and verify it has KC3 as prerequisite
        KnowledgeComponentPrerequisiteDto kc2Initial = initialKCs.stream()
            .filter(kc -> kc.getKc_id().equals(kc2.getKc_id()))
            .findFirst()
            .orElseThrow();
        assertEquals(1, kc2Initial.getPrerequisiteKcIds().size());
        assertTrue(kc2Initial.getPrerequisiteKcIds().contains(kc3.getKc_id()));

        // Delete KC3 (which is a prerequisite for both KC1 and KC2)
        moduleKCMappingService.delete(testModule.getModule_id(), kc3.getKc_id());

        // Verify KC3 is removed and all prerequisite relationships are cleaned up
        List<KnowledgeComponentPrerequisiteDto> afterDeletionKCs = moduleService.getKnowledgeComponentsByModule(testModule.getModule_id());
        assertEquals(2, afterDeletionKCs.size());

        // Verify KC1 no longer has KC3 as prerequisite
        KnowledgeComponentPrerequisiteDto kc1AfterDeletion = afterDeletionKCs.stream()
            .filter(kc -> kc.getKc_id().equals(kc1.getKc_id()))
            .findFirst()
            .orElseThrow();
        assertEquals(1, kc1AfterDeletion.getPrerequisiteKcIds().size());
        assertTrue(kc1AfterDeletion.getPrerequisiteKcIds().contains(kc2.getKc_id()));
        assertFalse(kc1AfterDeletion.getPrerequisiteKcIds().contains(kc3.getKc_id()));

        // Verify KC2 no longer has KC3 as prerequisite
        KnowledgeComponentPrerequisiteDto kc2AfterDeletion = afterDeletionKCs.stream()
            .filter(kc -> kc.getKc_id().equals(kc2.getKc_id()))
            .findFirst()
            .orElseThrow();
        assertEquals(0, kc2AfterDeletion.getPrerequisiteKcIds().size());
        assertFalse(kc2AfterDeletion.getPrerequisiteKcIds().contains(kc3.getKc_id()));

        // Verify KC3 is completely removed
        assertFalse(afterDeletionKCs.stream().anyMatch(kc -> kc.getKc_id().equals(kc3.getKc_id())));
    }
}
