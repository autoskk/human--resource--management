package com.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.pojo.User;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface UserMapper extends BaseMapper<User> {
     //根据用户角色id进行查询
    @Select("SELECT * FROM hrm.users WHERE role_id = #{roleId}")
    List<User> selectByRoleId(Integer roleId);
    @Select("SELECT * FROM hrm.users WHERE user_name = #{username}")
    User selectByUsername(String username);

    @Select("SELECT * FROM hrm.users WHERE user_id = #{userid}")
    User selectByUserid(int userid);
    // 重置用户密码
    @Update("UPDATE hrm.users SET user_password = #{newPassword} WHERE user_name = #{username}")
    void resetUserPassword(@Param("username") String username, @Param("newPassword") String newPassword);
    // 插入用户
    @Insert("INSERT INTO users (user_name, user_password, role_id) VALUES (#{userName}, #{userPassword}, #{roleId})")
    void insertUser(User user);
}
