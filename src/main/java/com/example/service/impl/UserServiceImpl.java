package com.example.service.impl;

import com.example.mapper.UserMapper;
import com.example.pojo.User;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public User getUserById(Long userId) {
        return userMapper.selectById(userId);
    }

    @Override
    public User getUserByUsername(String username) {
        return userMapper.selectByUsername(username);
    }

    @Override
    public List<User> getAllUsers() {
        return userMapper.selectList(null); // 查询所有用户
    }

    @Override
    public void addUser(User user) {
        // 密码加密可在此处处理
        userMapper.insert(user);
    }

    @Override
    public void updateUser(User user) {
        userMapper.updateById(user);
    }

    @Override
    public void deleteUser(Long userId) {
        userMapper.deleteById(userId);
    }

    @Override
    public User login(String username, String password) {
        User user = userMapper.selectByUsername(username);
        if (user != null && user.getPassword().equals(password)) { // 这里可以插入密码检验逻辑，例如哈希处理
            return user; // 登录成功
        }
        return null; // 登录失败
    }

    @Override
    public void resetPassword(String username, String newPassword) {
        User user = getUserByUsername(username);
        if (user != null) {
            user.setPassword(newPassword); // 可以在这里加密密码
            userMapper.updateById(user);
        }
    }
}