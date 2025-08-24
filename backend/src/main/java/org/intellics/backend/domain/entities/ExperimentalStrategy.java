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
import java.util.List;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "experimental_strategies")
@EntityListeners(AuditingEntityListener.class)
public class ExperimentalStrategy {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "strategy_id")
    private UUID strategyId;
    
    @Column(name = "strategy_name", nullable = false, unique = true)
    private String strategyName;
    
    @Column(name = "description")
    private String description;
    
    @Column(name = "is_active", nullable = false)
    @Builder.Default
    private Boolean isActive = true;
    
    @CreatedDate
    @Column(name = "created_at", nullable = false, updatable = false)
    private Instant createdAt;
    
    @LastModifiedDate
    @Column(name = "updated_at", nullable = false)
    private Instant updatedAt;
    
    // Relationships
    @OneToMany(mappedBy = "strategy", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<StrategyInteractionRule> interactionRules;
    
    @OneToMany(mappedBy = "strategy", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<UserExperimentalAssignment> userAssignments;
}
