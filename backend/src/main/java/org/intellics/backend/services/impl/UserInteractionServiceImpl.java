package org.intellics.backend.services.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.intellics.backend.api.error.exceptions.ItemNotFoundException;
import org.intellics.backend.domain.dto.InteractionKCMappingDto;
import org.intellics.backend.domain.dto.UserInteractionDto;
import org.intellics.backend.domain.dto.UserInteractionRequestDto;
import org.intellics.backend.domain.entities.InteractionKCMapping;
import org.intellics.backend.domain.entities.InteractionType;
import org.intellics.backend.domain.entities.Lesson;
import org.intellics.backend.domain.entities.Module;
import org.intellics.backend.domain.entities.QuestionEntity;
import org.intellics.backend.domain.entities.Scaffold;
import org.intellics.backend.domain.entities.Session;
import org.intellics.backend.domain.entities.User;
import org.intellics.backend.domain.entities.UserInteraction;
import org.intellics.backend.repositories.InteractionKCMappingRepository;
import org.intellics.backend.repositories.UserInteractionRepository;
import org.intellics.backend.repositories.SessionRepository;
import org.intellics.backend.repositories.UserRepository;
import org.intellics.backend.repositories.LessonRepository;
import org.intellics.backend.repositories.ModuleRepository;
import org.intellics.backend.repositories.QuestionRepository;
import org.intellics.backend.repositories.ScaffoldRepository;
import org.intellics.backend.services.UserInteractionService;
import org.intellics.backend.services.KCMasteryService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.TimeUnit;
import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional(readOnly = true)
public class UserInteractionServiceImpl implements UserInteractionService {

    private final UserInteractionRepository userInteractionRepository;
    private final InteractionKCMappingRepository interactionKCMappingRepository;
    private final SessionRepository sessionRepository;
    private final UserRepository userRepository;
    private final LessonRepository lessonRepository;
    private final ModuleRepository moduleRepository;
    private final QuestionRepository questionRepository;
    private final ScaffoldRepository scaffoldRepository;
    private final KCMasteryService kcMasteryService;
    
    // Simple in-memory deduplication (in production, use Redis or database)
    private final Cache<String, Boolean> processedInteractions = Caffeine.newBuilder()
        .expireAfterWrite(1, TimeUnit.HOURS) // Automatically expire entries after 1 hour
        .maximumSize(10000) // Limit cache size to prevent memory issues
        .build();

    @Override
    @Transactional
    public UserInteractionDto createInteraction(UserInteractionRequestDto request) {
        // Create a unique key for deduplication based on educational best practices
        // Each interaction type has specific deduplication policies for optimal learning analytics
        // Questions can be presented multiple times (after incorrect attempts, when returning, etc.)
        String interactionKey;
        
        switch (request.getInteractionType()) {
            case LESSON_START:
            case LESSON_EXIT:
                // Log every lesson start/exit (5-second debounce to prevent accidental double-logging)
                interactionKey = String.format("%s_%s_%s_%s_%s_%s_%s_%s",
                    request.getInteractionType(),
                    request.getSessionId(),
                    request.getLessonId() != null ? request.getLessonId() : "null",
                    request.getModuleId() != null ? request.getModuleId() : "null",
                    request.getQuestionId() != null ? request.getQuestionId() : "null",
                    request.getScaffoldId() != null ? request.getScaffoldId() : "null",
                    request.getHintLevel() != null ? request.getHintLevel() : "null",
                    System.currentTimeMillis() / 5000 // 5-second debounce for lesson events
                );
                break;
                
            case HINT_REQUESTED:
            case SCAFFOLD_REQUESTED:
                // Log every hint/scaffold request with 10-second debounce to prevent spam
                interactionKey = String.format("%s_%s_%s_%s_%s_%s_%s_%s",
                    request.getInteractionType(),
                    request.getSessionId(),
                    request.getLessonId() != null ? request.getLessonId() : "null",
                    request.getModuleId() != null ? request.getModuleId() : "null",
                    request.getQuestionId() != null ? request.getQuestionId() : "null",
                    request.getScaffoldId() != null ? request.getScaffoldId() : "null",
                    request.getHintLevel() != null ? request.getHintLevel() : "null",
                    System.currentTimeMillis() / 10000 // 10-second debounce for help requests
                );
                break;
                
            case QUESTION_PRESENTED:
            case QUESTION_ATTEMPTED:
            case QUESTION_SKIPPED:
            case SCAFFOLD_ATTEMPTED:
            case SCAFFOLD_ANSWER:
                // Log every presentation, attempt, skip, and scaffold interaction
                // These are critical for mastery modeling and learning analytics
                // Add timestamp for all these interactions to allow multiple occurrences
                interactionKey = String.format("%s_%s_%s_%s_%s_%s_%s_%d",
                    request.getInteractionType(),
                    request.getSessionId(),
                    request.getLessonId() != null ? request.getLessonId() : "null",
                    request.getModuleId() != null ? request.getModuleId() : "null",
                    request.getQuestionId() != null ? request.getQuestionId() : "null",
                    request.getScaffoldId() != null ? request.getScaffoldId() : "null",
                    request.getHintLevel() != null ? request.getHintLevel() : "null",
                    System.currentTimeMillis() // Add timestamp to make each interaction unique
                );
                break;
                
            default:
                // For any other interaction types, use strict deduplication
                interactionKey = String.format("%s_%s_%s_%s_%s_%s_%s",
                    request.getInteractionType(),
                    request.getSessionId(),
                    request.getLessonId() != null ? request.getLessonId() : "null",
                    request.getModuleId() != null ? request.getModuleId() : "null",
                    request.getQuestionId() != null ? request.getQuestionId() : "null",
                    request.getScaffoldId() != null ? request.getScaffoldId() : "null",
                    request.getHintLevel() != null ? request.getHintLevel() : "null"
                );
                break;
        }
        
        // Check if we've already processed this interaction
        if (processedInteractions.getIfPresent(interactionKey) != null) {
            log.warn("Duplicate interaction detected and skipped: {}", interactionKey);
            throw new RuntimeException("Duplicate interaction - already processed");
        }
        
        // Mark as processed
        processedInteractions.put(interactionKey, true);
        
        // Extract user ID from security context
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            throw new RuntimeException("User not authenticated");
        }
        
