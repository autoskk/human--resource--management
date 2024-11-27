package com.example.service;

import com.example.pojo.EmployeeCompensation;

import java.util.List;

public interface EmployeeCompensationService {
    void saveEmployeeCompensation(EmployeeCompensation employeeCompensation);
    EmployeeCompensation getEmployeeCompensationById(String employeeId,Integer distributionId);
    void updateEmployeeCompensation(EmployeeCompensation employeeCompensation);
    void deleteEmployeeCompensation(String employeeId,Integer distributionId);

    List<EmployeeCompensation> getAllEmployeeCompensations();

    List<EmployeeCompensation> getDistributionEmployeeCompensations(Integer distributionId);

    void deleteDistributionEmployeeCompensation(Integer distributionId);
}
