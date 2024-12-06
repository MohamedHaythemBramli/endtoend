package com.fullstack.backend.service.implementation;


import com.fullstack.backend.models.Role;
import com.fullstack.backend.repositories.RoleRepository;
import com.fullstack.backend.service.RoleService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Collection;


@Service
@RequiredArgsConstructor
public class RoleServiceImpl implements RoleService {
    private final RoleRepository<Role> roleRoleRepository;

    @Override
    public Role getRoleByUserId(Long id) {
        return roleRoleRepository.getRoleByUserId(id);
    }

    @Override
    public Collection<Role> getRoles() {
        return roleRoleRepository.list();
    }
}
