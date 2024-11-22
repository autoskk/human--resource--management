package com.example.service.impl;

import com.example.mapper.SalaryStandardMapper;
import com.example.pojo.SalaryStandard;
import com.example.service.SalaryStandardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class SalaryStandardServiceImpl implements SalaryStandardService {

    @Autowired
    private SalaryStandardMapper salaryStandardMapper;

    @Override
    @Transactional
    public void createSalaryStandard(SalaryStandard salaryStandard, String currentUser) {
        // 设置基本属性
        salaryStandard.setRegistrar(currentUser); // 登记人设置为当前用户
        salaryStandard.setRegistrationTime(new Date()); // 登记时间默认当前时间
        salaryStandard.setBaseSalary(salaryStandard.getBaseSalary() != null ?
                salaryStandard.getBaseSalary() : 0.00); // 基本工资默认为0.00

        // 验证必要字段
        if (salaryStandard.getStandardName() == null || salaryStandard.getStandardName().isEmpty()) {
            throw new IllegalArgumentException("薪酬标准名称不能为空");
        }
        if (salaryStandard.getCreator() == null || salaryStandard.getCreator().isEmpty()) {
            throw new IllegalArgumentException("制定人不能为空");
        }

        // 插入薪酬标准
        salaryStandardMapper.insert(salaryStandard);
    }

    @Override
    public List<List<SalaryStandard>> searchSalaryStandards(Integer salaryStandardID, String keyword, Date startTime, Date endTime) {
        // 使用 Mapper 方法进行模糊查询
        List<List<SalaryStandard>> results = new ArrayList<>();
        if(salaryStandardID!=null){
            List<SalaryStandard> temp= salaryStandardMapper.findById(salaryStandardID);
            if (startTime != null && endTime != null) {
                temp.removeIf(record -> record.getRegistrationTime().before(startTime) ||
                        record.getRegistrationTime().after(endTime));
            }
            if(temp!=null){
                results.add(temp);
            }
        }
        if(keyword!=null){
            List<SalaryStandard> results1 = salaryStandardMapper.findByCreate(keyword);

            List<SalaryStandard> results2 = salaryStandardMapper.findByRegistrar(keyword);

            List<SalaryStandard> results3 = salaryStandardMapper.findByStandardName(keyword);

            if(results1 !=null){
                // 进一步筛选登记时间范围
                if (startTime != null && endTime != null) {
                    results1.removeIf(record -> record.getRegistrationTime().before(startTime) ||
                            record.getRegistrationTime().after(endTime));
                }
                if(results1!=null){
                    results.add(results1);
                }

            }
            if(results2 !=null){
                // 进一步筛选登记时间范围
                if (startTime != null && endTime != null) {
                    results2.removeIf(record -> record.getRegistrationTime().before(startTime) ||
                            record.getRegistrationTime().after(endTime));
                }
                if(results2 !=null){
                    results.add(results2);
                }

            }
            if(results3!=null){
                // 进一步筛选登记时间范围
                if (startTime != null && endTime != null) {
                    results3.removeIf(record -> record.getRegistrationTime().before(startTime) ||
                            record.getRegistrationTime().after(endTime));
                }
                if(results3!=null) {
                    results.add(results3);
                }
            }
        }


        return results;
    }

    @Override
    public List<SalaryStandard> findByStatus(String status) {
        return salaryStandardMapper.findByStatus(status);
    }

    @Override
    public List<SalaryStandard> findByRegistrationTimeBetween(Date startTime, Date endTime) {
        return salaryStandardMapper.findByRegistrationTimeBetween(startTime, endTime);
    }

    @Override
    public List<SalaryStandard> findByBaseSalaryBetween(Double minSalary, Double maxSalary) {
        return salaryStandardMapper.findByBaseSalaryBetween(minSalary, maxSalary);
    }

    @Override
    public List<SalaryStandard> getAllSalaryRecords() {
        // 这里可以实现获取待登记的薪酬发放记录逻辑
        return salaryStandardMapper.findAll(); // 假设使用 findAll() 方法，具体依据实际业务实现调整
    }

}
