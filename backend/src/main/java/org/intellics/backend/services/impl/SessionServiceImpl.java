package org.intellics.backend.services.impl;

import java.time.Instant;
import java.util.UUID;

import org.intellics.backend.api.error.exceptions.ItemNotFoundException;
import org.intellics.backend.domain.dto.SessionCreateDto;
import org.intellics.backend.domain.dto.SessionDto;
import org.intellics.backend.domain.dto.UserSessionDto;
import org.intellics.backend.domain.entities.Session;
import org.intellics.backend.domain.entities.User;
import org.intellics.backend.mappers.SessionMapper;
import org.intellics.backend.mappers.UserSessionMapper;
import org.intellics.backend.repositories.SessionRepository;
import org.intellics.backend.repositories.UserRepository;
import org.intellics.backend.services.SessionService;
import org.intellics.backend.specifications.SessionSpecification;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
@Slf4j
public class SessionServiceImpl implements SessionService {

    private final SessionRepository sessionRepository;
    private final UserRepository userRepository;
    private final SessionMapper sessionMapper;
    private final UserSessionMapper userSessionMapper;

    @Override
    @Transactional
    public SessionDto createSessionForCurrentUser(UUID currentUserId, SessionCreateDto sessionCreateDto) {
        User user = userRepository.findById(currentUserId)
            .orElseThrow(() -> new ItemNotFoundException("User not found"));
        
        Session session = Session.builder()
            .user(user)
            .user_agent(sessionCreateDto.getUserAgent())
            .device_type(sessionCreateDto.getDeviceType())
            .start_time(Instant.now()) // Use server time for security
            .end_time(null) // Session starts as active
            .last_active_at(Instant.now()) // Initialize last active time
            .build();
        
        Session savedSession = sessionRepository.save(session);
        return sessionMapper.mapTo(savedSession);
    }

    @Override
    @Transactional
    public SessionDto getOrCreateSessionForCurrentUser(UUID currentUserId, SessionCreateDto sessionCreateDto) {
        User user = userRepository.findById(currentUserId)
            .orElseThrow(() -> new ItemNotFoundException("User not found"));
        
        // Define what constitutes an "active" session
        Instant cutoffTime = Instant.now().minusSeconds(90); // 90 seconds ago
        
        // Query for existing active session for this user, device, and user agent
        // We require EXACT match of both device type and user agent to reuse a session
        Session existingSession = sessionRepository.findByUserIdAndDeviceTypeAndUserAgentAndEndTimeIsNullAndLastActiveAtAfter(
            currentUserId, 
            sessionCreateDto.getDeviceType(),
            sessionCreateDto.getUserAgent(),
            cutoffTime
        );
        
        if (existingSession != null) {
            // Found active session with exact same device type and user agent, update last_active_at and return it
            existingSession.setLast_active_at(Instant.now());
            Session updatedSession = sessionRepository.save(existingSession);
            log.debug("Reusing existing session {} for user {} on device type {} with user agent {}", 
                existingSession.getSession_id(), currentUserId, sessionCreateDto.getDeviceType(), sessionCreateDto.getUserAgent());
            return sessionMapper.mapTo(updatedSession);
        }
        
        // No active session found with exact same device type and user agent, create new one
        // This allows users to have multiple active sessions on different devices/browsers
        Session newSession = Session.builder()
            .user(user)
            .user_agent(sessionCreateDto.getUserAgent())
            .device_type(sessionCreateDto.getDeviceType())
            .start_time(Instant.now())
            .end_time(null)
            .last_active_at(Instant.now())
            .build();
        
        Session savedSession = sessionRepository.save(newSession);
        log.info("Created new session {} for user {} on device type {} with user agent {}", 
            savedSession.getSession_id(), currentUserId, sessionCreateDto.getDeviceType(), sessionCreateDto.getUserAgent());
        return sessionMapper.mapTo(savedSession);
    }

