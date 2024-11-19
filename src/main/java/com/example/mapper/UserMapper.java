package com.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.pojo.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface UserMapper extends BaseMapper<User> {
    // 根据用户名查找用户
    @Select("SELECT * FROM hrm.user WHERE username = #{username}")
    User selectByUsername(String username);

    // 重置用户密码
    @Update("UPDATE hrm.user SET password = #{newPassword} WHERE userName = #{username}")
    void resetUserPassword(@Param("username") String username, @Param("newPassword") String newPassword);

}
