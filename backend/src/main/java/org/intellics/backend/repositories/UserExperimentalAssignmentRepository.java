package org.intellics.backend.repositories;

import org.intellics.backend.domain.entities.UserExperimentalAssignment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserExperimentalAssignmentRepository extends JpaRepository<UserExperimentalAssignment, UUID> {
    
    /**
     * Find user's current experimental strategy assignment
     */
    Optional<UserExperimentalAssignment> findByUserId(UUID userId);
    
    /**
     * Find all users assigned to a specific strategy
     */
    List<UserExperimentalAssignment> findByStrategyStrategyId(UUID strategyId);
    
    /**
     * Find all users assigned to a specific strategy by strategy name
     */
    @Query("SELECT uea FROM UserExperimentalAssignment uea JOIN uea.strategy s WHERE s.strategyName = :strategyName")
    List<UserExperimentalAssignment> findByStrategyName(@Param("strategyName") String strategyName);
    
    /**
     * Check if user has an experimental strategy assignment
     */
    boolean existsByUserId(UUID userId);
    
    /**
     * Count users assigned to a specific strategy
     */
    long countByStrategyStrategyId(UUID strategyId);
    
    /**
     * Find user assignment with strategy and interaction rules
     */
    @Query("SELECT uea FROM UserExperimentalAssignment uea " +
           "JOIN FETCH uea.strategy s " +
           "LEFT JOIN FETCH s.interactionRules " +
           "WHERE uea.userId = :userId")
    Optional<UserExperimentalAssignment> findByUserIdWithStrategyAndRules(@Param("userId") UUID userId);
}
