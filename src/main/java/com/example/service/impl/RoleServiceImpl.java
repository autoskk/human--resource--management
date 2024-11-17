package com.example.service.impl;

import com.example.mapper.RoleMapper;
import com.example.pojo.Role;
import com.example.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Override
    public Role getRoleById(Long roleId) {
        return roleMapper.selectById(roleId);
    }

    @Override
    public Role getRoleByName(String roleName) {
        return roleMapper.selectByRoleName(roleName);
    }

    @Override
    public List<Role> getAllRoles() {
        return roleMapper.selectAllRoles(); // 查询所有角色
    }

    @Override
    public void addRole(Role role) {
        roleMapper.insert(role);
    }

    @Override
    public void updateRole(Role role) {
        roleMapper.updateById(role);
    }

    @Override
    public void deleteRole(Long roleId) {
        roleMapper.deleteById(roleId);
    }
}