    @Override
    public SessionDto getSessionById(UUID sessionId) {
        Session session = sessionRepository.findById(sessionId)
            .orElseThrow(() -> new ItemNotFoundException("Session not found"));
        return sessionMapper.mapTo(session);
    }

    @Override
    public Page<SessionDto> getSessionsWithFilters(
            UUID userId,
            String deviceType,
            Instant startTimeAfter,
            Instant startTimeBefore,
            Instant endTimeAfter,
            Instant endTimeBefore,
            Boolean isActive,
            Pageable pageable) {
        
        // Build specification by combining all filters
        Specification<Session> spec = Specification.where(SessionSpecification.hasUserId(userId))
            .and(SessionSpecification.hasDeviceType(deviceType))
            .and(SessionSpecification.startTimeAfter(startTimeAfter))
            .and(SessionSpecification.startTimeBefore(startTimeBefore))
            .and(SessionSpecification.endTimeAfter(endTimeAfter))
            .and(SessionSpecification.endTimeBefore(endTimeBefore))
            .and(SessionSpecification.isActive(isActive));
        
        // Execute query with specification and pagination
        Page<Session> sessions = sessionRepository.findAll(spec, pageable);
        return sessions.map(sessionMapper::mapTo);
    }

    @Override
    public Page<UserSessionDto> getSessionsByUserIdWithFilters(
            UUID userId,
            String deviceType,
            Instant startTimeAfter,
            Instant startTimeBefore,
            Instant endTimeAfter,
            Instant endTimeBefore,
            Boolean isActive,
            Pageable pageable) {
        
        // Build specification by combining user ID with other filters
        Specification<Session> spec = SessionSpecification.hasUserId(userId);
        
        if (deviceType != null) {
            spec = spec.and(SessionSpecification.hasDeviceType(deviceType));
        }
        if (startTimeAfter != null) {
            spec = spec.and(SessionSpecification.startTimeAfter(startTimeAfter));
        }
        if (startTimeBefore != null) {
            spec = spec.and(SessionSpecification.startTimeBefore(startTimeBefore));
        }
        if (endTimeAfter != null) {
            spec = spec.and(SessionSpecification.endTimeAfter(endTimeAfter));
        }
        if (endTimeBefore != null) {
            spec = spec.and(SessionSpecification.endTimeBefore(endTimeBefore));
        }
        if (isActive != null) {
            spec = spec.and(SessionSpecification.isActive(isActive));
        }
        
        // Execute query with specification and pagination
        Page<Session> sessions = sessionRepository.findAll(spec, pageable);
        return sessions.map(userSessionMapper::mapTo);
    }

    @Override
    @Transactional
    public SessionDto updateSessionHeartbeat(UUID sessionId) {
        // Simple mutex approach - synchronize on the session ID
        synchronized (sessionId.toString().intern()) {
            Session session = sessionRepository.findById(sessionId)
                .orElseThrow(() -> new ItemNotFoundException("Session not found"));
            
            // Check if session has ended
            if (session.getEnd_time() != null) {
                throw new ItemNotFoundException("Session has ended");
            }
            
            // Update last active time to current server time
            session.setLast_active_at(Instant.now());
            
            Session updatedSession = sessionRepository.save(session);
            return sessionMapper.mapTo(updatedSession);
        }
    }



    @Override
    @Transactional
    public void deleteSession(UUID sessionId) {
        if (!sessionRepository.existsById(sessionId)) {
            throw new ItemNotFoundException("Session not found");
        }
        sessionRepository.deleteById(sessionId);
    }

    @Override
    @Transactional
    public void endSessionForCurrentUser(UUID sessionId) {
        Session session = sessionRepository.findById(sessionId)
            .orElseThrow(() -> new ItemNotFoundException("Session not found"));
        
        // Set end time to current time
        session.setEnd_time(Instant.now());
        sessionRepository.save(session);
    }
}
