package com.example.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Date;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "salary_standard")
public class SalaryStandard {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "salary_standard_id") // 映射数据库字段
    private Integer salaryStandardID; // 薪酬标准编号

    @Column(name = "standard_name", nullable = false) // 映射数据库字段
    private String standardName; // 薪酬标准名称

    @Column(nullable = false) // 映射数据库字段
    private String creator; // 制定人

    @Column(nullable = false) // 映射数据库字段
    private String registrar; // 登记人

    @Column(name = "registration_time", nullable = false) // 映射成数据库字段
    @Temporal(TemporalType.TIMESTAMP)
    private Date registrationTime; // 登记时间

    @Column(name = "review_comment", length = 500) // 映射成数据库字段
    private String reviewComment; // 复核意见


    @Column(name = "status" ,nullable = false)
    private String status; // 状态

    @Column(name = "base_salary", nullable = false) // 映射成数据库字段
    private Double baseSalary; // 基本工资

    // 不需要在这里定义计算字段，数据将通过数据库计算
    @Column(name = "pension_insurance", insertable = false, updatable = false)
    private Double pensionInsurance; // 养老金

    @Column(name = "medical_insurance", insertable = false, updatable = false)
    private Double medicalInsurance; // 医疗保险

    @Column(name = "unemployment_insurance", insertable = false, updatable = false)
    private Double unemploymentInsurance; // 失业保险

    @Column(name = "housing_fund", insertable = false, updatable = false)
    private Double housingFund; // 住房公积金


}
