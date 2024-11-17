package com.example.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "SalaryStandard")
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
    @Column(name = "PensionInsurance")
    private Double pensionInsurance;

    @Column(name = "MedicalInsurance")
    private Double medicalInsurance;

    @Column(name = "UnemploymentInsurance")
    private Double unemploymentInsurance;

    @Column(name = "HousingFund")
    private Double housingFund;


}
