package com.example.service;

import com.example.pojo.SalaryDistribution;

import java.util.List;

public interface SalaryDistributionService {
    SalaryDistribution getSalaryDistributionById(Long distributionId);
    List<SalaryDistribution> getAllSalaryDistributions();
    void addSalaryDistribution(SalaryDistribution salaryDistribution);
    void updateSalaryDistribution(SalaryDistribution salaryDistribution);
    void deleteSalaryDistribution(Long distributionId);
}
