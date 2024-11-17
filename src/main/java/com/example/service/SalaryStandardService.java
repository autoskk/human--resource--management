package com.example.service;

import com.example.pojo.SalaryStandard;

import java.util.List;

public interface SalaryStandardService {
    SalaryStandard getSalaryStandardById(Long salaryStandardId);
    SalaryStandard getSalaryStandardByName(String standardName);
    List<SalaryStandard> getAllSalaryStandards();
    void addSalaryStandard(SalaryStandard salaryStandard);
    void updateSalaryStandard(SalaryStandard salaryStandard);
    void deleteSalaryStandard(Long salaryStandardId);
}
