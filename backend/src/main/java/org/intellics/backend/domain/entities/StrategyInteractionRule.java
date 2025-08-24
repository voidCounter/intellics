package org.intellics.backend.domain.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.Instant;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "strategy_interaction_rules")
@EntityListeners(AuditingEntityListener.class)
public class StrategyInteractionRule {
    
    @EmbeddedId
    private StrategyInteractionRuleId id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("strategyId")
    @JoinColumn(name = "strategy_id", nullable = false)
    private ExperimentalStrategy strategy;
    
    @Column(name = "mastery_update_weight", nullable = false)
    @Builder.Default
    private Double masteryUpdateWeight = 1.0;
    
    @Column(name = "is_required", nullable = false)
    @Builder.Default
    private Boolean isRequired = false;
    
    @CreatedDate
    @Column(name = "created_at", nullable = false, updatable = false)
    private Instant createdAt;
    
    @LastModifiedDate
    @Column(name = "updated_at", nullable = false)
    private Instant updatedAt;
}
