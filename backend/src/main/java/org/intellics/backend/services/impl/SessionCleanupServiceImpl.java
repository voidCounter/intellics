package org.intellics.backend.services.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.intellics.backend.domain.entities.Session;
import org.intellics.backend.repositories.SessionRepository;
import org.intellics.backend.services.SessionCleanupService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.annotation.PostConstruct;
import java.time.Duration;
import java.time.Instant;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class SessionCleanupServiceImpl implements SessionCleanupService {

    private final SessionRepository sessionRepository;
    private final TaskScheduler taskScheduler;
    
    @Value("${app.session.cleanup.intervalMinutes}")
    private double intervalMinutes;
    
    @Value("${app.session.cleanup.inactivityThresholdMinutes}")
    private double inactivityThresholdMinutes;
    
    @Value("${app.session.cleanup.endTimeOffsetMinutes}")
    private double endTimeOffsetMinutes;

    @PostConstruct
    public void scheduleCleanup() {
        // Convert minutes to milliseconds for scheduling
        long intervalMs = (long)(intervalMinutes * 60 * 1000);
        Duration interval = Duration.ofMillis(intervalMs);
        
        log.info("Scheduling session cleanup every {} minutes ({} ms)", intervalMinutes, intervalMs);
        
        // Schedule the cleanup task to run at fixed intervals
        taskScheduler.scheduleAtFixedRate(
            this::cleanupInactiveSessions,
            Instant.now().plus(interval), // Start after first interval
            interval
        );
    }

    @Override
    @Transactional
    public void cleanupInactiveSessions() {
        try {
            Instant cutoffTime = Instant.now().minusSeconds((long)(inactivityThresholdMinutes * 60));
            
            // Find all active sessions that haven't been active for threshold minutes
            List<Session> inactiveSessions = sessionRepository.findActiveSessionsByLastActiveBefore(cutoffTime);
            
            if (inactiveSessions.isEmpty()) {
                log.debug("No inactive sessions found for cleanup");
                return;
            }
            
            log.info("Found {} inactive sessions, ending them...", inactiveSessions.size());
            
            for (Session session : inactiveSessions) {
                // Simple mutex approach - synchronize on the session ID
                synchronized (session.getSession_id().toString().intern()) {
                    try {
                        // Double-check that session is still active before ending it
                        if (session.getEnd_time() != null) {
                            log.debug("Session {} already ended, skipping", session.getSession_id());
                            continue;
                        }
                        
                        // Set end time to last_active_at + offset for accurate duration tracking
                        Instant endTime = session.getLast_active_at().plusSeconds((long)(endTimeOffsetMinutes * 60));
                        session.setEnd_time(endTime);
                        
                        // Save the session
                        sessionRepository.save(session);
                        
                        log.debug("Ended inactive session {} (last active: {}, end time: {})", 
                            session.getSession_id(), session.getLast_active_at(), endTime);
                            
                    } catch (Exception e) {
                        log.warn("Error ending session {}: {}", session.getSession_id(), e.getMessage());
                    }
                }
            }
            
            log.info("Session cleanup completed");
            
        } catch (Exception e) {
            log.error("Error during session cleanup: {}", e.getMessage(), e);
        }
    }

    @Override
    public long getInactiveSessionCount() {
        try {
            Instant cutoffTime = Instant.now().minusSeconds((long)(inactivityThresholdMinutes * 60));
            return sessionRepository.countActiveSessionsByLastActiveBefore(cutoffTime);
        } catch (Exception e) {
            log.error("Error counting inactive sessions: {}", e.getMessage(), e);
            return 0;
        }
    }
}
