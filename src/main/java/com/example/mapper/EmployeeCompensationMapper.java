package com.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.pojo.EmployeeCompensation;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface EmployeeCompensationMapper extends BaseMapper<EmployeeCompensation> {



    // 根据发放单Id查找员工薪酬
    @Select("SELECT * FROM employee_compensation WHERE distribution_id = #{distributionId}")
    List<EmployeeCompensation> selectByDistributionId(@Param("distributionId") Integer distributionId);

    // 根据Id查找员工薪酬
    @Select("SELECT * FROM employee_compensation WHERE employee_id = #{employeeId}")
    EmployeeCompensation selectByEmployeeId(@Param("employeeId") String employeeId);

    // 查询所有员工薪酬信息
    @Select("SELECT * FROM employee_compensation")
    List<EmployeeCompensation> selectAll();

    // 插入员工薪酬信息
    @Insert("INSERT INTO employee_compensation (employee_id, salary_standard_id, allowances, bonus, deductions, distribution_id) " +
            "VALUES (#{employeeId}, #{salaryStandardID}, #{allowances}, #{bonus}, #{deductions}, #{distributionId})")
    int insertEmployeeCompensation(EmployeeCompensation compensation);



    // 更新员工薪酬信息
    @Update("UPDATE employee_compensation SET allowances = #{allowances}, bonus = #{bonus}, deductions = #{deductions} " +
            "WHERE employee_id = #{employeeId}")
    int updateEmployeeCompensation(@Param("employeeId") String employeeId,
                                   @Param("allowances") Double allowances,
                                   @Param("bonus") Double bonus,
                                   @Param("deductions") Double deductions);

    // 删除员工薪酬信息
    @Delete("DELETE FROM employee_compensation WHERE employee_id = #{employeeId} AND distribution_id = #{distributionId}")
    int deleteById(@Param("employeeId") String employeeId , @Param("distributionId")Integer distributionId);

    @Delete("DELETE FROM employee_compensation WHERE distribution_id = #{distributionId}")
    int deleteByDistributionId(@Param("distributionId") Integer distributionId);


}
