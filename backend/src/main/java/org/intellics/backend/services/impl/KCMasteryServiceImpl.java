package org.intellics.backend.services.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.intellics.backend.domain.entities.*;
import org.intellics.backend.repositories.InteractionKCMappingRepository;
import org.intellics.backend.repositories.LessonKCMappingRepository;
import org.intellics.backend.repositories.QuestionKCMappingRepository;
import org.intellics.backend.repositories.StudentKCMasteryRepository;
import org.intellics.backend.repositories.UserRepository;
import org.intellics.backend.repositories.KnowledgeComponentRepository;
import org.intellics.backend.services.KCMasteryService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

/**
 * Service for updating Knowledge Component mastery using Bayesian Knowledge Tracing (BKT).
 * 
 * Lazy Initialization Strategy:
 * - Don't prefill user_kc_mastery table when users create accounts
 * - Initialize KC mastery for ANY KC the user encounters (LESSON_START, QUESTION_PRESENTED, etc.)
 * - This ensures every KC interaction is logged with mastery before/after values
 * - Only learning interactions (QUESTION_ATTEMPTED, SCAFFOLD_ATTEMPTED) actually update mastery
 * - user_kc_mastery is always updated (timestamp + mastery values) for every KC interaction
 * - Complete audit trail for all KC interactions
 * 
 * Weight Handling:
 * - Question KCs: Use question_kc_mapping.weight directly
 * - Lesson KCs: Use lesson_kc_mapping.target_mastery as weight
 * - Scaffold KCs: Use question_kc_mapping.weight * SCAFFOLD_WEIGHT (0.3) for gentler learning
 * - Weight Application: Applied to mastery CHANGE, not mastery value (prevents harsh scaling)
 */
@Service
@RequiredArgsConstructor
@Slf4j
@Transactional
public class KCMasteryServiceImpl implements KCMasteryService {

    private final StudentKCMasteryRepository studentKCMasteryRepository;
    private final QuestionKCMappingRepository questionKCMappingRepository;
    private final LessonKCMappingRepository lessonKCMappingRepository;
    private final InteractionKCMappingRepository interactionKCMappingRepository;
    private final UserRepository userRepository;
    private final KnowledgeComponentRepository knowledgeComponentRepository;

    /**
     * Default BKT parameters for new KCs (lazy-initialized on first encounter)
     * 
     * p_mastery: 0.25 - Probability user already knows the KC (25% for brand-new learner)
     * p_guess: 0.2   - Probability of guessing correctly (20% for multiple-choice questions)
     * p_slip: 0.15   - Probability of making mistake when known (15% common rate)
     * p_transit: 0.2 - Probability mastery increases after correct attempt (20% gradual learning)
     */
    private static final double DEFAULT_P_MASTERY = 0.25;  // 25% - typical for brand-new learner
    private static final double DEFAULT_P_GUESS = 0.2;     // 20% - standard for multiple-choice questions
    private static final double DEFAULT_P_SLIP = 0.15;     // 15% - common mistake rate when known
    private static final double DEFAULT_P_TRANSIT = 0.2;   // 20% - gradual learning rate
    
    /**
     * Scaffold weight - lower impact on mastery since scaffolds are learning aids
     */
    private static final double SCAFFOLD_WEIGHT = 0.3;  // 30% of normal question weight

    @Override
    public void updateMastery(UserInteraction interaction) {
        // Check if this interaction involves KCs that need logging
        if (!shouldLogKCMappings(interaction.getInteractionType())) {
            log.debug("Skipping KC logging for interaction type: {}", interaction.getInteractionType());
            return;
        }

        log.debug("Processing KC interaction: {}", interaction.getInteraction_id());

        // Get KCs associated with this interaction
        List<QuestionKCMapping> kcMappings = getKCMappingsForInteraction(interaction);
        
        if (kcMappings.isEmpty()) {
            log.debug("No KC mappings found for interaction: {}", interaction.getInteraction_id());
            return;
        }

        // Process each KC (lazy-initialize + log + optionally update mastery)
        for (QuestionKCMapping kcMapping : kcMappings) {
            processKCInteraction(interaction, kcMapping);
        }
    }

