package org.intellics.backend.services;

import org.intellics.backend.domain.entities.ExperimentalStrategy;
import org.intellics.backend.domain.entities.StrategyInteractionRule;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ExperimentalStrategyService {
    
    /**
     * Create a new experimental strategy
     */
    ExperimentalStrategy createStrategy(ExperimentalStrategy strategy);
    
    /**
     * Get strategy by ID
     */
    Optional<ExperimentalStrategy> getStrategyById(UUID strategyId);
    
    /**
     * Get strategy by name
     */
    Optional<ExperimentalStrategy> getStrategyByName(String strategyName);
    
    /**
     * Get all active strategies
     */
    List<ExperimentalStrategy> getAllActiveStrategies();
    
    /**
     * Update an existing strategy
     */
    ExperimentalStrategy updateStrategy(UUID strategyId, ExperimentalStrategy strategy);
    
    /**
     * Deactivate a strategy (soft delete)
     */
    boolean deactivateStrategy(UUID strategyId);
    
    /**
     * Add interaction rule to strategy
     */
    StrategyInteractionRule addInteractionRule(UUID strategyId, StrategyInteractionRule rule);
    
    /**
     * Remove interaction rule from strategy
     */
    boolean removeInteractionRule(UUID strategyId, String interactionType);
    
    /**
     * Get strategy with all its interaction rules
     */
    Optional<ExperimentalStrategy> getStrategyWithRules(UUID strategyId);
    
    /**
     * Check if strategy name exists
     */
    boolean strategyNameExists(String strategyName);
    
    /**
     * Get default control strategy
     */
    Optional<ExperimentalStrategy> getDefaultControlStrategy();
}
