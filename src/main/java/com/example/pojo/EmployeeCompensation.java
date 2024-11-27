package com.example.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "employee_compensation")
public class EmployeeCompensation {

    @Id
    @Column(name = "employee_id", length = 20)
    private String employeeId; // 员工编号


    @Column(name = "salary_standard_id", nullable = false) // 关联的薪酬标准 ID
    private Integer salaryStandardID; // 关联的薪酬标准

    @Column(nullable = false)
    private Double allowances = 0.00; // 补助

    @Column(nullable = false)
    private Double bonus = 0.00; // 奖励奖金

    @Column(nullable = false)
    private Double deductions = 0.00; // 应扣奖金

    @Column(name = "distribution_id") // 关联的薪酬发放单号
    private Integer distributionId; // 对应的薪酬发放单号

    // 计算字段不需要在这里定义，可以通过服务层来计算
    @Transient
    private Double baseSalary; // 基本工资，来自薪酬标准

    @Transient
    private Double pensionInsurance; // 养老保险，根据基本工资计算

    @Transient
    private Double medicalInsurance; // 医疗保险，根据基本工资计算

    @Transient
    private Double unemploymentInsurance; // 失业保险，根据基本工资计算

    @Transient
    private Double housingFund; // 住房公积金，根据基本工资计算

    // Getters and Setters 由 Lombok 自动生成
}
