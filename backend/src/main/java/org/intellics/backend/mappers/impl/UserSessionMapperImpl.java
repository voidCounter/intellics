package org.intellics.backend.mappers.impl;

import org.intellics.backend.domain.dto.UserSessionDto;
import org.intellics.backend.domain.entities.Session;
import org.intellics.backend.mappers.UserSessionMapper;
import org.springframework.stereotype.Component;

@Component
public class UserSessionMapperImpl implements UserSessionMapper {
    
    @Override
    public UserSessionDto mapTo(Session session) {
        if (session == null) {
            return null;
        }
        
        return UserSessionDto.builder()
            .sessionId(session.getSession_id())
            .username(session.getUser() != null ? session.getUser().getUsername() : null)
            .userAgent(session.getUser_agent())
            .deviceType(session.getDevice_type())
            .startTime(session.getStart_time())
            .endTime(session.getEnd_time())
            .createdAt(session.getCreated_at())
            .updatedAt(session.getUpdated_at())
            .interactionCount(0L) // TODO: Inject UserInteractionRepository if needed
            .build();
    }
    
    @Override
    public Session mapFrom(UserSessionDto userSessionDto) {
        if (userSessionDto == null) {
            return null;
        }
        
        return Session.builder()
            .session_id(userSessionDto.getSessionId())
            .user_agent(userSessionDto.getUserAgent())
            .device_type(userSessionDto.getDeviceType())
            // Note: startTime and endTime are server-controlled for security
            .build();
    }
}
