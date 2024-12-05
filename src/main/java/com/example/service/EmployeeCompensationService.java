package com.example.service;

import com.example.pojo.EmployeeCompensation;

import java.util.List;

public interface EmployeeCompensationService {
    void saveEmployeeCompensation(EmployeeCompensation employeeCompensation);
    EmployeeCompensation getEmployeeCompensationById(String employeeId,String distributionId);
    List<EmployeeCompensation> getEmployeeCompensationByEmployeeId(String employeeId);
    void updateEmployeeCompensation(EmployeeCompensation employeeCompensation);
    void deleteEmployeeCompensation(String employeeId,String distributionId);

    List<EmployeeCompensation> getAllEmployeeCompensations();

    List<EmployeeCompensation> getDistributionEmployeeCompensations(String distributionId);
    void deleteDistributionEmployeeCompensation(String distributionId);
}
