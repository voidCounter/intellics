package org.intellics.backend.services;

import org.intellics.backend.AbstractIntegrationTests;
import org.intellics.backend.domain.dto.LessonKCMappingDto;
import org.intellics.backend.domain.entities.KnowledgeComponent;
import org.intellics.backend.domain.entities.Lesson;
import org.intellics.backend.domain.entities.Module;
import org.intellics.backend.repositories.KnowledgeComponentRepository;
import org.intellics.backend.repositories.LessonRepository;
import org.intellics.backend.repositories.ModuleRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;

@Transactional
public class LessonKCMappingServiceIntegrationTests extends AbstractIntegrationTests {

    @Autowired
    private LessonKCMappingService lessonKCMappingService;

    @Autowired
    private LessonRepository lessonRepository;

    @Autowired
    private KnowledgeComponentRepository knowledgeComponentRepository;

    @Autowired
    private ModuleRepository moduleRepository;

    private Lesson testLesson;
    private KnowledgeComponent testKC1;
    private KnowledgeComponent testKC2;
    private Module testModule;

    @BeforeEach
    void setUp() {
        // Create test module
        testModule = Module.builder()
                .module_name("Test Module")
                .description("Test module description")
                .build();
        testModule = moduleRepository.save(testModule);

        // Create test lesson
        testLesson = Lesson.builder()
                .lesson_name("Test Lesson")
                .lesson_content("Test lesson content")
                .module(testModule)
                .build();
        testLesson = lessonRepository.save(testLesson);

        // Create test knowledge components
        testKC1 = KnowledgeComponent.builder()
                .kc_name("Test KC 1")
                .description("Test knowledge component 1")
                .build();
        testKC1 = knowledgeComponentRepository.save(testKC1);

        testKC2 = KnowledgeComponent.builder()
                .kc_name("Test KC 2")
                .description("Test knowledge component 2")
                .build();
        testKC2 = knowledgeComponentRepository.save(testKC2);
    }

    @Test
    void getKCsByLessonId_ShouldReturnEmptyList_WhenNoKCsMapped() {
        List<LessonKCMappingDto> kcMappings = lessonKCMappingService.getKCsByLessonId(testLesson.getLesson_id());
        
        assertNotNull(kcMappings);
        assertTrue(kcMappings.isEmpty());
    }

    @Test
    void addKCToLesson_ShouldSucceed_WithValidData() {
        BigDecimal targetMastery = new BigDecimal("0.75");
        
        LessonKCMappingDto createdMapping = lessonKCMappingService.addKCToLesson(
                testLesson.getLesson_id(), 
                testKC1.getKc_id(), 
                targetMastery);

        assertNotNull(createdMapping);
        assertEquals(testLesson.getLesson_id(), createdMapping.getLessonId());
        assertEquals(testKC1.getKc_id(), createdMapping.getKcId());
        assertEquals(targetMastery, createdMapping.getTargetMastery());
    }

    @Test
    void addKCToLesson_ShouldFail_WithInvalidTargetMastery() {
        BigDecimal invalidTargetMastery = new BigDecimal("1.50"); // > 1.00
        
        assertThrows(IllegalArgumentException.class, () -> {
            lessonKCMappingService.addKCToLesson(
                    testLesson.getLesson_id(), 
                    testKC1.getKc_id(), 
                    invalidTargetMastery);
        });
    }

    @Test
    void addKCToLesson_ShouldFail_WithTargetMasteryTooLow() {
        BigDecimal invalidTargetMastery = new BigDecimal("0.00"); // < 0.01
        
        assertThrows(IllegalArgumentException.class, () -> {
            lessonKCMappingService.addKCToLesson(
                    testLesson.getLesson_id(), 
                    testKC1.getKc_id(), 
                    invalidTargetMastery);
        });
    }

    @Test
    void addKCToLesson_ShouldFail_WithNonExistentLesson() {
        UUID nonExistentLessonId = UUID.randomUUID();
        BigDecimal targetMastery = new BigDecimal("0.75");
        
        assertThrows(RuntimeException.class, () -> {
            lessonKCMappingService.addKCToLesson(
                    nonExistentLessonId, 
                    testKC1.getKc_id(), 
                    targetMastery);
        });
    }

    @Test
    void addKCToLesson_ShouldFail_WithNonExistentKC() {
        UUID nonExistentKCId = UUID.randomUUID();
        BigDecimal targetMastery = new BigDecimal("0.75");
        
        assertThrows(RuntimeException.class, () -> {
            lessonKCMappingService.addKCToLesson(
                    testLesson.getLesson_id(), 
                    nonExistentKCId, 
                    targetMastery);
        });
    }

    @Test
    void addKCToLesson_ShouldFail_WhenKCAlreadyMapped() {
        BigDecimal targetMastery = new BigDecimal("0.75");
        
        // Add KC first time
        lessonKCMappingService.addKCToLesson(
                testLesson.getLesson_id(), 
                testKC1.getKc_id(), 
                targetMastery);

        // Try to add the same KC again
        assertThrows(IllegalArgumentException.class, () -> {
            lessonKCMappingService.addKCToLesson(
                    testLesson.getLesson_id(), 
                    testKC1.getKc_id(), 
                    targetMastery);
        });
    }

