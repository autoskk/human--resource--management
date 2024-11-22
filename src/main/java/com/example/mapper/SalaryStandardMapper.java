package com.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.pojo.SalaryStandard;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.Date;
import java.util.List;

@Mapper
public interface SalaryStandardMapper extends BaseMapper<SalaryStandard> {

    // 根据状态查询所有薪酬标准
    @Select("SELECT * FROM salary_standard WHERE status = #{status}")
    List<SalaryStandard> findByStatus(String status);

    // 根据登记时间范围查询薪酬标准
    @Select("SELECT * FROM salary_standard WHERE registration_time BETWEEN #{startTime} AND #{endTime}")
    List<SalaryStandard> findByRegistrationTimeBetween(Date startTime, Date endTime);

    // 根据基础工资范围查询薪酬标准
    @Select("SELECT * FROM salary_standard WHERE base_salary BETWEEN #{minSalary} AND #{maxSalary}")
    List<SalaryStandard> findByBaseSalaryBetween(Double minSalary, Double maxSalary);

    // 根据ID进行模糊查询
    @Select("SELECT * FROM salary_standard WHERE salary_standard_id LIKE CONCAT('%', #{salaryStandardID}, '%')")
    List<SalaryStandard> findById(Integer salaryStandardID);

    // 根据关键字进行模糊查询
    @Select("SELECT * FROM salary_standard WHERE creator LIKE CONCAT('%', #{keyword}, '%')")
    List<SalaryStandard> findByCreate(String keyword);

    @Select("SELECT * FROM salary_standard WHERE salary_standard.standard_name LIKE CONCAT('%', #{keyword}, '%')")
    List<SalaryStandard> findByStandardName(String keyword);

    @Select("SELECT * FROM salary_standard WHERE salary_standard.registrar LIKE CONCAT('%', #{keyword}, '%')")
    List<SalaryStandard> findByRegistrar(String keyword);

    @Select("SELECT * FROM salary_standard WHERE creator LIKE CONCAT('%', #{keyword}, '%')")
    List<SalaryStandard> findByKeyword(String keyword);
    // 查找所有的薪酬标准
    @Select("SELECT * FROM salary_standard")
    List<SalaryStandard> findAll();

    // 可以根据需要添加其他自定义查询方法
}
