package org.intellics.backend.domain.entities;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.util.List;
import java.util.UUID;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "knowledge_components")
public class KnowledgeComponent {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID kc_id;
    private String kc_name;
    private String description;
    
    @OneToMany(mappedBy = "knowledge_component", fetch = FetchType.LAZY, cascade = CascadeType.ALL
        , orphanRemoval = true)
    private List<QuestionKCMapping> questionKCMappings;
    
    @OneToMany(mappedBy = "knowledge_component", fetch = FetchType.LAZY, cascade =
        CascadeType.ALL, orphanRemoval = true)
    private List<LessonKCMapping> lessonKCMappings;
    
    @OneToMany(mappedBy = "knowledgeComponent", fetch = FetchType.LAZY, cascade = CascadeType.ALL,
        orphanRemoval = true)
    private List<StudentKCMastery> studentKCMasteries;
}
