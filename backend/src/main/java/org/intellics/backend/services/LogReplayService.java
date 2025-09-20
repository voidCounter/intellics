package org.intellics.backend.services;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import org.intellics.backend.domain.dto.ReplayResultDto;
import org.intellics.backend.domain.entities.LessonKCMapping;
import org.intellics.backend.domain.entities.QuestionKCMapping;
import org.intellics.backend.domain.entities.QuestionKCMappingId;
import org.intellics.backend.domain.entities.StudentKCMastery;
import org.intellics.backend.domain.entities.UserInteraction;
import org.intellics.backend.repositories.LessonKCMappingRepository;
import org.intellics.backend.repositories.QuestionKCMappingRepository;
import org.intellics.backend.repositories.StudentKCMasteryRepository;
import org.intellics.backend.repositories.UserInteractionRepository;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class LogReplayService {
    
    private final UserInteractionRepository userInteractionRepository;
    private final QuestionKCMappingRepository questionKCMappingRepository;
    private final StudentKCMasteryRepository studentKCMasteryRepository;
    private final LessonKCMappingRepository lessonKCMappingRepository;
    private final StrategyRuleEngine strategyRuleEngine;
    private final KCMasteryService kcMasteryService;
    
    /**
     * Replay KC mastery progression for a user based on allowed interaction types
     * 
     * @param userId The user ID to replay interactions for
     * @param allowedInteractionTypes List of interaction types to consider for mastery updates
     * @return List of replay results showing mastery progression
     */
    public List<ReplayResultDto> replayKCMastery(UUID userId, List<String> allowedInteractionTypes) {
        log.info("Starting KC mastery replay for user: {} with allowed types: {}", userId, allowedInteractionTypes);
        
        // Get all interactions for user, ordered chronologically
        List<UserInteraction> interactions = userInteractionRepository
            .findByUserIdOrderByTimestamp(userId);
        
        log.debug("Found {} interactions for user: {}", interactions.size(), userId);
        
        // Keep running mastery for each KC
        Map<UUID, Double> runningMastery = new HashMap<>();
        
        // Initialize running mastery with current values from database
        initializeRunningMastery(userId, runningMastery);
        
        List<ReplayResultDto> results = new ArrayList<>();
        
        for (UserInteraction interaction : interactions) {
            log.debug("Processing interaction: {} type: {}", 
                interaction.getInteraction_id(), interaction.getInteractionType());
            
            // Get KCs for this interaction
            List<QuestionKCMapping> kcMappings = getKCMappingsForInteraction(interaction);
            
            if (kcMappings.isEmpty()) {
                log.debug("No KC mappings found for interaction: {}", interaction.getInteraction_id());
                // Still add the interaction to results for engagement analysis, but with no KC data
                ReplayResultDto result = ReplayResultDto.builder()
                    .userId(userId)
                    .kcId(null)
                    .kcName(null)
                    .interactionId(interaction.getInteraction_id())
                    .interactionType(interaction.getInteractionType().name())
                    .isCorrect(interaction.is_correct())
                    .timestamp(interaction.getTimestamp())
                    .masteryBefore(null)
                    .masteryAfter(null)
                    .effectiveWeight(0.0)
                    .shouldUpdate(false)
                    .build();
                results.add(result);
                continue;
            }
            
            for (QuestionKCMapping kcMapping : kcMappings) {
                UUID kcId = kcMapping.getKnowledge_component().getKc_id();
                
                // Get current mastery from running state
                double currentMastery = runningMastery.getOrDefault(kcId, 0.0);
                
                // Check if this interaction should update mastery based on allowed types (not user's strategy)
                boolean isAllowedType = allowedInteractionTypes.contains(interaction.getInteractionType().name());
                boolean shouldUpdate = isAllowedType && strategyRuleEngine.shouldUpdateMastery(interaction, userId);
                
                double newMastery = currentMastery; // Default: no change
                double effectiveWeight = 0.0;
                
                if (shouldUpdate) {
                    // Calculate effective weight
                    double strategyWeight = strategyRuleEngine.calculateEffectiveWeight(interaction, userId);
                    double baseWeight = kcMapping.getWeight();
                    effectiveWeight = baseWeight * strategyWeight;
                    
                    log.debug("Updating mastery for KC: {} - current: {}, effective weight: {}", 
                        kcId, currentMastery, effectiveWeight);
                    
                    // Get BKT parameters from existing user's KC mastery record (read-only)
                    Optional<StudentKCMastery> userKCMastery = studentKCMasteryRepository.findByUserIdAndKcId(userId, kcId);
                    
                    // Use default BKT parameters if no mastery record exists (for research purposes)
                    double pGuess = userKCMastery.map(StudentKCMastery::getP_guess).orElse(0.2);
                    double pSlip = userKCMastery.map(StudentKCMastery::getP_slip).orElse(0.15);
                    double pTransit = userKCMastery.map(StudentKCMastery::getP_transit).orElse(0.2);
                    
                    // Apply BKT formula with actual user parameters (or defaults)
                    newMastery = kcMasteryService.calculateBKTUpdate(
                        currentMastery,
                        interaction.is_correct(),
                        pGuess,
                        pSlip,
                        pTransit,
                        effectiveWeight
                    );
                    
                    log.debug("BKT update result: {} -> {} (p_guess={}, p_slip={}, p_transit={})", 
                        currentMastery, newMastery, pGuess, pSlip, pTransit);
                } else {
                    if (!isAllowedType) {
                        log.debug("No mastery update for interaction type: {} (not in allowed list), mastery unchanged: {} -> {}", 
                            interaction.getInteractionType(), currentMastery, currentMastery);
                    } else {
                        log.debug("No mastery update for interaction type: {} (strategy rule), mastery unchanged: {} -> {}", 
                            interaction.getInteractionType(), currentMastery, currentMastery);
                    }
                }
                
                // Update running mastery (even for non-updating interactions to maintain continuity)
                runningMastery.put(kcId, newMastery);
                
                // Store result
                ReplayResultDto result = ReplayResultDto.builder()
                    .userId(userId)
                    .kcId(kcId)
                    .kcName(kcMapping.getKnowledge_component().getKc_name())
                    .interactionId(interaction.getInteraction_id())
                    .interactionType(interaction.getInteractionType().name())
                    .isCorrect(interaction.is_correct())
                    .timestamp(interaction.getTimestamp())
                    .masteryBefore(currentMastery)
                    .masteryAfter(newMastery)
                    .effectiveWeight(effectiveWeight)
                    .shouldUpdate(shouldUpdate)
                    .build();
                
                results.add(result);
            }
        }
        
        log.info("Completed KC mastery replay for user: {} - processed {} results", userId, results.size());
        return results;
    }
    
    /**
     * Initialize running mastery with historical values from interaction_kc_mapping
     * This ensures we start from the actual mastery levels that existed when interactions happened
     */
    private void initializeRunningMastery(UUID userId, Map<UUID, Double> runningMastery) {
        // Get the earliest mastery_before value for each KC from interaction_kc_mapping
        // This represents the actual mastery level when the first interaction for that KC happened
        List<Object[]> earliestMastery = userInteractionRepository.findEarliestMasteryBeforeByUserId(userId);
        
        for (Object[] result : earliestMastery) {
            UUID kcId = (UUID) result[0];
            Double masteryBefore = (Double) result[1];
            runningMastery.put(kcId, masteryBefore);
            log.debug("Initialized KC {} mastery to historical value: {}", kcId, masteryBefore);
        }
        
        log.debug("Initialized running mastery for {} KCs for user: {} using historical values", 
            earliestMastery.size(), userId);
    }
    
    /**
     * Get KC mappings for an interaction (question, lesson, or scaffold)
     * Based on KCMasteryServiceImpl logic
     */
    private List<QuestionKCMapping> getKCMappingsForInteraction(UserInteraction interaction) {
        if (interaction.getQuestion() != null) {
            // Question KCs - search question_kc_mapping
            return questionKCMappingRepository.findByQuestionId(interaction.getQuestion().getQuestion_id());
        } else if (interaction.getLesson() != null) {
            // Lesson KCs - search lesson_kc_mapping
            List<LessonKCMapping> lessonKCMappings = lessonKCMappingRepository.findByLessonId(interaction.getLesson().getLesson_id());
            // Convert to QuestionKCMapping format for consistency
            return lessonKCMappings.stream()
                .map(lkm -> QuestionKCMapping.builder()
                    .mappingId(QuestionKCMappingId.builder()
                        .question_id(null) // No question ID for lesson KCs
                        .kc_id(lkm.getKnowledge_component().getKc_id())
                        .build())
                    .knowledge_component(lkm.getKnowledge_component())
                    .weight(lkm.getTarget_mastery() != null ? lkm.getTarget_mastery().doubleValue() : 1.0) // Use target mastery as weight for lesson KCs
                    .build())
                .toList();
        }
        
        // For now, only handle question and lesson interactions
        // Could be extended to handle scaffold interactions
        log.debug("No question or lesson found for interaction: {}, skipping KC mapping", interaction.getInteraction_id());
        return List.of();
    }
    
    /**
     * Convenience method to replay with only HINT_REQUESTED and QUESTION_ATTEMPTED
     */
    public List<ReplayResultDto> replayHintAndQuestionAttempts(UUID userId) {
        List<String> allowedTypes = Arrays.asList("HINT_REQUESTED", "QUESTION_ATTEMPTED");
        return replayKCMastery(userId, allowedTypes);
    }
    
    /**
     * Convenience method to replay with only HINT_REQUESTED
     */
    public List<ReplayResultDto> replayHintOnly(UUID userId) {
        List<String> allowedTypes = Arrays.asList("HINT_REQUESTED");
        return replayKCMastery(userId, allowedTypes);
    }
    
    /**
     * Convenience method to replay with only QUESTION_ATTEMPTED
     */
    public List<ReplayResultDto> replayQuestionAttemptsOnly(UUID userId) {
        List<String> allowedTypes = Arrays.asList("QUESTION_ATTEMPTED");
        return replayKCMastery(userId, allowedTypes);
    }
}
