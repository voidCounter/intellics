package org.intellics.backend.services.impl;

import lombok.RequiredArgsConstructor;
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

import java.time.Instant;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
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
            .build();
        
        Session savedSession = sessionRepository.save(session);
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
    public SessionDto endSession(UUID sessionId) {
        Session session = sessionRepository.findById(sessionId)
            .orElseThrow(() -> new ItemNotFoundException("Session not found"));
        
        if (session.getEnd_time() != null) {
            throw new IllegalStateException("Session is already ended");
        }
        
        session.setEnd_time(Instant.now());
        Session endedSession = sessionRepository.save(session);
        return sessionMapper.mapTo(endedSession);
    }

    @Override
    @Transactional
    public void deleteSession(UUID sessionId) {
        if (!sessionRepository.existsById(sessionId)) {
            throw new ItemNotFoundException("Session not found");
        }
        sessionRepository.deleteById(sessionId);
    }
}
