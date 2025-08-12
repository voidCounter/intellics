package org.intellics.backend.security;

import lombok.RequiredArgsConstructor;
import org.intellics.backend.repositories.SessionRepository;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class SessionSecurity {

    private final SessionRepository sessionRepository;

    /**
     * Check if the current authenticated user owns the specified session
     * Used in @PreAuthorize annotations
     */
    public boolean isOwner(UUID sessionId) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            return false;
        }
        
        try {
            UUID currentUserId = UUID.fromString(authentication.getName());
            return sessionRepository.findById(sessionId)
                .map(session -> session.getUser().getUser_id().equals(currentUserId))
                .orElse(false);
        } catch (IllegalArgumentException e) {
            return false;
        }
    }
}
