package com.fullstack.backend.utils;


import com.fullstack.backend.dto.UserDTO;
import com.fullstack.backend.models.UserPrincipal;
import org.springframework.security.core.Authentication;


public class UserUtils {
    public static UserDTO getAuthenticatedUser(Authentication authentication) {
        return ((UserDTO) authentication.getPrincipal());
    }

    public static UserDTO getLoggedInUser(Authentication authentication) {
        return ((UserPrincipal) authentication.getPrincipal()).getUser();
    }
}
