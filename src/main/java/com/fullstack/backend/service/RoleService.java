package com.fullstack.backend.service;



import com.fullstack.backend.models.Role;

import java.util.Collection;


public interface RoleService {
    Role getRoleByUserId(Long id);
    Collection<Role> getRoles();
}
