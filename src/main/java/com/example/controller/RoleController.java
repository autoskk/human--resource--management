package com.example.controller;

import com.example.pojo.Role;
import com.example.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/roles") // 设定统一的请求路径
public class RoleController {

    @Autowired
    private RoleService roleService;

    @GetMapping("/{roleId}") // 根据角色 ID 获取角色
    public ResponseEntity<Role> getRoleById(@PathVariable Long roleId) {
        Role role = roleService.getRoleById(roleId);
        if (role != null) {
            return ResponseEntity.ok(role); // 返回 200 OK
        } else {
            return ResponseEntity.notFound().build(); // 返回 404 Not Found
        }
    }

    @GetMapping("/name/{roleName}") // 根据角色名获取角色
    public ResponseEntity<Role> getRoleByName(@PathVariable String roleName) {
        Role role = roleService.getRoleByName(roleName);
        if (role != null) {
            return ResponseEntity.ok(role); // 返回 200 OK
        } else {
            return ResponseEntity.notFound().build(); // 返回 404 Not Found
        }
    }

    @GetMapping // 获取所有角色
    public ResponseEntity<List<Role>> getAllRoles() {
        List<Role> roles = roleService.getAllRoles();
        return ResponseEntity.ok(roles); // 返回 200 OK 和角色列表
    }

    @PostMapping // 添加角色
    public ResponseEntity<Role> addRole(@RequestBody Role role) {
        roleService.addRole(role);
        return ResponseEntity.status(201).body(role); // 返回 201 Created 和新增的角色信息
    }

    @PutMapping("/{roleId}") // 更新角色
    public ResponseEntity<Role> updateRole(@PathVariable Long roleId, @RequestBody Role role) {
        role.setRoleID(Math.toIntExact(roleId)); // 确保更新时 ID 一致
        roleService.updateRole(role);
        return ResponseEntity.ok(role); // 返回 200 OK
    }

    @DeleteMapping("/{roleId}") // 根据角色 ID 删除角色
    public ResponseEntity<Void> deleteRole(@PathVariable Long roleId) {
        roleService.deleteRole(roleId);
        return ResponseEntity.noContent().build(); // 返回 204 No Content
    }
}
