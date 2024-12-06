package com.fullstack.backend.event;


import com.fullstack.backend.enumeration.EventType;
import lombok.Getter;
import lombok.Setter;
import org.springframework.context.ApplicationEvent;


@Getter
@Setter
public class NewUserEvent extends ApplicationEvent {
    private EventType type;
    private String email;

    public NewUserEvent(String email, EventType type) {
        super(email);
        this.type = type;
        this.email = email;
    }
}
