package org.intellics.backend.services.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.intellics.backend.domain.entities.ExperimentalStrategy;
import org.intellics.backend.domain.entities.StrategyInteractionRule;
import org.intellics.backend.domain.entities.StrategyInteractionRuleId;
import org.intellics.backend.repositories.ExperimentalStrategyRepository;
import org.intellics.backend.services.ExperimentalStrategyService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional
public class ExperimentalStrategyServiceImpl implements ExperimentalStrategyService {

    private final ExperimentalStrategyRepository experimentalStrategyRepository;

    @Override
    public ExperimentalStrategy createStrategy(ExperimentalStrategy strategy) {
        log.info("Creating new experimental strategy: {}", strategy.getStrategyName());
        
        if (strategyNameExists(strategy.getStrategyName())) {
            throw new IllegalArgumentException("Strategy name already exists: " + strategy.getStrategyName());
        }
        
        strategy.setCreatedAt(Instant.now());
        strategy.setUpdatedAt(Instant.now());
        strategy.setIsActive(true);
        
        ExperimentalStrategy savedStrategy = experimentalStrategyRepository.save(strategy);
        log.info("Created experimental strategy: {} with ID: {}", savedStrategy.getStrategyName(), savedStrategy.getStrategyId());
        
        return savedStrategy;
    }

    @Override
    public Optional<ExperimentalStrategy> getStrategyById(UUID strategyId) {
        return experimentalStrategyRepository.findById(strategyId);
    }

    @Override
    public Optional<ExperimentalStrategy> getStrategyByName(String strategyName) {
        return experimentalStrategyRepository.findByStrategyName(strategyName);
    }

    @Override
    public List<ExperimentalStrategy> getAllActiveStrategies() {
        return experimentalStrategyRepository.findByIsActiveTrue();
    }

    @Override
    public ExperimentalStrategy updateStrategy(UUID strategyId, ExperimentalStrategy updatedStrategy) {
        log.info("Updating experimental strategy: {}", strategyId);
        
        ExperimentalStrategy existingStrategy = experimentalStrategyRepository.findById(strategyId)
            .orElseThrow(() -> new IllegalArgumentException("Strategy not found: " + strategyId));
        
        // Check if name change conflicts with existing strategy
        if (!existingStrategy.getStrategyName().equals(updatedStrategy.getStrategyName()) && 
            strategyNameExists(updatedStrategy.getStrategyName())) {
            throw new IllegalArgumentException("Strategy name already exists: " + updatedStrategy.getStrategyName());
        }
        
        existingStrategy.setStrategyName(updatedStrategy.getStrategyName());
        existingStrategy.setDescription(updatedStrategy.getDescription());
        existingStrategy.setIsActive(updatedStrategy.getIsActive());
        existingStrategy.setUpdatedAt(Instant.now());
        
        ExperimentalStrategy savedStrategy = experimentalStrategyRepository.save(existingStrategy);
        log.info("Updated experimental strategy: {} with ID: {}", savedStrategy.getStrategyName(), savedStrategy.getStrategyId());
        
        return savedStrategy;
    }

    @Override
    public boolean deactivateStrategy(UUID strategyId) {
        log.info("Deactivating experimental strategy: {}", strategyId);
        
        ExperimentalStrategy strategy = experimentalStrategyRepository.findById(strategyId)
            .orElseThrow(() -> new IllegalArgumentException("Strategy not found: " + strategyId));
        
        strategy.setIsActive(false);
        strategy.setUpdatedAt(Instant.now());
        
        experimentalStrategyRepository.save(strategy);
        log.info("Deactivated experimental strategy: {} with ID: {}", strategy.getStrategyName(), strategy.getStrategyId());
        
        return true;
    }

    @Override
    public StrategyInteractionRule addInteractionRule(UUID strategyId, StrategyInteractionRule rule) {
        log.info("Adding interaction rule for strategy: {}, interaction type: {}", strategyId, rule.getId().getInteractionType());
        
        ExperimentalStrategy strategy = experimentalStrategyRepository.findById(strategyId)
            .orElseThrow(() -> new IllegalArgumentException("Strategy not found: " + strategyId));
        
        // Set the strategy reference
        rule.setStrategy(strategy);
        
        // Set timestamps
        rule.setCreatedAt(Instant.now());
        rule.setUpdatedAt(Instant.now());
        
        // Add to strategy's rules
        if (strategy.getInteractionRules() == null) {
            strategy.setInteractionRules(List.of());
        }
        strategy.getInteractionRules().add(rule);
        
        experimentalStrategyRepository.save(strategy);
        log.info("Added interaction rule for strategy: {} with interaction type: {}", strategyId, rule.getId().getInteractionType());
        
        return rule;
    }

    @Override
    public boolean removeInteractionRule(UUID strategyId, String interactionType) {
        log.info("Removing interaction rule for strategy: {}, interaction type: {}", strategyId, interactionType);
        
        ExperimentalStrategy strategy = experimentalStrategyRepository.findById(strategyId)
            .orElseThrow(() -> new IllegalArgumentException("Strategy not found: " + strategyId));
        
        if (strategy.getInteractionRules() != null) {
            boolean removed = strategy.getInteractionRules().removeIf(rule -> 
                rule.getId().getInteractionType().equals(interactionType));
            
            if (removed) {
                experimentalStrategyRepository.save(strategy);
                log.info("Removed interaction rule for strategy: {} with interaction type: {}", strategyId, interactionType);
                return true;
            }
        }
        
        log.warn("No interaction rule found for strategy: {} with interaction type: {}", strategyId, interactionType);
        return false;
    }

    @Override
    public Optional<ExperimentalStrategy> getStrategyWithRules(UUID strategyId) {
        return experimentalStrategyRepository.findByIdWithInteractionRules(strategyId);
    }

    @Override
    public boolean strategyNameExists(String strategyName) {
        return experimentalStrategyRepository.existsByStrategyName(strategyName);
    }

    @Override
    public Optional<ExperimentalStrategy> getDefaultControlStrategy() {
        return experimentalStrategyRepository.findByStrategyName("CONTROL");
    }
}
