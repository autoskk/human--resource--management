package com.example.service;

import com.example.pojo.SalaryStandard;

import java.util.Date;
import java.util.List;

public interface SalaryStandardService {

    // 新增薪酬标准
    void createSalaryStandard(SalaryStandard salaryStandard);

    // 查询薪酬标准，包括模糊查询
    List<SalaryStandard> searchSalaryStandards(Integer salaryStandardID, String keyword, Date startTime, Date endTime);

    // 根据状态查询薪酬标准
    List<SalaryStandard> findByStatus(String status);

    // 根据登记时间范围查询薪酬标准
    List<SalaryStandard> findByRegistrationTimeBetween(Date startTime, Date endTime);

    // 根据基础工资范围查询薪酬标准
    List<SalaryStandard> findByBaseSalaryBetween(Double minSalary, Double maxSalary);

    // 获取所有待登记的薪酬发放记录
    List<SalaryStandard> getAllSalaryRecords();

    void deleteSalaryStandard(Integer id);

    SalaryStandard findById(Integer id);

    void updateSalaryStandard(SalaryStandard salaryStandard);

    void registrationSalaryStandard(Integer id);
}
