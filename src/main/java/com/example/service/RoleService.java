package com.example.service;

import com.example.pojo.Role;

import java.util.List;

public interface RoleService {
    Role getRoleById(Long roleId);
    Role getRoleByName(String roleName);
    List<Role> getAllRoles();
    void addRole(Role role);
    void updateRole(Role role);
    void deleteRole(Long roleId);
}
