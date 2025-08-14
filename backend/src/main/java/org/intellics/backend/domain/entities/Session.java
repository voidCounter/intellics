package org.intellics.backend.domain.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EntityListeners;
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
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "sessions")
@EntityListeners(AuditingEntityListener.class)
public class Session {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID session_id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;
    
    @Column(name = "user_agent")
    private String user_agent;
    
    @Column(name = "device_type")
    private String device_type;
    
    @Column(name = "start_time")
    private Instant start_time;
    
    @Column(name = "end_time")
    private Instant end_time;
    
    @Column(name = "last_active_at")
    private Instant last_active_at;
    
    @CreatedDate
    @Column(name = "created_at", nullable = false, updatable = false)
    private Instant created_at;
    
    @LastModifiedDate
    @Column(name = "updated_at")
    private Instant updated_at;
}
