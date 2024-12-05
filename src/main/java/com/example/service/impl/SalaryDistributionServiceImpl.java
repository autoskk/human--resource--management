package com.example.service.impl;

import com.example.mapper.EmployeeCompensationMapper;
import com.example.mapper.EmployeeMapper;
import com.example.mapper.SalaryDistributionMapper;
import com.example.mapper.SalaryStandardMapper;
import com.example.pojo.EmployeeCompensation;
import com.example.pojo.EmployeeRecord;
import com.example.pojo.SalaryDistribution;
import com.example.pojo.SalaryStandard;
import com.example.service.SalaryDistributionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class SalaryDistributionServiceImpl implements SalaryDistributionService {

    @Autowired
    private SalaryDistributionMapper salaryDistributionMapper;
    @Autowired
    private EmployeeMapper employeeMapper;
    @Autowired
    private EmployeeCompensationMapper employeeCompensationMapper;
    @Autowired
    private SalaryStandardMapper salaryStandardMapper;

    @Override
    public String generateId(Integer level1Id, Integer level2Id, Integer level3Id) {
        // 获取当前年份
        String year = String.valueOf(java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
        String moonth = String.valueOf(java.util.Calendar.getInstance().get(Calendar.MONTH));

        // 获取一级、二级、三级机构的编号并转换为两位数字格式
        String Level1Id = String.format("%02d", level1Id);
        String Level2Id = String.format("%02d", level2Id);
        String Level3Id = String.format("%02d", level3Id);

        return year + moonth + Level1Id + Level2Id + Level3Id; // 组合成完整的记录ID
    }

    @Transactional
    public void CreateSalaryDistributionByTime(String time) {
        List<EmployeeRecord> employeeRecords = employeeMapper.findAllEmployees();
        List<EmployeeCompensation> employeeCompensations = employeeCompensationMapper.selectAll();
//        Set<String> temp = new HashSet<>();

        for (EmployeeRecord employeeRecord : employeeRecords) {
            String distributionID = generateId(employeeRecord.getLevel1Id(), employeeRecord.getLevel2Id(), employeeRecord.getLevel3Id());
            String newDistributionID = time + distributionID.substring(6);
            System.out.println(newDistributionID);

            // 核心改动：在插入前检查数据库中是否存在同样的 distributionID
            if (salaryDistributionMapper.findById(newDistributionID)==null) {
                System.out.println("分配单已经存在，跳过插入: " + newDistributionID);
                continue; // 如果已经存在就跳过
            }

            SalaryDistribution salaryDistribution = new SalaryDistribution(
                    newDistributionID,
                    employeeRecord.getLevel1Id(),
                    employeeRecord.getLevel2Id(),
                    employeeRecord.getLevel3Id(),
                    0,
                    0.0,
                    "待登记",
                    null,
                    null
            );

            try {
                salaryDistributionMapper.insertSalaryDistribution(salaryDistribution);
//                temp.add(newDistributionID);
            } catch (DuplicateKeyException e) {
                System.out.println("薪酬发放单插入失败，重复的 distributionID: " + newDistributionID);
                continue;
            }

            for (EmployeeCompensation employeeCompensation : employeeCompensations) {
                if (employeeCompensation.getDistributionId().substring(6).equals(distributionID.substring(6))
                        && !employeeCompensation.getDistributionId().equals(newDistributionID)) {
                    System.out.println("employeeCompensationDistributionId: " + employeeCompensation.getDistributionId());
                    SalaryStandard salaryStandard = salaryStandardMapper.selectById(employeeCompensation.getSalaryStandardID());
                    employeeCompensation.setDistributionId(newDistributionID);

                    employeeCompensationMapper.insertEmployeeCompensation(employeeCompensation);
                    salaryDistribution.setNumberOfEmployees(salaryDistribution.getNumberOfEmployees() + 1);
                    salaryDistribution.setTotalBaseSalary(salaryDistribution.getTotalBaseSalary() + salaryStandard.getBaseSalary());
                }
            }

            salaryDistributionMapper.updateSalaryDistribution(salaryDistribution);
        }
    }


    @Override
    public void saveSalaryDistribution(SalaryDistribution salaryDistribution) {
        //salaryDistribution.setRegistrationTime(new Date());
        salaryDistributionMapper.insertSalaryDistribution(salaryDistribution);
    }

    @Override
    public List<SalaryDistribution> getSalaryDistributionById(String id) {
        return salaryDistributionMapper.selectById(id);
    }
    @Override
    public void updateSalaryDistribution(SalaryDistribution salaryDistribution) {
        //salaryDistribution.setRegistrationTime(new Date());
        salaryDistributionMapper.updateSalaryDistribution(salaryDistribution);
    }

    @Override
    public void deleteSalaryDistribution(String id) {
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
    public SalaryDistribution getDistributionById(String id) {
        return salaryDistributionMapper.findById(id);
    }

    @Override
    public List<SalaryDistribution> searchSalaryDistributions(String distributionID, String keyword, Date startTime, Date endTime, Integer levelOneId, Integer levelTwoId, Integer levelThreeId, String time) {
        // 使用 Set 来避免重复记录
        Set<SalaryDistribution> uniqueResults = new HashSet<>();

        // 先处理根据 ID 查询
        if (distributionID != null && !distributionID.isEmpty()) {
            List<SalaryDistribution> temp = salaryDistributionMapper.selectById(distributionID);
            System.out.println("temp:" + temp);
            uniqueResults.addAll(temp); // 添加到 Set 中以避免重复
        }

        // 先处理根据 ID 查询
        if (time != null && !time.isEmpty()) {
            List<SalaryDistribution> temp = salaryDistributionMapper.selectById(time);
            System.out.println("temp:" + temp);
            uniqueResults.addAll(temp); // 添加到 Set 中以避免重复
        }

        // 处理关键字查询
        if (keyword != null && !keyword.isEmpty()) {
            List<SalaryDistribution> results1 = salaryDistributionMapper.findByRegistrar(keyword);
            List<SalaryDistribution> results2 = salaryDistributionMapper.selectDistributionsByStatus(keyword);
            System.out.println("result1:" + results1);
            System.out.println("result2:" + results2);
            uniqueResults.addAll(results1);
            uniqueResults.addAll(results2);
        }

        if (startTime != null && endTime != null) {
            List<SalaryDistribution> results2 = salaryDistributionMapper.findByRegistrationTimeBetween(startTime, endTime);
            System.out.println("result2:" + results2);
            uniqueResults.addAll(results2);
        }
        if (levelOneId != null || levelTwoId != null || levelThreeId != null) {
            List<SalaryDistribution> results3 = salaryDistributionMapper.findByLevel(levelOneId, levelTwoId, levelThreeId);
            System.out.println("result3:" + results3);
            uniqueResults.addAll(results3);
        }

        // 如果没有提供 ID 或关键字，则获取所有记录
        if ((distributionID == null || distributionID.isEmpty()) && (keyword == null || keyword.isEmpty()) && startTime == null && endTime == null && levelOneId == null && levelTwoId == null && levelThreeId == null && (time == null || time.isEmpty())) {
            List<SalaryDistribution> allRecords = salaryDistributionMapper.selectAllDistributions(); // 假设你有一个方法获取所有记录
            System.out.println("allRecords:" + allRecords);
            uniqueResults.addAll(allRecords); // 添加到 Set 中以避免重复
        }

        System.out.println("查询：" + uniqueResults);


        // 转换 Set 为 List，返回去重后的结果
        return uniqueResults.stream().collect(Collectors.toList());
    }

}