        UUID userId = UUID.fromString(authentication.getName());
        log.debug("Extracted userId from security context: {}", userId);
        log.debug("Request sessionId: {}", request.getSessionId());
        
        // Fetch related entities
        Session session = sessionRepository.findById(request.getSessionId())
            .orElseThrow(() -> new RuntimeException("Session not found"));
        log.debug("Found session: {}", session.getSession_id());
        
        User user = userRepository.findById(userId)
            .orElseThrow(() -> new RuntimeException("User not found"));
        log.debug("Found user: {}", user.getUser_id());
        
        Lesson lesson = null;
        if (request.getLessonId() != null) {
            lesson = lessonRepository.findById(request.getLessonId())
                .orElseThrow(() -> new RuntimeException("Lesson not found"));
            log.debug("Found lesson: {}", lesson.getLesson_id());
        }
        
        Module module = null;
        if (request.getModuleId() != null) {
            module = moduleRepository.findById(request.getModuleId())
                .orElseThrow(() -> new RuntimeException("Module not found"));
            log.debug("Found module: {}", module.getModule_id());
        }
        
        QuestionEntity question = null;
        if (request.getQuestionId() != null) {
            question = questionRepository.findById(request.getQuestionId())
                .orElseThrow(() -> new RuntimeException("Question not found"));
            log.debug("Found question: {}", question.getQuestion_id());
        }
        
        Scaffold scaffold = null;
        if (request.getScaffoldId() != null) {
            scaffold = scaffoldRepository.findById(request.getScaffoldId())
                .orElseThrow(() -> new RuntimeException("Scaffold not found"));
            log.debug("Found scaffold: {}", scaffold.getScaffold_id());
        }
        
        log.debug("About to create UserInteraction with:");
        log.debug("  - session: {}", (session != null ? session.getSession_id() : "null"));
        log.debug("  - user: {}", (user != null ? user.getUser_id() : "null"));
        log.debug("  - lesson: {}", (lesson != null ? lesson.getLesson_id() : "null"));
        log.debug("  - module: {}", (module != null ? module.getModule_id() : "null"));
        log.debug("  - question: {}", (question != null ? question.getQuestion_id() : "null"));
        log.debug("  - scaffold: {}", (scaffold != null ? scaffold.getScaffold_id() : "null"));
        
        // Create and save the interaction
        UserInteraction interaction = UserInteraction.builder()
            .session(session)
            .user(user)
            .lesson(lesson)
            .module(module)
            .question(question)
            .scaffold(scaffold)
            .interactionType(request.getInteractionType())
            .student_answer(request.getStudentAnswer())
            .is_correct(request.getIsCorrect() != null ? request.getIsCorrect() : false)
            .hint_level(request.getHintLevel() != null ? request.getHintLevel() : 0)
            .time_spent_seconds(request.getTimeSpentSeconds() != null ? request.getTimeSpentSeconds() : 0)
            .build();
        
        log.debug("Built UserInteraction entity, about to save...");
        UserInteraction savedInteraction = userInteractionRepository.save(interaction);
        log.debug("Saved interaction with ID: {}", savedInteraction.getInteraction_id());
        
        // Update KC mastery based on this interaction
        try {
            kcMasteryService.updateMastery(savedInteraction);
            log.debug("Updated KC mastery for interaction: {}", savedInteraction.getInteraction_id());
        } catch (Exception e) {
            log.error("Failed to update KC mastery for interaction: {}", savedInteraction.getInteraction_id(), e);
            // Don't fail the interaction creation if mastery update fails
        }
        
