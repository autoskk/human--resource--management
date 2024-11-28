package com.example.service;

import com.example.pojo.SalaryDistribution;

import java.util.Date;
import java.util.List;

public interface SalaryDistributionService {
    void saveSalaryDistribution(SalaryDistribution salaryDistribution);
    List<SalaryDistribution> getSalaryDistributionById(Integer id);
    void updateSalaryDistribution(SalaryDistribution salaryDistribution);
    void deleteSalaryDistribution(Integer id);
    List<SalaryDistribution> getDistributionsByStatus(String status);

    List<SalaryDistribution> getAllSalaryDistributions();

    SalaryDistribution getDistributionById(Integer id);

    // 查询薪酬标准，包括模糊查询
    List<SalaryDistribution> searchSalaryDistributions(Integer distributionID, String keyword, Date startTime, Date endTime);

}
