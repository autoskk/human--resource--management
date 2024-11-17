package com.example.service;

import com.example.pojo.User;

import java.util.List;

public interface UserService {
    User getUserById(Long userId);
    User getUserByUsername(String username);
    List<User> getAllUsers();
    void addUser(User user); // 用于用户注册
    void updateUser(User user);
    void deleteUser(Long userId);

    User login(String username, String password); // 登录功能
    void resetPassword(String username, String newPassword); // 重置密码
}
