package org.intellics.backend.domain.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.EntityListeners;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.time.Instant;
import java.util.UUID;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "student_interactions")
@EntityListeners(AuditingEntityListener.class)
public class StudentInteraction {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID interaction_id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "session_id")
    private Session session;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;
    
    @Enumerated(EnumType.STRING)
    private InteractionType interactionType;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lesson_id")
    private Lesson lesson;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_id")
    private QuestionEntity question;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "scaffold_id")
    private Scaffold scaffold;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "kc_id")
    private KnowledgeComponent knowledgeComponent;
    
    private String student_answer;
    private boolean is_correct;
    private int hint_level;
    private int time_spent_seconds;
    @CreatedDate
    private Instant timestamp;
    private double p_mastery;
}
