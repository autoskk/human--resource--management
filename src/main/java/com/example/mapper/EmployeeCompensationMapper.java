package com.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.pojo.EmployeeCompensation;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface EmployeeCompensationMapper extends BaseMapper<EmployeeCompensation> {
    // 根据姓名查找员工薪酬
    EmployeeCompensation selectByName(@Param("name") String name);
    // 这里可以添加更多自定义查询方法
}
