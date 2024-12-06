package com.fullstack.backend.repositories;



import com.fullstack.backend.enumeration.EventType;
import com.fullstack.backend.models.UserEvent;

import java.util.Collection;


public interface EventRepository {
    Collection<UserEvent> getEventsByUserId(Long userId);
    void addUserEvent(String email, EventType eventType, String device, String ipAddress);
    void addUserEvent(Long userId, EventType eventType, String device, String ipAddress);
}
