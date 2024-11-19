package com.example.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "salary_distribution")
public class SalaryDistribution {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer distributionID; // 薪酬发放单编号

    @Column(nullable = false)
    private String levelOneOrg; // 一级机构

    @Column(nullable = false)
    private String levelTwoOrg; // 二级机构

    @Column(nullable = false)
    private String levelThreeOrg; // 三级机构

    @Column(nullable = false)
    private Integer numberOfEmployees; // 人数

    @Column(nullable = false)
    private Double totalBaseSalary; // 基本薪酬总额

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private SalaryStatus status; // 状态

    @Column(nullable = false)
    private String registrar; // 登记人

}
