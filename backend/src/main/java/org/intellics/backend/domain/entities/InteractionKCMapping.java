package org.intellics.backend.domain.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Entity;
import jakarta.persistence.EntityListeners;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.Instant;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "interaction_kc_mapping")
@EntityListeners(AuditingEntityListener.class)
@IdClass(InteractionKCMappingId.class)
public class InteractionKCMapping {
    
    @Id
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "interaction_id")
    @JsonIgnore
    private UserInteraction interaction;
    
    @Id
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "kc_id")
    private KnowledgeComponent knowledgeComponent;
    
    private double weight;
    private Double kcMasteryBefore;
    private Double kcMasteryAfter;
    
    @CreatedDate
    private Instant created_at;
    
    @LastModifiedDate
    private Instant updated_at;
}
