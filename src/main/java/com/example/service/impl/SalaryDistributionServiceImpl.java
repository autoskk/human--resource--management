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
    public SalaryDistribution getSalaryDistributionById(Long distributionId) {
        return salaryDistributionMapper.selectById(distributionId);
    }

    @Override
    public List<SalaryDistribution> getAllSalaryDistributions() {
        return salaryDistributionMapper.selectList(null); // 查询所有薪酬发放
    }

    @Override
    public void addSalaryDistribution(SalaryDistribution salaryDistribution) {
        salaryDistributionMapper.insert(salaryDistribution);
    }

    @Override
    public void updateSalaryDistribution(SalaryDistribution salaryDistribution) {
        salaryDistributionMapper.updateById(salaryDistribution);
    }

    @Override
    public void deleteSalaryDistribution(Long distributionId) {
        salaryDistributionMapper.deleteById(distributionId);
    }
}