    @Test
    void updateTargetMastery_ShouldSucceed_WithValidData() {
        // First add a KC to the lesson
        BigDecimal initialTargetMastery = new BigDecimal("0.50");
        lessonKCMappingService.addKCToLesson(
                testLesson.getLesson_id(), 
                testKC1.getKc_id(), 
                initialTargetMastery);

        // Then update the target mastery
        BigDecimal newTargetMastery = new BigDecimal("0.85");
        LessonKCMappingDto updatedMapping = lessonKCMappingService.updateTargetMastery(
                testLesson.getLesson_id(), 
                testKC1.getKc_id(), 
                newTargetMastery);

        assertNotNull(updatedMapping);
        assertEquals(testLesson.getLesson_id(), updatedMapping.getLessonId());
        assertEquals(testKC1.getKc_id(), updatedMapping.getKcId());
        assertEquals(newTargetMastery, updatedMapping.getTargetMastery());
    }

    @Test
    void updateTargetMastery_ShouldFail_WithInvalidTargetMastery() {
        BigDecimal invalidTargetMastery = new BigDecimal("1.50"); // > 1.00
        
        assertThrows(IllegalArgumentException.class, () -> {
            lessonKCMappingService.updateTargetMastery(
                    testLesson.getLesson_id(), 
                    testKC1.getKc_id(), 
                    invalidTargetMastery);
        });
    }

    @Test
    void updateTargetMastery_ShouldFail_WithNonExistentMapping() {
        BigDecimal targetMastery = new BigDecimal("0.85");
        
        assertThrows(RuntimeException.class, () -> {
            lessonKCMappingService.updateTargetMastery(
                    testLesson.getLesson_id(), 
                    testKC1.getKc_id(), 
                    targetMastery);
        });
    }

    @Test
    void removeKCFromLesson_ShouldSucceed_WithValidMapping() {
        // First add a KC to the lesson
        BigDecimal targetMastery = new BigDecimal("0.50");
        lessonKCMappingService.addKCToLesson(
                testLesson.getLesson_id(), 
                testKC1.getKc_id(), 
                targetMastery);

        // Then remove it
        assertDoesNotThrow(() -> {
            lessonKCMappingService.removeKCFromLesson(
                    testLesson.getLesson_id(), 
                    testKC1.getKc_id());
        });

        // Verify it's removed
        List<LessonKCMappingDto> kcMappings = lessonKCMappingService.getKCsByLessonId(testLesson.getLesson_id());
        assertTrue(kcMappings.isEmpty());
    }

    @Test
    void removeKCFromLesson_ShouldFail_WithNonExistentMapping() {
        assertThrows(RuntimeException.class, () -> {
            lessonKCMappingService.removeKCFromLesson(
                    testLesson.getLesson_id(), 
                    testKC1.getKc_id());
        });
    }

    @Test
    void getKCsByLessonId_ShouldReturnMappedKCs() {
        // Add multiple KCs to the lesson
        BigDecimal targetMastery1 = new BigDecimal("0.30");
        BigDecimal targetMastery2 = new BigDecimal("0.80");

        lessonKCMappingService.addKCToLesson(
                testLesson.getLesson_id(), 
                testKC1.getKc_id(), 
                targetMastery1);

        lessonKCMappingService.addKCToLesson(
                testLesson.getLesson_id(), 
                testKC2.getKc_id(), 
                targetMastery2);

        // Get KCs and verify
        List<LessonKCMappingDto> kcMappings = lessonKCMappingService.getKCsByLessonId(testLesson.getLesson_id());
        
        assertNotNull(kcMappings);
        assertEquals(2, kcMappings.size());
        
        // Verify first KC
        LessonKCMappingDto firstMapping = kcMappings.stream()
                .filter(mapping -> mapping.getKcId().equals(testKC1.getKc_id()))
                .findFirst()
                .orElse(null);
        assertNotNull(firstMapping);
        assertEquals(testLesson.getLesson_id(), firstMapping.getLessonId());
        assertEquals(testKC1.getKc_id(), firstMapping.getKcId());
        assertEquals(targetMastery1, firstMapping.getTargetMastery());
        
        // Verify second KC
        LessonKCMappingDto secondMapping = kcMappings.stream()
                .filter(mapping -> mapping.getKcId().equals(testKC2.getKc_id()))
                .findFirst()
                .orElse(null);
        assertNotNull(secondMapping);
        assertEquals(testLesson.getLesson_id(), secondMapping.getLessonId());
        assertEquals(testKC2.getKc_id(), secondMapping.getKcId());
        assertEquals(targetMastery2, secondMapping.getTargetMastery());
    }

    @Test
    void testTargetMasteryValidation_BoundaryValues() {
        // Test minimum valid value
        assertDoesNotThrow(() -> {
            lessonKCMappingService.addKCToLesson(
                    testLesson.getLesson_id(), 
                    testKC1.getKc_id(), 
                    new BigDecimal("0.01"));
        });

        // Test maximum valid value
        assertDoesNotThrow(() -> {
            lessonKCMappingService.addKCToLesson(
                    testLesson.getLesson_id(), 
                    testKC2.getKc_id(), 
                    new BigDecimal("1.00"));
        });

        // Test invalid minimum value
        assertThrows(IllegalArgumentException.class, () -> {
            lessonKCMappingService.addKCToLesson(
                    testLesson.getLesson_id(), 
                    testKC1.getKc_id(), 
                    new BigDecimal("0.00"));
        });

        // Test invalid maximum value
        assertThrows(IllegalArgumentException.class, () -> {
            lessonKCMappingService.addKCToLesson(
                    testLesson.getLesson_id(), 
                    testKC2.getKc_id(), 
                    new BigDecimal("1.01"));
        });
    }
}
