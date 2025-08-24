package org.intellics.backend.repositories;

import org.intellics.backend.domain.entities.ExperimentalStrategy;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ExperimentalStrategyRepository extends JpaRepository<ExperimentalStrategy, UUID> {
    
    /**
     * Find strategy by name
     */
    Optional<ExperimentalStrategy> findByStrategyName(String strategyName);
    
    /**
     * Find all active strategies
     */
    List<ExperimentalStrategy> findByIsActiveTrue();
    
    /**
     * Check if strategy name exists
     */
    boolean existsByStrategyName(String strategyName);
    
    /**
     * Find strategy with its interaction rules
     */
    @Query("SELECT s FROM ExperimentalStrategy s LEFT JOIN FETCH s.interactionRules WHERE s.strategyId = :strategyId")
    Optional<ExperimentalStrategy> findByIdWithInteractionRules(@Param("strategyId") UUID strategyId);
    
    /**
     * Find all strategies with their interaction rules
     */
    @Query("SELECT DISTINCT s FROM ExperimentalStrategy s LEFT JOIN FETCH s.interactionRules WHERE s.isActive = true")
    List<ExperimentalStrategy> findAllActiveWithInteractionRules();
}
