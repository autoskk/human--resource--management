package com.example.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "EmployeeCompensation")
public class EmployeeCompensation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer employeeID; // 档案编号

    @Column(nullable = false)
    private String name; // 姓名

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SalaryStandardID", nullable = false) // 关联的薪酬标准ID
    private SalaryStandard salaryStandard; // 关联的薪酬标准

    @Column(nullable = false)
    private Double allowances = 0.00; // 补助

    @Column(nullable = false)
    private Double bonus = 0.00; // 奖励奖金

    @Column(nullable = false)
    private Double deductions = 0.00; // 应扣奖金

    @Column(name = "DistributionID") // 关联的薪酬发放单号
    private Integer distributionID;

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

    // Getters and Setters
}
