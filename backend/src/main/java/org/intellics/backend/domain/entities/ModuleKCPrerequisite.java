package org.intellics.backend.domain.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "module_kc_prerequisite")
public class ModuleKCPrerequisite {
    @EmbeddedId
    private ModuleKCPrerequisiteId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("moduleId")
    @JoinColumn(name = "module_id")
    private Module module;

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    @MapsId("kcId")
    @JoinColumn(name = "kc_id")
    private KnowledgeComponent knowledgeComponent;

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    @MapsId("prerequisiteKcId")
    @JoinColumn(name = "prerequisite_kc_id")
    private KnowledgeComponent prerequisiteKnowledgeComponent;
}