        return mapToDto(savedInteraction);
    }

    @Override
    public Page<UserInteractionDto> getInteractionsWithFilters(
            UUID userId, UUID sessionId, UUID moduleId, UUID lessonId, UUID questionId, UUID scaffoldId, UUID kcId,
            InteractionType interactionType, Boolean isCorrect, Instant timestampAfter, Instant timestampBefore,
            Pageable pageable) {
        
        log.debug("Getting interactions with filters: userId={}, sessionId={}, moduleId={}, lessonId={}, questionId={}, scaffoldId={}, kcId={}, interactionType={}, isCorrect={}, timestampAfter={}, timestampBefore={}",
            userId, sessionId, moduleId, lessonId, questionId, scaffoldId, kcId, interactionType, isCorrect, timestampAfter, timestampBefore);
        
        Page<UserInteraction> interactions = userInteractionRepository.findWithFilters(
            userId, sessionId, moduleId, lessonId, questionId, scaffoldId, kcId, interactionType, isCorrect, timestampAfter, timestampBefore, pageable
        );
        
        log.debug("Found {} interactions", interactions.getTotalElements());
        
        return interactions.map(this::mapToDto);
    }

    @Override
    @Transactional
    public void logQuestionPresented(UUID userId, UUID questionId, UUID lessonId, UUID moduleId) {
        log.debug("Logging question presented: userId={}, questionId={}, lessonId={}, moduleId={}", 
            userId, questionId, lessonId, moduleId);
        
        try {
            // Get the user's active session
            Session activeSession = sessionRepository.findActiveSessionByUserId(userId);
            if (activeSession == null) {
                log.warn("No active session found for user {}, cannot log question presented", userId);
                return;
            }
            
            // Get the question entity
            QuestionEntity question = questionRepository.findById(questionId).orElse(null);
            if (question == null) {
                log.warn("Question not found: {}, cannot log question presented", questionId);
                return;
            }
            
            // Get lesson and module entities if provided
            Lesson lesson = null;
            Module module = null;
            
            if (lessonId != null) {
                lesson = lessonRepository.findById(lessonId).orElse(null);
                if (lesson == null) {
                    log.warn("Lesson not found: {}, cannot log question presented", lessonId);
                    return;
                }
            }
            
            if (moduleId != null) {
                module = moduleRepository.findById(moduleId).orElse(null);
                if (module == null) {
                    log.warn("Module not found: {}, cannot log question presented", moduleId);
                    return;
                }
            }
            
            // Create and save the interaction
            UserInteraction interaction = UserInteraction.builder()
                .session(activeSession)
                .user(activeSession.getUser())
                .lesson(lesson)
                .module(module)
                .question(question)
                .interactionType(InteractionType.QUESTION_PRESENTED)
                .student_answer(null)
                .is_correct(false)
                .hint_level(0)
                .time_spent_seconds(0)
                .build();
            
            userInteractionRepository.save(interaction);
            log.debug("Successfully logged question presented interaction: {}", interaction.getInteraction_id());
            
        } catch (Exception e) {
            log.error("Failed to log question presented interaction: {}", e.getMessage(), e);
            // Don't throw - this is logging, shouldn't break the main flow
        }
    }

    private UserInteractionDto mapToDto(UserInteraction interaction) {
        // Get KC mappings for this interaction
        List<InteractionKCMappingDto> kcMappings = getKCMappingsForInteraction(interaction.getInteraction_id());

        return UserInteractionDto.builder()
            .interactionId(interaction.getInteraction_id())
            .sessionId(interaction.getSession() != null ? interaction.getSession().getSession_id() : null)
            .userId(interaction.getUser() != null ? interaction.getUser().getUser_id() : null)
            .moduleId(interaction.getModule() != null ? interaction.getModule().getModule_id() : null)
            .lessonId(interaction.getLesson() != null ? interaction.getLesson().getLesson_id() : null)
            .questionId(interaction.getQuestion() != null ? interaction.getQuestion().getQuestion_id() : null)
            .scaffoldId(interaction.getScaffold() != null ? interaction.getScaffold().getScaffold_id() : null)
            .interactionType(interaction.getInteractionType())
            .studentAnswer(interaction.getStudent_answer())
            .isCorrect(interaction.is_correct())
            .hintLevel(interaction.getHint_level())
            .timeSpentSeconds(interaction.getTime_spent_seconds())
            .timestamp(interaction.getTimestamp())
            .kcMappings(kcMappings)
            .build();
    }

    private List<InteractionKCMappingDto> getKCMappingsForInteraction(UUID interactionId) {
        List<InteractionKCMapping> mappings = interactionKCMappingRepository.findByInteractionId(interactionId);
        
        return mappings.stream()
            .map(mapping -> InteractionKCMappingDto.builder()
                .interactionId(interactionId)
                .kcId(mapping.getKnowledgeComponent().getKc_id())
                .kcName(mapping.getKnowledgeComponent().getKc_name())
                .weight(mapping.getWeight())
                .kcMasteryBefore(mapping.getKcMasteryBefore())
                .kcMasteryAfter(mapping.getKcMasteryAfter())
                .created_at(mapping.getCreated_at())
                .updated_at(mapping.getUpdated_at())
                .build())
            .toList();
    }
}
