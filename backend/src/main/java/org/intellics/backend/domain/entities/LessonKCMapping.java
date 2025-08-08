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

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "lesson_kc_mapping")
public class LessonKCMapping {
    @EmbeddedId
    private LessonKCMappingId mapping_id;
    private BigDecimal target_mastery;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("lesson_id")
    @JoinColumn(name = "lesson_id")
    private Lesson lesson;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("kc_id")
    @JoinColumn(name = "kc_id")
    private KnowledgeComponent knowledge_component;
}
