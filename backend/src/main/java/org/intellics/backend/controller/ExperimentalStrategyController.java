package org.intellics.backend.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.intellics.backend.domain.entities.ExperimentalStrategy;
import org.intellics.backend.domain.entities.UserExperimentalAssignment;
import org.intellics.backend.services.ExperimentalStrategyService;
import org.intellics.backend.services.UserAssignmentService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/admin/experimental-strategies")
@RequiredArgsConstructor
@Slf4j
@PreAuthorize("hasRole('ADMIN')")
public class ExperimentalStrategyController {

    private final ExperimentalStrategyService experimentalStrategyService;
    private final UserAssignmentService userAssignmentService;


    @PostMapping
    public ResponseEntity<ExperimentalStrategy> createStrategy(@RequestBody ExperimentalStrategy strategy) {
        log.info("Admin creating new experimental strategy: {}", strategy.getStrategyName());
        
        try {
            ExperimentalStrategy createdStrategy = experimentalStrategyService.createStrategy(strategy);
            return ResponseEntity.status(HttpStatus.CREATED).body(createdStrategy);
        } catch (IllegalArgumentException e) {
            log.warn("Failed to create strategy: {}", e.getMessage());
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping
    public ResponseEntity<List<ExperimentalStrategy>> getAllStrategies() {
        log.info("Admin retrieving all active experimental strategies");
        
        List<ExperimentalStrategy> strategies = experimentalStrategyService.getAllActiveStrategies();
        return ResponseEntity.ok(strategies);
    }

    @GetMapping("/{strategyId}")
    public ResponseEntity<ExperimentalStrategy> getStrategyById(@PathVariable UUID strategyId) {
        log.info("Admin retrieving experimental strategy: {}", strategyId);
        
        return experimentalStrategyService.getStrategyById(strategyId)
            .map(ResponseEntity::ok)
            .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/{strategyId}/with-rules")
    public ResponseEntity<ExperimentalStrategy> getStrategyWithRules(@PathVariable UUID strategyId) {
        log.info("Admin retrieving experimental strategy with rules: {}", strategyId);
        
        return experimentalStrategyService.getStrategyWithRules(strategyId)
            .map(ResponseEntity::ok)
            .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/{strategyId}")
    public ResponseEntity<ExperimentalStrategy> updateStrategy(
            @PathVariable UUID strategyId,
            @RequestBody ExperimentalStrategy updatedStrategy) {
        log.info("Admin updating experimental strategy: {}", strategyId);
        
        try {
            ExperimentalStrategy strategy = experimentalStrategyService.updateStrategy(strategyId, updatedStrategy);
            return ResponseEntity.ok(strategy);
        } catch (IllegalArgumentException e) {
            log.warn("Failed to update strategy: {}", e.getMessage());
            return ResponseEntity.badRequest().build();
        }
    }

    @DeleteMapping("/{strategyId}")
    public ResponseEntity<Void> deactivateStrategy(@PathVariable UUID strategyId) {
        log.info("Admin deactivating experimental strategy: {}", strategyId);
        
        try {
            boolean deactivated = experimentalStrategyService.deactivateStrategy(strategyId);
            if (deactivated) {
                return ResponseEntity.noContent().build();
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (IllegalArgumentException e) {
            log.warn("Failed to deactivate strategy: {}", e.getMessage());
            return ResponseEntity.badRequest().build();
        }
    }

    // ==================== USER ASSIGNMENT MANAGEMENT ====================

    @PostMapping("/{strategyId}/assign-user/{userId}")
    public ResponseEntity<UserExperimentalAssignment> assignUserToStrategy(
            @PathVariable UUID strategyId,
            @PathVariable UUID userId,
            @RequestParam(required = false) UUID assignedBy) {
        log.info("Admin assigning user {} to strategy {}", userId, strategyId);
        
        try {
            UserExperimentalAssignment assignment = userAssignmentService.assignUserToStrategy(userId, strategyId, assignedBy);
            return ResponseEntity.status(HttpStatus.CREATED).body(assignment);
        } catch (IllegalArgumentException e) {
            log.warn("Failed to assign user to strategy: {}", e.getMessage());
            return ResponseEntity.badRequest().build();
        }
    }

    @PutMapping("/users/{userId}/change-strategy/{newStrategyId}")
    public ResponseEntity<UserExperimentalAssignment> changeUserStrategy(
            @PathVariable UUID userId,
            @PathVariable UUID newStrategyId,
            @RequestParam(required = false) UUID assignedBy) {
        log.info("Admin changing user {} strategy to {}", userId, newStrategyId);
        
        try {
            UserExperimentalAssignment assignment = userAssignmentService.changeUserStrategy(userId, newStrategyId, assignedBy);
            return ResponseEntity.ok(assignment);
        } catch (IllegalArgumentException e) {
            log.warn("Failed to change user strategy: {}", e.getMessage());
            return ResponseEntity.badRequest().build();
        }
    }

    @DeleteMapping("/users/{userId}/assignment")
    public ResponseEntity<Void> removeUserAssignment(@PathVariable UUID userId) {
        log.info("Admin removing strategy assignment for user: {}", userId);
        
        boolean removed = userAssignmentService.removeUserAssignment(userId);
        if (removed) {
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/users/{userId}/assignment")
    public ResponseEntity<UserExperimentalAssignment> getUserAssignment(@PathVariable UUID userId) {
        log.info("Admin retrieving strategy assignment for user: {}", userId);
        
        return userAssignmentService.getUserAssignment(userId)
            .map(ResponseEntity::ok)
            .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/{strategyId}/users")
    public ResponseEntity<List<UserExperimentalAssignment>> getUsersInStrategy(@PathVariable UUID strategyId) {
        log.info("Admin retrieving users in strategy: {}", strategyId);
        
        List<UserExperimentalAssignment> users = userAssignmentService.getUsersInStrategy(strategyId);
        return ResponseEntity.ok(users);
    }

    @GetMapping("/{strategyId}/user-count")
    public ResponseEntity<Long> getUsersCountInStrategy(@PathVariable UUID strategyId) {
        log.info("Admin retrieving user count in strategy: {}", strategyId);
        
        long count = userAssignmentService.countUsersInStrategy(strategyId);
        return ResponseEntity.ok(count);
    }

    // ==================== UTILITY ENDPOINTS ====================

    @GetMapping("/default/control")
    public ResponseEntity<ExperimentalStrategy> getDefaultControlStrategy() {
        log.info("Admin retrieving default control strategy");
        
        return experimentalStrategyService.getDefaultControlStrategy()
            .map(ResponseEntity::ok)
            .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/users/{userId}/ensure-assignment")
    public ResponseEntity<UserExperimentalAssignment> ensureUserHasStrategy(@PathVariable UUID userId) {
        log.info("Admin ensuring user {} has a strategy assignment", userId);
        
        try {
            UserExperimentalAssignment assignment = userAssignmentService.ensureUserHasStrategy(userId);
            return ResponseEntity.ok(assignment);
        } catch (RuntimeException e) {
            log.error("Failed to ensure user strategy assignment: {}", e.getMessage());
            return ResponseEntity.internalServerError().build();
        }
    }
}
