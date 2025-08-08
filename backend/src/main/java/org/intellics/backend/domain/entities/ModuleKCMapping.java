package org.intellics.backend.domain.entities;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.HashSet;
import java.util.Set;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "module_kc_mapping")
public class ModuleKCMapping {
    @EmbeddedId
    private ModuleKCMappingId mappingId;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("moduleId")
    @JoinColumn(name = "module_id")
    private Module module;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("kcId")
    @JoinColumn(name = "kc_id")
    private KnowledgeComponent knowledgeComponent;

    @ManyToMany
    @JoinTable(
        name = "module_kc_prerequisite",
        joinColumns = {
            @JoinColumn(name = "module_id", referencedColumnName = "module_id"),
            @JoinColumn(name = "kc_id", referencedColumnName = "kc_id")
        },
        inverseJoinColumns = @JoinColumn(name = "prerequisite_kc_id", referencedColumnName = "kc_id")
    )
    private Set<KnowledgeComponent> prerequisiteKnowledgeComponents = new HashSet<>();
}
