package org.intellics.backend.services.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.intellics.backend.services.MasteryDecayService;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class MasteryDecayServiceImpl implements MasteryDecayService {

    private final JdbcTemplate jdbcTemplate;

    // Decay rate per day (e.g., 0.05 means ~5% loss per day initially)
    private static final double DECAY_RATE_DAILY = 0.05;
    
    // Grace period before decay starts (in days)
    private static final int DECAY_GRACE_PERIOD_DAYS = 6;
    
    // Dampening factor for propagation (neighbors decay less)
    private static final double PROPAGATION_DAMPENING = 0.5;
    
    // Max depth for BFS
    private static final int MAX_DEPTH = 2;

    @Override
    @Transactional
    public void applyDecay(UUID userId, UUID lessonId, UUID moduleId) {
        log.debug("Applying mastery decay for user {} (lesson: {}, module: {})", userId, lessonId, moduleId);

        // 1. Identify Seed KCs
        Set<UUID> seedKCs = getSeedKCs(lessonId, moduleId);
        if (seedKCs.isEmpty()) {
            log.debug("No KCs found for context, skipping decay.");
            return;
        }

        // 2. BFS to find affected KCs and calculate decay factors
        Map<UUID, Double> kcDecayMap = new HashMap<>(); // KC -> Effective Decay Multiplier (0.0 to 1.0)
        Queue<KcNode> queue = new LinkedList<>();
        Set<UUID> visited = new HashSet<>();

        // Initialize seeds
        for (UUID kcId : seedKCs) {
            queue.add(new KcNode(kcId, 1.0, 0));
            visited.add(kcId);
        }

        while (!queue.isEmpty()) {
            KcNode current = queue.poll();
            kcDecayMap.put(current.id, current.impactFactor);

            if (current.depth >= MAX_DEPTH) continue;

            // Find neighbors (Prerequisites and Dependents)
            Set<UUID> neighbors = getNeighbors(current.id);
            
            for (UUID neighborId : neighbors) {
                if (!visited.contains(neighborId)) {
                    visited.add(neighborId);
                    // Dampen the impact for neighbors
                    double newImpact = current.impactFactor * PROPAGATION_DAMPENING;
                    queue.add(new KcNode(neighborId, newImpact, current.depth + 1));
                }
            }
        }

        log.debug("Found {} KCs to check for decay", kcDecayMap.size());

        // 3. Fetch current mastery, calculate decay, and update
        updateMasteryValues(userId, kcDecayMap);
    }

    private Set<UUID> getSeedKCs(UUID lessonId, UUID moduleId) {
        Set<UUID> kcs = new HashSet<>();
        if (lessonId != null) {
            jdbcTemplate.query(
                "SELECT kc_id FROM lesson_kc_mapping WHERE lesson_id = ?",
                rs -> { kcs.add(UUID.fromString(rs.getString("kc_id"))); },
                lessonId
            );
        } else if (moduleId != null) {
            jdbcTemplate.query(
                "SELECT kc_id FROM module_kc_mapping WHERE module_id = ?",
                rs -> { kcs.add(UUID.fromString(rs.getString("kc_id"))); },
                moduleId
            );
        }
        return kcs;
    }

    private Set<UUID> getNeighbors(UUID kcId) {
        Set<UUID> neighbors = new HashSet<>();
        
        // Get Prerequisites (Backward)
        jdbcTemplate.query(
            "SELECT prerequisite_kc_id FROM module_kc_prerequisite WHERE kc_id = ?",
            rs -> { neighbors.add(UUID.fromString(rs.getString("prerequisite_kc_id"))); },
            kcId
        );
        
        // Get Dependents (Forward)
        jdbcTemplate.query(
            "SELECT kc_id FROM module_kc_prerequisite WHERE prerequisite_kc_id = ?",
            rs -> { neighbors.add(UUID.fromString(rs.getString("kc_id"))); },
            kcId
        );
        
        return neighbors;
    }

    private void updateMasteryValues(UUID userId, Map<UUID, Double> kcDecayMap) {
        if (kcDecayMap.isEmpty()) return;

        // Construct IDs for IN clause
        StringBuilder idList = new StringBuilder();
        List<Object> params = new ArrayList<>();
        params.add(userId);
        params.add(userId); // For the subquery
        
        int i = 0;
        for (UUID id : kcDecayMap.keySet()) {
            if (i > 0) idList.append(",");
            idList.append("?");
            params.add(id);
            i++;
        }

        // Subquery approach: Get the last "active" interaction for each KC
        // Active interactions: attempts, answers, etc. which imply learning engagement
        String sql = """
            SELECT ukm.kc_id, ukm.p_mastery, 
                   COALESCE(act.last_activity, ukm.updated_at) as last_activity
            FROM user_kc_mastery ukm
            LEFT JOIN (
                SELECT ikm.kc_id, MAX(ui.timestamp) as last_activity
                FROM user_interactions ui
                JOIN interaction_kc_mapping ikm ON ui.interaction_id = ikm.interaction_id
                WHERE ui.user_id = ? 
                  AND ui.interaction_type IN ('QUESTION_ATTEMPTED', 'SCAFFOLD_ATTEMPTED', 'SCAFFOLD_ANSWER')
                GROUP BY ikm.kc_id
            ) act ON ukm.kc_id = act.kc_id
            WHERE ukm.user_id = ? AND ukm.kc_id IN (%s)
            """.formatted(idList.toString());
        
        jdbcTemplate.query(sql, rs -> {
            UUID kcId = UUID.fromString(rs.getString("kc_id"));
            double currentMastery = rs.getDouble("p_mastery");
            Timestamp lastActivity = rs.getTimestamp("last_activity");
            
            // Only decay if mastery > 0.1
            if (currentMastery > 0.1) {
                Instant lastUpdate = lastActivity != null ? lastActivity.toInstant() : Instant.now().minus(30, ChronoUnit.DAYS);
                long daysElapsed = ChronoUnit.DAYS.between(lastUpdate, Instant.now());
                
                // Only decay if inactivity exceeds grace period
                if (daysElapsed >= DECAY_GRACE_PERIOD_DAYS) {
                    long effectiveDecayDays = daysElapsed - (DECAY_GRACE_PERIOD_DAYS - 1);
                    double impactFactor = kcDecayMap.getOrDefault(kcId, 1.0);
                    
                    // NewMastery = OldMastery * exp( - (BaseRate * Impact) * EffectiveDecayDays )
                    double effectiveRate = DECAY_RATE_DAILY * impactFactor;
                    double decayMultiplier = Math.exp(-effectiveRate * effectiveDecayDays);
                    
                    double newMastery = currentMastery * decayMultiplier;
                    
                    // Threshold: Don't drop below 0.1
                    newMastery = Math.max(0.1, newMastery);
                    
                    if (newMastery < currentMastery) {
                        updateKcMastery(userId, kcId, newMastery);
                        log.debug("Decaying mastery for user {} KC {}: {} -> {} ({} days inactive based on interaction history)", 
                            userId, kcId, currentMastery, newMastery, daysElapsed);
                    }
                }
            }
        }, params.toArray());
    }

    private void updateKcMastery(UUID userId, UUID kcId, double newMastery) {
        // We do NOT update 'updated_at' here, because this is a passive decay, not an active practice.
        // If we updated 'updated_at', it would reset the timer and prevent further decay!
        jdbcTemplate.update(
            "UPDATE user_kc_mastery SET p_mastery = ? WHERE user_id = ? AND kc_id = ?",
            newMastery, userId, kcId
        );
        log.trace("Decayed mastery for user {} KC {} to {}", userId, kcId, newMastery);
    }

    private record KcNode(UUID id, double impactFactor, int depth) {}
}
