package com.example.service.impl;

import com.example.mapper.SalaryStandardMapper;
import com.example.pojo.SalaryStandard;
import com.example.service.SalaryStandardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SalaryStandardServiceImpl implements SalaryStandardService {

    @Autowired
    private SalaryStandardMapper salaryStandardMapper;

    @Override
    public SalaryStandard getSalaryStandardById(Long salaryStandardId) {
        return salaryStandardMapper.selectById(salaryStandardId);
    }

    @Override
    public SalaryStandard getSalaryStandardByName(String standardName) {
        return salaryStandardMapper.selectByStandardName(standardName);
    }

    @Override
    public List<SalaryStandard> getAllSalaryStandards() {
        return salaryStandardMapper.selectList(null); // 查询所有薪酬标准
    }

    @Override
    public void addSalaryStandard(SalaryStandard salaryStandard) {
        salaryStandardMapper.insert(salaryStandard);
    }

    @Override
    public void updateSalaryStandard(SalaryStandard salaryStandard) {
        salaryStandardMapper.updateById(salaryStandard);
    }

    @Override
    public void deleteSalaryStandard(Long salaryStandardId) {
        salaryStandardMapper.deleteById(salaryStandardId);
    }
}
