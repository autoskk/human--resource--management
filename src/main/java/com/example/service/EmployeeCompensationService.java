package com.example.service;

import com.example.pojo.EmployeeCompensation;

import java.util.List;

public interface EmployeeCompensationService {
    EmployeeCompensation getEmployeeCompensationById(Integer employeeId);
    EmployeeCompensation getEmployeeCompensationByName(String name);
    List<EmployeeCompensation> getAllEmployeeCompensations();
    void addEmployeeCompensation(EmployeeCompensation employeeCompensation);
    void updateEmployeeCompensation(EmployeeCompensation employeeCompensation);
    void deleteEmployeeCompensation(Integer employeeId);
}
