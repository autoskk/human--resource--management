package com.example.service;

import com.example.pojo.SalaryDistribution;

import java.util.List;

public interface SalaryDistributionService {
    void saveSalaryDistribution(SalaryDistribution salaryDistribution);
    SalaryDistribution getSalaryDistributionById(Integer id);
    void updateSalaryDistribution(SalaryDistribution salaryDistribution);
    void deleteSalaryDistribution(Integer id);
    List<SalaryDistribution> getPendingDistributions();
}
