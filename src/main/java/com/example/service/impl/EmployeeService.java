package com.example.service.impl;

import com.example.mapper.EmployeeMapper;
import com.example.pojo.EmployeeRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

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
        employeeRecord.setStatus("待复核");
        TimeZone.setDefault(TimeZone.getTimeZone("Asia/Shanghai"));
        Date date = new Date();
        employeeRecord.setCreatedDate(date);
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

//<<<<<<< HEAD
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






//=======
    // 添加新的方法到 EmployeeService
    public Integer countEmployeesByLevel(int level1Id, int level2Id, int level3Id) {
        // 查询数据库返回符合条件的员工数量
        return employeeMapper.countEmployeesByLevel(level1Id, level2Id, level3Id);
    }

    public Double calculateTotalBaseSalary(int level1Id, int level2Id, int level3Id) {
        // 查询数据库返回符合条件的员工总薪酬
        return employeeMapper.calculateTotalBaseSalary(level1Id, level2Id, level3Id);
    }
//>>>>>>> ca48bc6ac24878be5ebe8e624b2776f9cb3e0292

    public void softDeleteEmployee(String recordId) {
        EmployeeRecord employeeRecord = employeeMapper.findById(recordId);
        if (employeeRecord == null) {
            throw new IllegalArgumentException("员工档案不存在");
        }
        if ("待复核".equals(employeeRecord.getStatus())) {
            throw new IllegalArgumentException("状态为'待复核'的员工档案不能删除");
        }

        employeeMapper.softDeleteEmployee(recordId);
    }


    public void restoreEmployee(String recordId) {
        EmployeeRecord employeeRecord = employeeMapper.findById(recordId);
        if (employeeRecord == null) {
            throw new IllegalArgumentException("员工档案不存在");
        }
        if (!"已删除".equals(employeeRecord.getStatus())) {
            throw new IllegalArgumentException("该档案不是已删除状态，无法恢复");
        }

        employeeMapper.restoreEmployee(recordId);
    }


}
