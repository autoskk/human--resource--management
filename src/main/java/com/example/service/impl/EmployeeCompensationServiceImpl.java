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
    public EmployeeCompensation getEmployeeCompensationById(String employeeId,Integer distributionId) {
        return employeeCompensationMapper.selectByEmployeeIdAndDistributionId(employeeId,distributionId);
    }

    @Override
    public void updateEmployeeCompensation( EmployeeCompensation employeeCompensation) {
        employeeCompensationMapper.updateEmployeeCompensation(employeeCompensation);
    }

    @Override
    public void deleteEmployeeCompensation(String employeeId,Integer distributionId) {
        employeeCompensationMapper.deleteById(employeeId,distributionId);
    }

    @Override
    public List<EmployeeCompensation> getAllEmployeeCompensations() {
        return employeeCompensationMapper.selectAll();
    }

    @Override
    public List<EmployeeCompensation> getDistributionEmployeeCompensations(Integer distributionId) {
        return employeeCompensationMapper.selectByDistributionId(distributionId);
    }

    @Override
    public void deleteDistributionEmployeeCompensation(Integer distributionId) {
        employeeCompensationMapper.deleteByDistributionId(distributionId);
    }


}
