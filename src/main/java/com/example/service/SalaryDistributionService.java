package com.example.service;

import com.example.pojo.SalaryDistribution;

import java.util.Date;
import java.util.List;

public interface SalaryDistributionService {
    String generateId(Integer level1Id, Integer level2Id, Integer level3Id);

    void saveSalaryDistribution(SalaryDistribution salaryDistribution);
    List<SalaryDistribution> getSalaryDistributionById(String id);
    void updateSalaryDistribution(SalaryDistribution salaryDistribution);
    void deleteSalaryDistribution(String id);
    List<SalaryDistribution> getDistributionsByStatus(String status);

    List<SalaryDistribution> getAllSalaryDistributions();
    SalaryDistribution getDistributionById(String id);

    // 查询薪酬标准，包括模糊查询
    List<SalaryDistribution> searchSalaryDistributions(String distributionID, String keyword, Date startTime, Date endTime,Integer levelOneId,Integer levelTwoId,Integer levelThreeId,String time);


    void CreateSalaryDistributionByTime(String time);
}
