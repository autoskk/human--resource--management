package com.example.service.impl;

import com.example.mapper.SalaryDistributionMapper;
import com.example.pojo.SalaryDistribution;
import com.example.service.SalaryDistributionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SalaryDistributionServiceImpl implements SalaryDistributionService {

    @Autowired
    private SalaryDistributionMapper salaryDistributionMapper;

    @Override
    public void saveSalaryDistribution(SalaryDistribution salaryDistribution) {
        salaryDistributionMapper.insertSalaryDistribution(salaryDistribution);
    }

    @Override
    public  List<SalaryDistribution> getSalaryDistributionById(Integer id) {
        return salaryDistributionMapper.selectById(id);
    }

    @Override
    public void updateSalaryDistribution(SalaryDistribution salaryDistribution) {
        salaryDistributionMapper.updateSalaryDistribution(salaryDistribution);
    }

    @Override
    public void deleteSalaryDistribution(Integer id) {
        salaryDistributionMapper.deleteById(id);
    }

    @Override
    public List<SalaryDistribution> getPendingDistributions() {
        return salaryDistributionMapper.selectPendingDistributions();
    }

    public List<SalaryDistribution> getAllSalaryDistributions() {
        return salaryDistributionMapper.selectAllDistributions();
    }

    @Override
    public SalaryDistribution getDistributionById(Integer id) {
        return salaryDistributionMapper.findById(id);
    }
}
