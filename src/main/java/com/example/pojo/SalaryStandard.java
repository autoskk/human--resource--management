package com.example.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "salary_standard")
public class SalaryStandard {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer salaryStandardID; // 薪酬标准编号

    @Column(nullable = false)
    private String standardName; // 薪酬标准名称

    @Column(nullable = false)
    private String creator; // 制定人

    @Column(nullable = false)
    private String registrar; // 登记人

    @Column(nullable = false)
    private java.util.Date registrationTime; // 登记时间

    @Column(length = 500)
    private String reviewComment; // 复核意见

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private SalaryStatus status; // 状态

    @Column(nullable = false)
    private Double baseSalary; // 基本工资

    // 包含计算的保险和住房公积金字段
    @Column(name = "pension_insurance")
    private Double pensionInsurance;

    @Column(name = "medical_insurance")
    private Double medicalInsurance;

    @Column(name = "unemployment_insurance")
    private Double unemploymentInsurance;

    @Column(name = "housing_fund")
    private Double housingFund;


}
