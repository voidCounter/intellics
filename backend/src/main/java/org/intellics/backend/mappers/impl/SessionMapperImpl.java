package org.intellics.backend.mappers.impl;

import org.intellics.backend.domain.dto.SessionDto;
import org.intellics.backend.domain.entities.Session;
import org.intellics.backend.mappers.SessionMapper;
import org.springframework.stereotype.Component;

@Component
public class SessionMapperImpl implements SessionMapper {
    
    @Override
    public SessionDto mapTo(Session session) {
        if (session == null) {
            return null;
        }
        
        return SessionDto.builder()
            .sessionId(session.getSession_id())
            .userId(session.getUser() != null ? session.getUser().getUser_id() : null)
            .username(session.getUser() != null ? session.getUser().getUsername() : null)
            .userAgent(session.getUser_agent())
            .deviceType(session.getDevice_type())
            .startTime(session.getStart_time())
            .endTime(session.getEnd_time())
            .lastActiveAt(session.getLast_active_at())
            .createdAt(session.getCreated_at())
            .updatedAt(session.getUpdated_at())
            .interactionCount(0L) // TODO: Inject UserInteractionRepository if needed
            .build();
    }
    
    @Override
    public Session mapFrom(SessionDto sessionDto) {
        if (sessionDto == null) {
            return null;
        }
        
        return Session.builder()
            .session_id(sessionDto.getSessionId())
            .user_agent(sessionDto.getUserAgent())
            .device_type(sessionDto.getDeviceType())
            // Note: startTime and endTime are server-controlled for security
            .build();
    }
}
