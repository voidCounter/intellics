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

import java.math.BigDecimal;
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
@Table(name = "user_interactions")
@EntityListeners(AuditingEntityListener.class)
public class UserInteraction {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID interaction_id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "session_id", nullable = false)
    private Session session;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    
    @Enumerated(EnumType.STRING)
    private InteractionType interactionType;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lesson_id", nullable = true)
    private Lesson lesson;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_id", nullable = true)
    private QuestionEntity question;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "scaffold_id", nullable = true)
    private Scaffold scaffold;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "module_id", nullable = true)
    private Module module;
    
    private String student_answer;
    private boolean is_correct;
    private int hint_level;
    private int time_spent_seconds;
    
    // AI evaluation results
    private BigDecimal answer_correctness; // 0.0 to 1.0 score from AI
    private String answer_analysis; // Detailed AI feedback and analysis
    
    @CreatedDate
    private Instant timestamp;
}
