package com.example.service.impl;

import com.example.mapper.EmployeeMapper;
import com.example.pojo.EmployeeRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private Level1OrganizationService level1OrganizationService; // 确保服务已经定义
    @Autowired
    private Level2OrganizationService level2OrganizationService;  // 确保服务已经定义
    @Autowired
    private Level3OrganizationService level3OrganizationService;  // 确保服务已经定义
    @Autowired
    private PositionService positionService;  // 确保服务已经定义

    public void addEmployee(EmployeeRecord employeeRecord) {
        String recordId = generateRecordId(employeeRecord);
        employeeRecord.setRecordId(recordId);
        employeeMapper.insertEmployee(employeeRecord);
    }

    public EmployeeRecord getEmployee(String recordId) {
        return employeeMapper.findById(recordId);
    }

    public void editEmployee(EmployeeRecord employeeRecord) {
        employeeMapper.updateEmployee(employeeRecord);
    }

    public void deleteEmployee(String recordId) {
        employeeMapper.deleteEmployee(recordId);
    }

    public List<EmployeeRecord> getPendingEmployees() {
        return employeeMapper.findPendingEmployees();
    }

    public List<EmployeeRecord> getAllEmployees() {
        return employeeMapper.findAllEmployees();
    }

    public List<EmployeeRecord> searchEmployees(Integer level1Id, Integer level2Id, Integer level3Id,
                                                Integer categoryId, Integer positionId,
                                                Date startDate, Date endDate) {
        return employeeMapper.searchEmployees(level1Id, level2Id, level3Id, categoryId, positionId, startDate, endDate);
    }

    private String generateRecordId(EmployeeRecord employeeRecord) {
        // 获取当前年份
        String year = String.valueOf(java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));

        // 获取一级、二级、三级机构的编号并转换为两位数字格式
        String level1Id = String.format("%02d", employeeRecord.getLevel1Id());
        String level2Id = String.format("%02d", employeeRecord.getLevel2Id());
        String level3Id = String.format("%02d", employeeRecord.getLevel3Id());

        // 获取编号，根据需要从数据库中查询已存在的编号
        int count = employeeMapper.countByOrganizations(employeeRecord.getLevel1Id(), employeeRecord.getLevel2Id(), employeeRecord.getLevel3Id());
        String idNumber = String.format("%02d", count + 1); // 新增的记录编号为当前数量加一，格式化为两位数字

        return year + level1Id + level2Id + level3Id + idNumber; // 组合成完整的记录ID
    }







}
