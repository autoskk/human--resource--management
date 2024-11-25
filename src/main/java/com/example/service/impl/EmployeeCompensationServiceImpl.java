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
    public void saveEmployeeCompensation(EmployeeCompensation employeeCompensation) {
        employeeCompensationMapper.insertEmployeeCompensation(employeeCompensation);
    }

    @Override
    public EmployeeCompensation getEmployeeCompensationById(String employeeId) {
        return employeeCompensationMapper.selectById(employeeId);
    }

    @Override
    public void updateEmployeeCompensation(EmployeeCompensation employeeCompensation) {
        employeeCompensationMapper.updateById(employeeCompensation);
    }

    @Override
    public void deleteEmployeeCompensation(String employeeId) {
        employeeCompensationMapper.deleteById(employeeId);
    }

    @Override
    public List<EmployeeCompensation> getAllEmployeeCompensations() {
        return employeeCompensationMapper.selectAll();
    }

    @Override
    public List<EmployeeCompensation> getDistributionEmployeeCompensations(Integer distributionId) {
        return employeeCompensationMapper.selectByDistributionId(distributionId);
    }


}
