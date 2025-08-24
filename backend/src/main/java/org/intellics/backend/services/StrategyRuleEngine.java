package org.intellics.backend.services;

import org.intellics.backend.domain.entities.UserInteraction;

import java.util.List;
import java.util.UUID;

public interface StrategyRuleEngine {
    
    /**
     * Check if the given interaction should trigger a mastery update for the user
     */
    boolean shouldUpdateMastery(UserInteraction interaction, UUID userId);
    
    /**
     * Calculate the effective weight for mastery update based on user's strategy
     */
    double calculateEffectiveWeight(UserInteraction interaction, UUID userId);
    
    /**
     * Get all interaction types that are required for mastery updates for the user
     */
    List<String> getRequiredInteractions(UUID userId);
    
    /**
     * Check if a specific interaction type is required for mastery updates for the user
     */
    boolean isInteractionTypeRequired(UUID userId, String interactionType);
    
    /**
     * Get the user's current experimental strategy name
     */
    String getUserStrategyName(UUID userId);
    
    /**
     * Ensure user has a strategy assignment (create default if none exists)
     */
    void ensureUserHasStrategy(UUID userId);
}
