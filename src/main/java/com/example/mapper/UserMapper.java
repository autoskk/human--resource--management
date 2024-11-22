package com.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.pojo.User;
import org.apache.ibatis.annotations.*;

@Mapper
public interface UserMapper extends BaseMapper<User> {


    @Select("SELECT * FROM hrm.users WHERE user_name = #{username}")
    User selectByUsername(String username);
    // 重置用户密码
    @Update("UPDATE hrm.users SET user_password = #{newPassword} WHERE user_name = #{username}")
    void resetUserPassword(@Param("username") String username, @Param("newPassword") String newPassword);
    // 插入用户
    @Insert("INSERT INTO users (user_name, user_password, role_id) VALUES (#{userName}, #{userPassword}, #{roleId})")
    void insertUser(User user);
}
