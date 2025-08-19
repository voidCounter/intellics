package org.intellics.backend.repositories;

import java.util.List;
import java.util.UUID;

import org.intellics.backend.domain.entities.Session;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface SessionRepository extends JpaRepository<Session, UUID>, JpaSpecificationExecutor<Session> {

    /**
     * Find all sessions for a specific user
     */
    @Query("SELECT s FROM Session s WHERE s.user.user_id = :userId ORDER BY s.start_time DESC")
    List<Session> findByUserId(@Param("userId") UUID userId);
    
    /**
     * Find all active sessions that haven't been active since the given time
     * Used for cleanup of inactive sessions
     */
    @Query("SELECT s FROM Session s WHERE s.end_time IS NULL AND s.last_active_at < :cutoffTime")
    List<Session> findActiveSessionsByLastActiveBefore(@Param("cutoffTime") java.time.Instant cutoffTime);
    
    /**
     * Count active sessions that haven't been active since the given time
     * Used for monitoring inactive session count
     */
    @Query("SELECT COUNT(s) FROM Session s WHERE s.end_time IS NULL AND s.last_active_at < :cutoffTime")
    long countActiveSessionsByLastActiveBefore(@Param("cutoffTime") java.time.Instant cutoffTime);
    
    /**
     * Find active session for a specific user, device type, and user agent
     * Used for get-or-create session logic to prevent duplicates
     */
    @Query("SELECT s FROM Session s WHERE s.user.user_id = :userId AND s.device_type = :deviceType AND s.user_agent = :userAgent AND s.end_time IS NULL AND s.last_active_at > :cutoffTime ORDER BY s.last_active_at DESC LIMIT 1")
    Session findByUserIdAndDeviceTypeAndUserAgentAndEndTimeIsNullAndLastActiveAtAfter(
        @Param("userId") UUID userId, 
        @Param("deviceType") String deviceType, 
        @Param("userAgent") String userAgent,
        @Param("cutoffTime") java.time.Instant cutoffTime
    );
    
    /**
     * Find the most recent active session for a specific user
     * Used for logging interactions when session context is needed
     */
    @Query("SELECT s FROM Session s WHERE s.user.user_id = :userId AND s.end_time IS NULL ORDER BY s.last_active_at DESC LIMIT 1")
    Session findActiveSessionByUserId(@Param("userId") UUID userId);
}
