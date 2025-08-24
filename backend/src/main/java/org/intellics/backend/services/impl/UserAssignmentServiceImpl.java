package org.intellics.backend.services.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.intellics.backend.domain.entities.UserExperimentalAssignment;
import org.intellics.backend.domain.entities.ExperimentalStrategy;
import org.intellics.backend.domain.entities.User;
import org.intellics.backend.repositories.UserExperimentalAssignmentRepository;
import org.intellics.backend.repositories.ExperimentalStrategyRepository;
import org.intellics.backend.repositories.UserRepository;
import org.intellics.backend.services.UserAssignmentService;
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
public class UserAssignmentServiceImpl implements UserAssignmentService {

    private final UserExperimentalAssignmentRepository userAssignmentRepository;
    private final ExperimentalStrategyRepository experimentalStrategyRepository;
    private final UserRepository userRepository;

    @Override
    public UserExperimentalAssignment assignUserToStrategy(UUID userId, UUID strategyId, UUID assignedBy) {
        log.info("Assigning user {} to strategy {}", userId, strategyId);
        
        // Validate user exists
        User user = userRepository.findById(userId)
            .orElseThrow(() -> new IllegalArgumentException("User not found: " + userId));
        
        // Validate strategy exists
        ExperimentalStrategy strategy = experimentalStrategyRepository.findById(strategyId)
            .orElseThrow(() -> new IllegalArgumentException("Strategy not found: " + strategyId));
        
        // Validate assignedBy user exists (if provided)
        User assignedByUser = null;
        if (assignedBy != null) {
            assignedByUser = userRepository.findById(assignedBy)
                .orElseThrow(() -> new IllegalArgumentException("AssignedBy user not found: " + assignedBy));
        }
        
        // Check if user already has an assignment
        Optional<UserExperimentalAssignment> existingAssignment = userAssignmentRepository.findByUserId(userId);
        if (existingAssignment.isPresent()) {
            log.warn("User {} already has strategy assignment: {}", userId, existingAssignment.get().getStrategy().getStrategyName());
            throw new IllegalArgumentException("User already has a strategy assignment");
        }
        
        // Create new assignment
        UserExperimentalAssignment assignment = UserExperimentalAssignment.builder()
            .userId(userId)
            .user(user)
            .strategy(strategy)
            .assignedAt(Instant.now())
            .assignedBy(assignedByUser)
            .build();
        
        UserExperimentalAssignment savedAssignment = userAssignmentRepository.save(assignment);
        log.info("Assigned user {} to strategy: {}", userId, strategy.getStrategyName());
        
        return savedAssignment;
    }

    @Override
    public Optional<UserExperimentalAssignment> getUserAssignment(UUID userId) {
        return userAssignmentRepository.findByUserId(userId);
    }

    @Override
    public Optional<UUID> getUserStrategyId(UUID userId) {
        return userAssignmentRepository.findByUserId(userId)
            .map(assignment -> assignment.getStrategy().getStrategyId());
    }

    @Override
    public Optional<String> getUserStrategyName(UUID userId) {
        return userAssignmentRepository.findByUserId(userId)
            .map(assignment -> assignment.getStrategy().getStrategyName());
    }

    @Override
    public UserExperimentalAssignment changeUserStrategy(UUID userId, UUID newStrategyId, UUID assignedBy) {
        log.info("Changing user {} strategy to {}", userId, newStrategyId);
        
        // Validate new strategy exists
        ExperimentalStrategy newStrategy = experimentalStrategyRepository.findById(newStrategyId)
            .orElseThrow(() -> new IllegalArgumentException("Strategy not found: " + newStrategyId));
        
        // Validate assignedBy user exists (if provided)
        User assignedByUser = null;
        if (assignedBy != null) {
            assignedByUser = userRepository.findById(assignedBy)
                .orElseThrow(() -> new IllegalArgumentException("AssignedBy user not found: " + assignedBy));
        }
        
        // Get existing assignment or create new one
        UserExperimentalAssignment assignment = userAssignmentRepository.findByUserId(userId)
            .orElseGet(() -> {
                // Create new assignment if none exists
                User user = userRepository.findById(userId)
                    .orElseThrow(() -> new IllegalArgumentException("User not found: " + userId));
                
                return UserExperimentalAssignment.builder()
                    .userId(userId)
                    .user(user)
                    .assignedAt(Instant.now())
                    .build();
            });
        
        // Update strategy
        assignment.setStrategy(newStrategy);
        assignment.setAssignedBy(assignedByUser);
        
        UserExperimentalAssignment savedAssignment = userAssignmentRepository.save(assignment);
        log.info("Changed user {} strategy to: {}", userId, newStrategy.getStrategyName());
        
        return savedAssignment;
    }

    @Override
    public boolean removeUserAssignment(UUID userId) {
        log.info("Removing strategy assignment for user: {}", userId);
        
        Optional<UserExperimentalAssignment> assignment = userAssignmentRepository.findByUserId(userId);
        if (assignment.isPresent()) {
            userAssignmentRepository.deleteById(userId);
            log.info("Removed strategy assignment for user: {}", userId);
            return true;
        }
        
        log.warn("No strategy assignment found for user: {}", userId);
        return false;
    }

    @Override
    public List<UserExperimentalAssignment> getUsersInStrategy(UUID strategyId) {
        return userAssignmentRepository.findByStrategyStrategyId(strategyId);
    }

    @Override
    public List<UserExperimentalAssignment> getUsersInStrategyByName(String strategyName) {
        return userAssignmentRepository.findByStrategyName(strategyName);
    }

    @Override
    public long countUsersInStrategy(UUID strategyId) {
        return userAssignmentRepository.countByStrategyStrategyId(strategyId);
    }

    @Override
    public boolean userHasStrategy(UUID userId, UUID strategyId) {
        return userAssignmentRepository.findByUserId(userId)
            .map(assignment -> assignment.getStrategy().getStrategyId().equals(strategyId))
            .orElse(false);
    }

    @Override
    public boolean userHasStrategyByName(UUID userId, String strategyName) {
        return userAssignmentRepository.findByUserId(userId)
            .map(assignment -> assignment.getStrategy().getStrategyName().equals(strategyName))
            .orElse(false);
    }

    @Override
    public UserExperimentalAssignment ensureUserHasStrategy(UUID userId) {
        log.info("Ensuring user {} has a strategy assignment", userId);
        
        Optional<UserExperimentalAssignment> existingAssignment = userAssignmentRepository.findByUserId(userId);
        if (existingAssignment.isPresent()) {
            log.debug("User {} already has strategy assignment: {}", userId, existingAssignment.get().getStrategy().getStrategyName());
            return existingAssignment.get();
        }
        
        // Get default control strategy
        ExperimentalStrategy defaultStrategy = experimentalStrategyRepository.findByStrategyName("CONTROL")
            .orElseThrow(() -> new RuntimeException("Default CONTROL strategy not found"));
        
        // Create default assignment
        User user = userRepository.findById(userId)
            .orElseThrow(() -> new IllegalArgumentException("User not found: " + userId));
        
        UserExperimentalAssignment assignment = UserExperimentalAssignment.builder()
            .userId(userId)
            .user(user)
            .strategy(defaultStrategy)
            .assignedAt(Instant.now())
            .assignedBy(null) // System assignment
            .build();
        
        UserExperimentalAssignment savedAssignment = userAssignmentRepository.save(assignment);
        log.info("Created default strategy assignment for user {}: {}", userId, defaultStrategy.getStrategyName());
        
        return savedAssignment;
    }
}
