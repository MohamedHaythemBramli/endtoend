package com.fullstack.backend.service;



import com.fullstack.backend.enumeration.EventType;
import com.fullstack.backend.models.UserEvent;

import java.util.Collection;


public interface EventService {
    Collection<UserEvent> getEventsByUserId(Long userId);
    void addUserEvent(String email, EventType eventType, String device, String ipAddress);
    void addUserEvent(Long userId, EventType eventType, String device, String ipAddress);
}
