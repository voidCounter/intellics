package org.intellics.backend.services.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.intellics.backend.domain.entities.UserInteraction;
import org.intellics.backend.domain.entities.UserExperimentalAssignment;
import org.intellics.backend.domain.entities.StrategyInteractionRule;
import org.intellics.backend.services.StrategyRuleEngine;
import org.intellics.backend.services.UserAssignmentService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class StrategyRuleEngineImpl implements StrategyRuleEngine {

    private final UserAssignmentService userAssignmentService;

    @Override
    public boolean shouldUpdateMastery(UserInteraction interaction, UUID userId) {
        log.debug("Checking if interaction should update mastery for user: {}, interaction type: {}", 
            userId, interaction.getInteractionType());
        
        // Ensure user has a strategy assignment
        ensureUserHasStrategy(userId);
        
        // Get user's strategy assignment
        Optional<UserExperimentalAssignment> assignment = userAssignmentService.getUserAssignment(userId);
        if (assignment.isEmpty()) {
            log.warn("User {} has no strategy assignment, defaulting to no mastery update", userId);
            return false;
        }
        
        String interactionType = interaction.getInteractionType().name();
        boolean shouldUpdate = isInteractionTypeRequired(userId, interactionType);
        
        log.debug("User {} strategy: {}, interaction type: {}, should update mastery: {}", 
            userId, assignment.get().getStrategy().getStrategyName(), interactionType, shouldUpdate);
        
        return shouldUpdate;
    }

    @Override
    public double calculateEffectiveWeight(UserInteraction interaction, UUID userId) {
        log.debug("Calculating effective weight for user: {}, interaction type: {}", 
            userId, interaction.getInteractionType());
        
        // Ensure user has a strategy assignment
        ensureUserHasStrategy(userId);
        
        // Get user's strategy assignment with rules
        Optional<UserExperimentalAssignment> assignment = userAssignmentService.getUserAssignment(userId);
        if (assignment.isEmpty()) {
            log.warn("User {} has no strategy assignment, defaulting to weight 0.0", userId);
            return 0.0;
        }
        
        String interactionType = interaction.getInteractionType().name();
        String strategyName = assignment.get().getStrategy().getStrategyName();
        
        // Find the rule for this interaction type
        Optional<StrategyInteractionRule> rule = assignment.get().getStrategy().getInteractionRules().stream()
            .filter(r -> r.getId().getInteractionType().equals(interactionType))
            .findFirst();
        
        if (rule.isPresent()) {
            double weight = rule.get().getMasteryUpdateWeight();
            log.debug("User {} strategy: {}, interaction type: {}, effective weight: {}", 
                userId, strategyName, interactionType, weight);
            return weight;
        } else {
            log.debug("User {} strategy: {}, interaction type: {} not found in rules, weight: 0.0", 
                userId, strategyName, interactionType);
            return 0.0;
        }
    }

    @Override
    public List<String> getRequiredInteractions(UUID userId) {
        log.debug("Getting required interactions for user: {}", userId);
        
        // Ensure user has a strategy assignment
        ensureUserHasStrategy(userId);
        
        // Get user's strategy assignment with rules
        Optional<UserExperimentalAssignment> assignment = userAssignmentService.getUserAssignment(userId);
        if (assignment.isEmpty()) {
            log.warn("User {} has no strategy assignment, returning empty required interactions", userId);
            return List.of();
        }
        
        List<String> requiredInteractions = assignment.get().getStrategy().getInteractionRules().stream()
            .filter(StrategyInteractionRule::getIsRequired)
            .map(rule -> rule.getId().getInteractionType())
            .collect(Collectors.toList());
        
        log.debug("User {} strategy: {}, required interactions: {}", 
            userId, assignment.get().getStrategy().getStrategyName(), requiredInteractions);
        
        return requiredInteractions;
    }

    @Override
    public boolean isInteractionTypeRequired(UUID userId, String interactionType) {
        log.debug("Checking if interaction type {} is required for user: {}", interactionType, userId);
        
        // Ensure user has a strategy assignment
        ensureUserHasStrategy(userId);
        
        // Get user's strategy assignment with rules
        Optional<UserExperimentalAssignment> assignment = userAssignmentService.getUserAssignment(userId);
        if (assignment.isEmpty()) {
            log.warn("User {} has no strategy assignment, interaction type {} not required", userId, interactionType);
            return false;
        }
        
        boolean isRequired = assignment.get().getStrategy().getInteractionRules().stream()
            .anyMatch(rule -> rule.getId().getInteractionType().equals(interactionType) && rule.getIsRequired());
        
        log.debug("User {} strategy: {}, interaction type: {}, is required: {}", 
            userId, assignment.get().getStrategy().getStrategyName(), interactionType, isRequired);
        
        return isRequired;
    }

    @Override
    public String getUserStrategyName(UUID userId) {
        return userAssignmentService.getUserStrategyName(userId)
            .orElse("UNKNOWN");
    }

    @Override
    public void ensureUserHasStrategy(UUID userId) {
        try {
            userAssignmentService.ensureUserHasStrategy(userId);
        } catch (Exception e) {
            log.error("Failed to ensure user {} has strategy assignment: {}", userId, e.getMessage());
            // Don't throw - let the system continue with default behavior
        }
    }
}
