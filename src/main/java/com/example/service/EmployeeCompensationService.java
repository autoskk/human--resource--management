package com.example.service;

import com.example.pojo.EmployeeCompensation;

public interface EmployeeCompensationService {
    void saveEmployeeCompensation(EmployeeCompensation employeeCompensation);
    EmployeeCompensation getEmployeeCompensationById(String employeeId);
    void updateEmployeeCompensation(EmployeeCompensation employeeCompensation);
    void deleteEmployeeCompensation(String employeeId);

}
