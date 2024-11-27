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
@Table(name = "salary_distribution")
public class SalaryDistribution {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer distributionID; // 薪酬发放单编号

    @Column(name = "level_1_id", nullable = false)
    private Integer levelOneId; // 一级机构 ID

    @Column(name = "level_2_id", nullable = false)
    private Integer levelTwoId; // 二级机构 ID

    @Column(name = "level_3_id", nullable = false)
    private Integer levelThreeId; // 三级机构 ID

    @Column(nullable = false)
    private Integer numberOfEmployees; // 人数

    @Column(name = "total_base_salary", nullable = false)
    private Double totalBaseSalary; // 基本薪酬总额

    @Column(name = "status", nullable = false)
    private String status; // 状态

    @Column(nullable = false)
    private String registrar; // 登记人

    @Column(name = "registration_time", nullable = false) // 映射成数据库字段
    @Temporal(TemporalType.TIMESTAMP)
    private Date registrationTime; // 登记时间


}
