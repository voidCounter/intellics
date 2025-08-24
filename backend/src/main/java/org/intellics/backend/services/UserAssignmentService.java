package org.intellics.backend.services;

import org.intellics.backend.domain.entities.UserExperimentalAssignment;
import org.intellics.backend.domain.entities.ExperimentalStrategy;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface UserAssignmentService {
    
    /**
     * Assign user to an experimental strategy
     */
    UserExperimentalAssignment assignUserToStrategy(UUID userId, UUID strategyId, UUID assignedBy);
    
    /**
     * Get user's current experimental strategy assignment
     */
    Optional<UserExperimentalAssignment> getUserAssignment(UUID userId);
    
    /**
     * Get user's strategy ID (convenience method)
     */
    Optional<UUID> getUserStrategyId(UUID userId);
    
    /**
     * Get user's strategy name (convenience method)
     */
    Optional<String> getUserStrategyName(UUID userId);
    
    /**
     * Change user's strategy assignment
     */
    UserExperimentalAssignment changeUserStrategy(UUID userId, UUID newStrategyId, UUID assignedBy);
    
    /**
     * Remove user's strategy assignment (revert to default)
     */
    boolean removeUserAssignment(UUID userId);
    
    /**
     * Get all users assigned to a specific strategy
     */
    List<UserExperimentalAssignment> getUsersInStrategy(UUID strategyId);
    
    /**
     * Get all users assigned to a specific strategy by name
     */
    List<UserExperimentalAssignment> getUsersInStrategyByName(String strategyName);
    
    /**
     * Count users in a specific strategy
     */
    long countUsersInStrategy(UUID strategyId);
    
    /**
     * Check if user has a specific strategy assignment
     */
    boolean userHasStrategy(UUID userId, UUID strategyId);
    
    /**
     * Check if user has a specific strategy assignment by name
     */
    boolean userHasStrategyByName(UUID userId, String strategyName);
    
    /**
     * Ensure user has a strategy assignment (create default if none exists)
     */
    UserExperimentalAssignment ensureUserHasStrategy(UUID userId);
}
