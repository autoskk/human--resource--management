package com.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.pojo.Role;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface RoleMapper extends BaseMapper<Role> {
    // 根据角色名称查找
    Role selectByRoleName(String roleName);

    // 查找所有角色
    @Select("SELECT * FROM hrm.role")
    List<Role> selectAllRoles();
}
