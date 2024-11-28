package com.example.service.impl;

import com.example.mapper.SalaryDistributionMapper;
import com.example.pojo.SalaryDistribution;
import com.example.service.SalaryDistributionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class SalaryDistributionServiceImpl implements SalaryDistributionService {

    @Autowired
    private SalaryDistributionMapper salaryDistributionMapper;

    @Override
    public void saveSalaryDistribution(SalaryDistribution salaryDistribution) {
        salaryDistribution.setRegistrationTime(new Date());
        salaryDistributionMapper.insertSalaryDistribution(salaryDistribution);
    }

    @Override
    public  List<SalaryDistribution> getSalaryDistributionById(Integer id) {
        return salaryDistributionMapper.selectById(id);
    }

    @Override
    public void updateSalaryDistribution(SalaryDistribution salaryDistribution) {
        salaryDistribution.setRegistrationTime(new Date());
        salaryDistributionMapper.updateSalaryDistribution(salaryDistribution);
    }

    @Override
    public void deleteSalaryDistribution(Integer id) {
        salaryDistributionMapper.deleteById(id);
    }

    @Override
    public List<SalaryDistribution> getDistributionsByStatus(String status) {
        return salaryDistributionMapper.selectDistributionsByStatus(status);
    }

    public List<SalaryDistribution> getAllSalaryDistributions() {
        return salaryDistributionMapper.selectAllDistributions();
    }

    @Override
    public SalaryDistribution getDistributionById(Integer id) {
        return salaryDistributionMapper.findById(id);
    }

    @Override
    public List<SalaryDistribution> searchSalaryDistributions(Integer distributionID, String keyword, Date startTime, Date endTime) {
        // 使用 Set 来避免重复记录
        Set<SalaryDistribution> uniqueResults = new HashSet<>();

        // 先处理根据 ID 查询
        if (distributionID != null) {
            List<SalaryDistribution> temp = salaryDistributionMapper.selectById(distributionID);
            uniqueResults.addAll(temp); // 添加到 Set 中以避免重复
        }

        // 处理关键字查询
        if (keyword != null && !keyword.isEmpty()) {
            List<SalaryDistribution> results1 = salaryDistributionMapper.findByRegistrar(keyword);
            List<SalaryDistribution> results2 = salaryDistributionMapper.selectDistributionsByStatus(keyword);
            uniqueResults.addAll(results1);
            uniqueResults.addAll(results2);
        }

        if(startTime != null || endTime != null){
            List<SalaryDistribution> results2 = salaryDistributionMapper.findByRegistrationTimeBetween(startTime, endTime);
            uniqueResults.addAll(results2);
        }

        // 如果没有提供 ID 或关键字，则获取所有记录
        if (distributionID == null && (keyword == null || keyword.isEmpty())&& startTime == null && endTime == null) {
            List<SalaryDistribution> allRecords = salaryDistributionMapper.selectAllDistributions(); // 假设你有一个方法获取所有记录
            uniqueResults.addAll(allRecords); // 添加到 Set 中以避免重复
        }



        // 转换 Set 为 List，返回去重后的结果
        return uniqueResults.stream().collect(Collectors.toList());
    }

}
