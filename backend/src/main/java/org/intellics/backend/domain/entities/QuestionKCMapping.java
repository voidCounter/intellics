package org.intellics.backend.domain.entities;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "question_kc_mapping")
public class QuestionKCMapping {
    @EmbeddedId
    private QuestionKCMappingId mappingId;
    
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_id")
    @MapsId("question_id")
    private QuestionEntity question;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "kc_id")
    @MapsId("kc_id")
    private KnowledgeComponent knowledge_component;
    
    private double weight;
}
