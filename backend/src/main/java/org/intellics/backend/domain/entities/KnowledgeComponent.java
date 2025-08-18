package org.intellics.backend.domain.entities;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EntityListeners;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "knowledge_components")
@EntityListeners(AuditingEntityListener.class)
public class KnowledgeComponent {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID kc_id;
    private String kc_name;
    private String description;
    
    @Column(name = "is_active", nullable = false)
    private Boolean isActive = true;
    
    @CreatedDate
    @Column(name = "created_at", nullable = false, updatable = false)
    private Instant created_at;
    
    @LastModifiedDate
    @Column(name = "updated_at")
    private Instant updated_at;
    
    @OneToMany(mappedBy = "knowledge_component", fetch = FetchType.LAZY, cascade = CascadeType.ALL
        , orphanRemoval = true)
    private List<QuestionKCMapping> questionKCMappings;
    
    @OneToMany(mappedBy = "knowledge_component", fetch = FetchType.LAZY, cascade =
        CascadeType.ALL, orphanRemoval = true)
    private List<LessonKCMapping> lessonKCMappings;
    
    @OneToMany(mappedBy = "knowledgeComponent", fetch = FetchType.LAZY, cascade = CascadeType.ALL,
        orphanRemoval = true)
    private List<ModuleKCMapping> moduleKCMappings;
    
    @OneToMany(mappedBy = "knowledgeComponent", fetch = FetchType.LAZY, cascade = CascadeType.ALL,
        orphanRemoval = true)
    private List<StudentKCMastery> studentKCMasteries;
}
