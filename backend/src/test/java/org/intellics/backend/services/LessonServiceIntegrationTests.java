package org.intellics.backend.services;

import org.intellics.backend.AbstractIntegrationTests;
import org.intellics.backend.domain.dto.LessonDto;
import org.intellics.backend.domain.entities.Lesson;
import org.intellics.backend.domain.entities.Module;
import org.intellics.backend.repositories.LessonRepository;
import org.intellics.backend.repositories.ModuleRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;

@Transactional
public class LessonServiceIntegrationTests extends AbstractIntegrationTests {

    @Autowired
    private LessonService lessonService;

    @Autowired
    private LessonRepository lessonRepository;

    @Autowired
    private ModuleRepository moduleRepository;

    private Module testModule;
    private Lesson testLesson;

    @BeforeEach
    void setUp() {
        // Create test module
        testModule = Module.builder()
                .module_name("Test Module")
                .description("Test Description")
                .build();
        testModule = moduleRepository.save(testModule);

        // Create test lesson
        testLesson = Lesson.builder()
                .lesson_name("Test Lesson")
                .lesson_content("# Test Lesson\n\nThis is a test lesson with **markdown** content.")
                .module(testModule)
                .build();
        testLesson = lessonRepository.save(testLesson);
    }

    @Test
    void testCreateLesson() {
        String markdownContent = """
            # Introduction to Object-Oriented Programming
            
            ## Overview
            Object-Oriented Programming (OOP) is a programming paradigm based on the concept of "objects".
            
            ## Key Concepts
            - **Encapsulation**: Bundling data and methods
            - **Inheritance**: Creating new classes from existing ones
            - **Polymorphism**: Same interface, different implementations
            
            ## Example
            ```java
            public class Car {
                private String brand;
                private String model;
                
                public Car(String brand, String model) {
                    this.brand = brand;
                    this.model = model;
                }
            }
            ```
            """;
        
        LessonDto lessonDto = LessonDto.builder()
                .lesson_name("OOP Introduction")
                .lesson_content(markdownContent)
                .module_id(testModule.getModule_id())
                .build();

        LessonDto createdLesson = lessonService.createLesson(lessonDto);

        assertNotNull(createdLesson.getLesson_id());
        assertEquals("OOP Introduction", createdLesson.getLesson_name());
        assertEquals(markdownContent, createdLesson.getLesson_content());
        assertEquals(testModule.getModule_id(), createdLesson.getModule_id());
    }

    @Test
    void testGetLessonById() {
        LessonDto retrievedLesson = lessonService.getLessonById(testLesson.getLesson_id());

        assertEquals(testLesson.getLesson_id(), retrievedLesson.getLesson_id());
        assertEquals(testLesson.getLesson_name(), retrievedLesson.getLesson_name());
        assertEquals(testLesson.getLesson_content(), retrievedLesson.getLesson_content());
        assertEquals(testModule.getModule_id(), retrievedLesson.getModule_id());
    }

    @Test
    void testGetLessonsByModule() {
        // Create another lesson in the same module
        Lesson anotherLesson = Lesson.builder()
                .lesson_name("Another Lesson")
                .lesson_content("# Another Lesson\n\nMore markdown content.")
                .module(testModule)
                .build();
        lessonRepository.save(anotherLesson);

        List<LessonDto> lessons = lessonService.getLessonsByModule(testModule.getModule_id());

        assertEquals(2, lessons.size());
        assertTrue(lessons.stream().anyMatch(l -> l.getLesson_name().equals("Test Lesson")));
        assertTrue(lessons.stream().anyMatch(l -> l.getLesson_name().equals("Another Lesson")));
    }

    @Test
    void testUpdateLesson() {
        LessonDto updateDto = LessonDto.builder()
                .lesson_name("Updated Lesson")
                .lesson_content("# Updated Lesson\n\nUpdated markdown content.")
                .module_id(testModule.getModule_id())
                .build();

        LessonDto updatedLesson = lessonService.updateLesson(testLesson.getLesson_id(), updateDto);

        assertEquals("Updated Lesson", updatedLesson.getLesson_name());
        assertEquals("# Updated Lesson\n\nUpdated markdown content.", updatedLesson.getLesson_content());
        assertEquals(testModule.getModule_id(), updatedLesson.getModule_id());
    }

    @Test
    void testPatchLesson() {
        LessonDto patchDto = LessonDto.builder()
                .lesson_name("Patched Lesson")
                .build();

        LessonDto patchedLesson = lessonService.patchLesson(testLesson.getLesson_id(), patchDto);

        assertEquals("Patched Lesson", patchedLesson.getLesson_name());
        assertEquals(testLesson.getLesson_content(), patchedLesson.getLesson_content()); // Should remain unchanged
        assertEquals(testModule.getModule_id(), patchedLesson.getModule_id());
    }

    @Test
    void testDeleteLesson() {
        UUID lessonId = testLesson.getLesson_id();
        
        lessonService.deleteLesson(lessonId);
        
        assertFalse(lessonRepository.existsById(lessonId));
    }

    @Test
    void testGetAllLessons() {
        // Create another lesson
        Lesson anotherLesson = Lesson.builder()
                .lesson_name("Another Lesson")
                .lesson_content("# Another Lesson\n\nMore content.")
                .module(testModule)
                .build();
        lessonRepository.save(anotherLesson);

        List<LessonDto> allLessons = lessonService.getAllLessons();

        assertTrue(allLessons.size() >= 2);
        assertTrue(allLessons.stream().anyMatch(l -> l.getLesson_name().equals("Test Lesson")));
        assertTrue(allLessons.stream().anyMatch(l -> l.getLesson_name().equals("Another Lesson")));
    }

    @Test
    void testModelMapperFieldMapping() {
        // Test that ModelMapper correctly maps lesson_content field
        LessonDto retrievedLesson = lessonService.getLessonById(testLesson.getLesson_id());
        
        // Verify the lesson_content field is properly mapped
        assertNotNull(retrievedLesson.getLesson_content());
        assertTrue(retrievedLesson.getLesson_content().contains("**markdown**"));
        assertTrue(retrievedLesson.getLesson_content().contains("# Test Lesson"));
        
        // Verify other fields are also mapped correctly
        assertEquals(testLesson.getLesson_id(), retrievedLesson.getLesson_id());
        assertEquals(testLesson.getLesson_name(), retrievedLesson.getLesson_name());
        assertEquals(testModule.getModule_id(), retrievedLesson.getModule_id());
    }
}
