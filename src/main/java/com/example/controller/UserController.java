package com.example.controller;

import com.example.pojo.User;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/users") // 设定统一的请求路径
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/{id}") // 根据用户 ID 获取用户
    public ResponseEntity<User> getUserById(@PathVariable Long id) {
        User user = userService.getUserById(id);
        if (user != null) {
            return ResponseEntity.ok(user); // 返回 200 OK
        } else {
            return ResponseEntity.notFound().build(); // 返回 404 Not Found
        }
    }

    @GetMapping("/roleId/{roleId}") // 根据用户名获取用户
    public ResponseEntity<List<User>> selectByRoleId(@PathVariable Integer roleId) {
        List<User> user = userService.selectByRoleId(roleId);
        if (user != null) {
            return ResponseEntity.ok(user); // 返回 200 OK
        } else {
            return ResponseEntity.notFound().build(); // 返回 404 Not Found
        }
    }

    @GetMapping("/username/{username}") // 根据用户名获取用户
    public ResponseEntity<User> getUserByUsername(@PathVariable String username) {
        User user = userService.getUserByUsername(username);
        if (user != null) {
            return ResponseEntity.ok(user); // 返回 200 OK
        } else {
            return ResponseEntity.notFound().build(); // 返回 404 Not Found
        }
    }

    @GetMapping // 获取所有用户
    public ResponseEntity<List<User>> getAllUsers() {
        List<User> users = userService.getAllUsers();
        return ResponseEntity.ok(users); // 返回 200 OK 和用户列表
    }

    @PostMapping // 添加用户
    public ResponseEntity<User> addUser(@RequestBody User user) {
        // 在这里可以进行基础验证，比如用户名不能为空
        userService.addUser(user);
        return ResponseEntity.status(201).body(user); // 返回 201 Created 和新增的用户信息
    }

    @PutMapping("/{id}") // 更新用户信息
    public ResponseEntity<User> updateUser(@PathVariable Long id, @RequestBody User user) {
        user.setUserId(Math.toIntExact(id)); // 确保更新时 ID 一致
        userService.updateUser(user);
        return ResponseEntity.ok(user); // 返回 200 OK
    }

    @DeleteMapping("/{id}") // 根据用户 ID 删除用户
    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
        userService.deleteUser(id);
        return ResponseEntity.noContent().build(); // 返回 204 No Content
    }

    @PostMapping("/login") // 登录接口
    public ResponseEntity<User> login(@RequestParam String username, @RequestParam String password) {
        User user = userService.login(username, password);
        if (user != null) {
            return ResponseEntity.ok(user); // 登录成功
        } else {
            return ResponseEntity.status(401).body(null); // 返回 401 Unauthorized
        }
    }

    @PostMapping("/reset-password") // 重置密码
    public ResponseEntity<Void> resetPassword(@RequestParam String username, @RequestParam String newPassword) {
        userService.resetPassword(username, newPassword);
        return ResponseEntity.noContent().build(); // 返回 204 No Content
    }
}