    @Override
    public double calculateBKTUpdate(double currentMastery, boolean isCorrect, double pGuess, double pSlip, double pTransit, double weight) {
        // BKT formula: P(L) = P(L|C) * P(C) + P(L|~C) * P(~C)
        // where P(C) = P(L) * (1 - P(S)) + (1 - P(L)) * P(G)
        
        // Weight is applied to the CHANGE in mastery, not the mastery value itself
        // This ensures weight = 0.5 halves the learning impact instead of scaling mastery down
        
        double pCorrect = currentMastery * (1 - pSlip) + (1 - currentMastery) * pGuess;
        
        if (isCorrect) {
            // P(L|C) = P(L) * (1 - P(S)) / P(C)
            double pLearnedGivenCorrect = (currentMastery * (1 - pSlip)) / pCorrect;
            // Apply transition probability
            double newMastery = pLearnedGivenCorrect + (1 - pLearnedGivenCorrect) * pTransit;
            // Apply weight to the CHANGE in mastery, not the mastery itself
            return Math.min(1.0, currentMastery + (newMastery - currentMastery) * weight);
        } else {
            // P(L|~C) = P(L) * P(S) / (1 - P(C))
            double pLearnedGivenIncorrect = (currentMastery * pSlip) / (1 - pCorrect);
            // Apply weight to the CHANGE in mastery, not the mastery itself
            return Math.max(0.0, currentMastery + (pLearnedGivenIncorrect - currentMastery) * weight);
        }
    }

    private boolean shouldUpdateMastery(InteractionType interactionType) {
        return switch (interactionType) {
            case QUESTION_ATTEMPTED, SCAFFOLD_ATTEMPTED -> true;
            case QUESTION_SKIPPED -> true; // Optional: could be false if you don't want to penalize skips
            case HINT_REQUESTED, SCAFFOLD_REQUESTED, LESSON_START, LESSON_EXIT, QUESTION_PRESENTED, SCAFFOLD_ANSWER -> false;
        };
    }

    /**
     * Check if interaction should log KC mappings (all KC interactions)
     */
    private boolean shouldLogKCMappings(InteractionType interactionType) {
        return switch (interactionType) {
            case LESSON_START, LESSON_EXIT, QUESTION_PRESENTED, HINT_REQUESTED, 
                 SCAFFOLD_REQUESTED, QUESTION_ATTEMPTED, SCAFFOLD_ATTEMPTED, 
                 QUESTION_SKIPPED, SCAFFOLD_ANSWER -> true;
        };
    }

    /**
     * Get KC mappings for an interaction (question, lesson, or scaffold)
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
        } else if (interaction.getScaffold() != null) {
            // Scaffold KCs - get question_id from scaffold and search question_kc_mapping
            if (interaction.getScaffold().getQuestion() != null) {
                List<QuestionKCMapping> questionKCMappings = questionKCMappingRepository.findByQuestionId(interaction.getScaffold().getQuestion().getQuestion_id());
                // Apply scaffold weight (lower impact on mastery)
                log.debug("Applying scaffold weight reduction: original weights will be multiplied by {}", SCAFFOLD_WEIGHT);
                return questionKCMappings.stream()
                    .map(qkm -> {
                        double originalWeight = qkm.getWeight();
                        double scaffoldWeight = originalWeight * SCAFFOLD_WEIGHT;
                        log.debug("Scaffold KC weight: {} -> {} (KC: {})", originalWeight, scaffoldWeight, qkm.getKnowledge_component().getKc_id());
                        return QuestionKCMapping.builder()
                            .mappingId(qkm.getMappingId())
                            .knowledge_component(qkm.getKnowledge_component())
                            .weight(scaffoldWeight) // Reduce weight for scaffolds
                            .build();
                    })
                    .toList();
            } else {
                log.debug("Scaffold has no associated question, cannot determine KCs");
                return List.of();
            }
        }
        return List.of();
    }

    /**
     * Process KC interaction: lazy-initialize, log, and always update user_kc_mastery
     * 
     * Flow:
     * 1. Lazy-initialize KC mastery if it doesn't exist
     * 2. For learning interactions: calculate new mastery using BKT
     * 3. For non-learning interactions: reuse existing mastery value
     * 4. Always update user_kc_mastery (timestamp + mastery values)
     * 5. Always create interaction_kc_mapping record
     */
    private void processKCInteraction(UserInteraction interaction, QuestionKCMapping kcMapping) {
        UUID userId = interaction.getUser().getUser_id();
        UUID kcId = kcMapping.getKnowledge_component().getKc_id();
        double weight = kcMapping.getWeight();

        log.debug("Processing KC interaction for user: {}, KC: {}, weight: {} (from {} mapping)", 
            userId, kcId, weight, 
            interaction.getQuestion() != null ? "question_kc" : 
            interaction.getLesson() != null ? "lesson_kc" : 
            interaction.getScaffold() != null ? "scaffold->question_kc (reduced weight)" : "unknown");

        // 1. Lazy-initialize KC mastery if it doesn't exist
        StudentKCMastery currentMastery = getOrCreateMastery(userId, kcId);
        double masteryBefore = currentMastery.getP_mastery();
        double masteryAfter = masteryBefore; // Default: no change

        // 2. Update mastery only for learning interactions
        if (shouldUpdateMastery(interaction.getInteractionType())) {
            log.debug("Calculating BKT update with weight: {} for user: {}, KC: {}", weight, userId, kcId);
            masteryAfter = calculateBKTUpdate(
                masteryBefore,
                interaction.is_correct(),
                currentMastery.getP_guess(),
                currentMastery.getP_slip(),
                currentMastery.getP_transit(),
                weight
            );

            log.debug("Updated mastery for user: {}, KC: {}: {} -> {} (weight: {})", 
                userId, kcId, masteryBefore, masteryAfter, weight);
        } else {
            log.debug("No mastery update for interaction type: {}, mastery unchanged: {} (weight: {})", 
                interaction.getInteractionType(), masteryBefore, weight);
        }

        // 3. Always update user_kc_mastery (even for non-learning interactions)
        // This ensures updated_at timestamp is current and mastery values are preserved
        currentMastery.setP_mastery(masteryAfter);
        currentMastery.setUpdated_at(Instant.now());
        studentKCMasteryRepository.save(currentMastery);

        // 4. Always create interaction-KC mapping (audit trail)
        createInteractionKCMapping(interaction, kcMapping, masteryBefore, masteryAfter);
    }

