package org.intellics.backend.domain.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "module_kc_prerequisite")
public class ModuleKCPrerequisite {
    @EmbeddedId
    private ModuleKCPrerequisiteId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "module_id", insertable = false, updatable = false)
    private Module module;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "kc_id", insertable = false, updatable = false)
    private KnowledgeComponent knowledgeComponent;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "prerequisite_kc_id", insertable = false, updatable = false)
    private KnowledgeComponent prerequisiteKnowledgeComponent;

    @Column(name = "rationale", columnDefinition = "TEXT")
    private String rationale;
}
