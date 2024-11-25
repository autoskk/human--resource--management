package com.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.pojo.SalaryDistribution;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface SalaryDistributionMapper extends BaseMapper<SalaryDistribution> {

    // 查询待登记的薪酬发放记录
    @Select("SELECT * FROM hrm.salary_distribution WHERE status = '待登记'")
    List<SalaryDistribution> selectPendingDistributions();

    // 插入新的薪酬发放记录
    @Insert("INSERT INTO hrm.salary_distribution (distribution_id,level_1_id, level_2_id, level_3_id, number_of_employees, total_base_salary, status, registrar) " +
            "VALUES (#{distributionID},#{levelOneId}, #{levelTwoId}, #{levelThreeId}, #{numberOfEmployees}, #{totalBaseSalary}, #{status}, #{registrar})")
    int insertSalaryDistribution(SalaryDistribution salaryDistribution);

    // 根据 ID 模糊查询薪酬发放记录
    @Select("SELECT * FROM hrm.salary_distribution WHERE distribution_id LIKE CONCAT('%', #{distributionID}, '%')")
    List<SalaryDistribution> selectById(@Param("distributionID") Integer distributionID);
    // 根据 ID 模糊查询薪酬发放记录
    @Select("SELECT * FROM hrm.salary_distribution WHERE distribution_id = #{distributionID}")
   SalaryDistribution findById(@Param("distributionID") Integer distributionID);

    // 更新薪酬发放记录
    @Update("UPDATE hrm.salary_distribution SET level_1_id = #{levelOneId}, level_2_id = #{levelTwoId}, " +
            "level_3_id = #{levelThreeId}, number_of_employees = #{numberOfEmployees}, total_base_salary = #{totalBaseSalary}, " +
            "status = #{status}, registrar = #{registrar} WHERE distribution_id = #{distributionID}")
    void updateSalaryDistribution(SalaryDistribution salaryDistribution);

    // 删除薪酬发放记录
    @Delete("DELETE FROM hrm.salary_distribution WHERE distribution_id = #{distributionID}")
    int deleteById(@Param("distributionID") Integer distributionID);

    // 查询所有薪酬发放记录
    @Select("SELECT * FROM hrm.salary_distribution")
    List<SalaryDistribution> selectAllDistributions();

    // 这里可以添加更多自定义查询方法
}
