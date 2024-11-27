package com.example.service;

import com.example.pojo.EmployeeCompensation;

import java.util.List;

public interface EmployeeCompensationService {
    void saveEmployeeCompensation(EmployeeCompensation employeeCompensation);
    EmployeeCompensation getEmployeeCompensationById(String employeeId);
    void updateEmployeeCompensation(EmployeeCompensation employeeCompensation);
    void deleteEmployeeCompensation(String employeeId);

    List<EmployeeCompensation> getAllEmployeeCompensations();

    List<EmployeeCompensation> getDistributionEmployeeCompensations(Integer distributionId);
}
