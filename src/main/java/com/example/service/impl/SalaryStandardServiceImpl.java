package com.example.service.impl;

import com.example.mapper.SalaryStandardMapper;
import com.example.pojo.SalaryStandard;
import com.example.service.SalaryStandardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class SalaryStandardServiceImpl implements SalaryStandardService {

    @Autowired
    private SalaryStandardMapper salaryStandardMapper;
    @Override
    @Transactional
    public void createSalaryStandard(SalaryStandard salaryStandard) {
        // 设置基本属性
//        salaryStandard.setRegistrar(currentUser); // 登记人设置为当前用户
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
    public List<SalaryStandard> searchSalaryStandards(Integer salaryStandardID, String keyword, Date startTime, Date endTime) {
        // 使用 Set 来避免重复记录
        Set<SalaryStandard> uniqueResults = new HashSet<>();

        // 先处理根据 ID 查询
        if (salaryStandardID != null) {
            List<SalaryStandard> temp = salaryStandardMapper.findById(salaryStandardID);
            if (temp != null) {
                // 进一步筛选登记时间范围
                if (startTime != null || endTime != null) {
                    temp.removeIf(record -> record.getRegistrationTime().before(startTime) ||
                            record.getRegistrationTime().after(endTime));
                }
                uniqueResults.addAll(temp); // 添加到 Set 中以避免重复
            }
        }

        // 处理关键字查询
        if (keyword != null && !keyword.isEmpty()) {
            List<SalaryStandard> results1 = salaryStandardMapper.findByCreate(keyword);
            List<SalaryStandard> results2 = salaryStandardMapper.findByRegistrar(keyword);
            List<SalaryStandard> results3 = salaryStandardMapper.findByStandardName(keyword);

            // 处理每个查询结果并去重
            if (results1 != null) {
                if (startTime != null || endTime != null) {
                    results1.removeIf(record -> record.getRegistrationTime().before(startTime) ||
                            record.getRegistrationTime().after(endTime));
                }
                uniqueResults.addAll(results1);
            }

            if (results2 != null) {
                if (startTime != null || endTime != null) {
                    results2.removeIf(record -> record.getRegistrationTime().before(startTime) ||
                            record.getRegistrationTime().after(endTime));
                }
                uniqueResults.addAll(results2);
            }

            if (results3 != null) {
                if (startTime != null || endTime != null) {
                    results3.removeIf(record -> record.getRegistrationTime().before(startTime) ||
                            record.getRegistrationTime().after(endTime));
                }
                uniqueResults.addAll(results3);
            }
        }

        // 如果没有提供 ID 或关键字，则获取所有记录
        if (salaryStandardID == null && (keyword == null || keyword.isEmpty())) {
            List<SalaryStandard> allRecords = salaryStandardMapper.findAll(); // 假设你有一个方法获取所有记录
            if (startTime != null || endTime != null) {
                allRecords.removeIf(record -> record.getRegistrationTime().before(startTime) ||
                        record.getRegistrationTime().after(endTime));
            }
            uniqueResults.addAll(allRecords); // 添加到 Set 中以避免重复
        }

        // 转换 Set 为 List，返回去重后的结果
        return uniqueResults.stream().collect(Collectors.toList());
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

    @Override
    public void deleteSalaryStandard(Integer id) {
        salaryStandardMapper.deleteById(id);
    }

    @Override
    public SalaryStandard findById(Integer id) {
        return salaryStandardMapper.selectById(id);
    }

    @Override
    public void updateSalaryStandard(SalaryStandard salaryStandard) {
        salaryStandardMapper.update(salaryStandard);
    }
    @Override
    public void registrationSalaryStandard(Integer id){
        salaryStandardMapper.updateStatus(id);
    }

    @Override
    public List<SalaryStandard> findApprovedSalaryStandards(String status) {
        return salaryStandardMapper.findByStatus(status);
    }


    public SalaryStandard getStandard(int standardId) {
        return salaryStandardMapper.selectById(standardId);
    }
}

