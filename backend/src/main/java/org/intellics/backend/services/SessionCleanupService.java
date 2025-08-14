package org.intellics.backend.services;

/**
 * Service for cleaning up inactive sessions
 */
public interface SessionCleanupService {
    
    /**
     * Clean up inactive sessions (sessions not active for 5+ minutes)
     * This method is designed to be called by a scheduled task
     */
    void cleanupInactiveSessions();
    
    /**
     * Get the count of inactive sessions that would be cleaned up
     * Useful for monitoring and debugging
     */
    long getInactiveSessionCount();
}
