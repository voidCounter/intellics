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
public class ModuleServiceIntegrationTests extends AbstractIntegrationTests {

    @Autowired
    private ModuleService moduleService;

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
    void testGetLessonsByModule() {
        // Create another lesson in the same module
        Lesson anotherLesson = Lesson.builder()
                .lesson_name("Another Lesson")
                .lesson_content("# Another Lesson\n\nMore markdown content.")
                .module(testModule)
                .build();
        lessonRepository.save(anotherLesson);

        // Test the module service method that delegates to lesson service
        List<LessonDto> lessons = moduleService.getLessonsByModule(testModule.getModule_id());

        assertEquals(2, lessons.size());
        assertTrue(lessons.stream().anyMatch(l -> l.getLesson_name().equals("Test Lesson")));
        assertTrue(lessons.stream().anyMatch(l -> l.getLesson_name().equals("Another Lesson")));
        
        // Verify all lessons belong to the correct module
        lessons.forEach(lesson -> assertEquals(testModule.getModule_id(), lesson.getModule_id()));
    }

    @Test
    void testGetLessonsByModuleWithNoLessons() {
        // Create a new module with no lessons
        Module emptyModule = Module.builder()
                .module_name("Empty Module")
                .description("Module with no lessons")
                .build();
        emptyModule = moduleRepository.save(emptyModule);

        List<LessonDto> lessons = moduleService.getLessonsByModule(emptyModule.getModule_id());

        assertEquals(0, lessons.size());
    }
}
