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

    public void addEmployee(EmployeeRecord employeeRecord) {
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

    // 添加新的方法到 EmployeeService
    public Integer countEmployeesByLevel(int level1Id, int level2Id, int level3Id) {
        // 查询数据库返回符合条件的员工数量
        return employeeMapper.countEmployeesByLevel(level1Id, level2Id, level3Id);
    }

    public Double calculateTotalBaseSalary(int level1Id, int level2Id, int level3Id) {
        // 查询数据库返回符合条件的员工总薪酬
        return employeeMapper.calculateTotalBaseSalary(level1Id, level2Id, level3Id);
    }

}
