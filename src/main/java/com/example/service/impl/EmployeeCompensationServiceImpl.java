package com.example.service.impl;

import com.example.mapper.EmployeeCompensationMapper;
import com.example.pojo.EmployeeCompensation;
import com.example.service.EmployeeCompensationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeCompensationServiceImpl implements EmployeeCompensationService {

    @Autowired
    private EmployeeCompensationMapper employeeCompensationMapper;

    @Override
    public EmployeeCompensation getEmployeeCompensationById(Integer employeeId) {
        return employeeCompensationMapper.selectById(employeeId);
    }

    @Override
    public EmployeeCompensation getEmployeeCompensationByName(String name) {
        return employeeCompensationMapper.selectByName(name);
    }

    @Override
    public List<EmployeeCompensation> getAllEmployeeCompensations() {
        return employeeCompensationMapper.selectList(null); // 查询所有员工薪酬
    }

    @Override
    public void addEmployeeCompensation(EmployeeCompensation employeeCompensation) {
        employeeCompensationMapper.insert(employeeCompensation);
    }

    @Override
    public void updateEmployeeCompensation(EmployeeCompensation employeeCompensation) {
        employeeCompensationMapper.updateById(employeeCompensation);
    }

    @Override
    public void deleteEmployeeCompensation(Integer employeeId) {
        employeeCompensationMapper.deleteById(employeeId);
    }
}