    private StudentKCMastery getOrCreateMastery(UUID userId, UUID kcId) {
        return studentKCMasteryRepository.findByUserIdAndKcId(userId, kcId)
            .orElseGet(() -> {
                log.info("Lazy-initializing KC mastery for user: {}, KC: {} with defaults (p_mastery={}, p_guess={}, p_slip={}, p_transit={})", 
                    userId, kcId, DEFAULT_P_MASTERY, DEFAULT_P_GUESS, DEFAULT_P_SLIP, DEFAULT_P_TRANSIT);
                return createDefaultMastery(userId, kcId);
            });
    }

    private StudentKCMastery createDefaultMastery(UUID userId, UUID kcId) {
        log.debug("Creating default mastery for user: {}, KC: {}", userId, kcId);
        
        // We need to fetch the actual entities for the relationships
        User user = userRepository.findById(userId)
            .orElseThrow(() -> new RuntimeException("User not found: " + userId));
        KnowledgeComponent kc = knowledgeComponentRepository.findById(kcId)
            .orElseThrow(() -> new RuntimeException("Knowledge Component not found: " + kcId));
        
        StudentKCMasteryId id = StudentKCMasteryId.builder()
            .user_id(userId)
            .kc_id(kcId)
            .build();

        return StudentKCMastery.builder()
            .studentKCMasteryId(id)
            .user(user)
            .knowledgeComponent(kc)
            .p_mastery(DEFAULT_P_MASTERY)
            .p_guess(DEFAULT_P_GUESS)
            .p_slip(DEFAULT_P_SLIP)
            .p_transit(DEFAULT_P_TRANSIT)
            .updated_at(Instant.now())
            .build();
    }

    private void createInteractionKCMapping(UserInteraction interaction, QuestionKCMapping kcMapping, 
                                          double masteryBefore, double masteryAfter) {
        InteractionKCMapping mapping = InteractionKCMapping.builder()
            .interaction(interaction)
            .knowledgeComponent(kcMapping.getKnowledge_component())
            .weight(kcMapping.getWeight())
            .kcMasteryBefore(masteryBefore)
            .kcMasteryAfter(masteryAfter)
            .created_at(Instant.now())  // Set creation timestamp
            .updated_at(Instant.now())  // Set initial update timestamp
            .build();

        interactionKCMappingRepository.save(mapping);
        log.debug("Created interaction-KC mapping for interaction: {}, KC: {} with timestamps", 
            interaction.getInteraction_id(), kcMapping.getKnowledge_component().getKc_id());
    }
}
