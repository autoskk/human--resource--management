package com.example.controller;

import com.example.pojo.SalaryStandard;
import com.example.service.SalaryStandardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/salary-standards")
public class SalaryStandardController {

    @Autowired
    private SalaryStandardService salaryStandardService;

    // 创建薪酬标准
    @PostMapping("/create")
    public ResponseEntity<String> createSalaryStandard(@RequestBody SalaryStandard salaryStandard, @RequestHeader("currentUser") String currentUser) {
        try {
            salaryStandardService.createSalaryStandard(salaryStandard, currentUser);
            return ResponseEntity.status(HttpStatus.CREATED).body("薪酬标准创建成功");
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage()); // 返回错误信息
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("薪酬标准创建失败: " + e.getMessage());
        }
    }

    // 根据 ID 或关键字搜索薪酬标准
    @GetMapping("/search")
    public ResponseEntity<List<List<SalaryStandard>>> searchSalaryStandards(
            @RequestParam(required = false) Integer salaryStandardID,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) Date startTime,
            @RequestParam(required = false) Date endTime) {

        List<List<SalaryStandard>> results = salaryStandardService.searchSalaryStandards(salaryStandardID, keyword, startTime, endTime);
        return ResponseEntity.ok(results);
    }

    // 根据状态查询薪酬标准
    @GetMapping("/status/{status}")
    public ResponseEntity<List<SalaryStandard>> findByStatus(@PathVariable String status) {
        List<SalaryStandard> standards = salaryStandardService.findByStatus(status);
        return ResponseEntity.ok(standards);
    }

    // 根据登记时间范围查询薪酬标准
    @GetMapping("/registration-time")
    public ResponseEntity<List<SalaryStandard>> findByRegistrationTime(
            @RequestParam Date startTime,
            @RequestParam Date endTime) {
        List<SalaryStandard> standards = salaryStandardService.findByRegistrationTimeBetween(startTime, endTime);
        return ResponseEntity.ok(standards);
    }

    // 根据基础工资范围查询薪酬标准
    @GetMapping("/base-salary")
    public ResponseEntity<List<SalaryStandard>> findByBaseSalary(
            @RequestParam Double minSalary,
            @RequestParam Double maxSalary) {
        List<SalaryStandard> standards = salaryStandardService.findByBaseSalaryBetween(minSalary, maxSalary);
        return ResponseEntity.ok(standards);
    }

    // 获取所有薪酬标准
    @GetMapping("/getAllSalaryRecords")
    public ResponseEntity<List<SalaryStandard>> getAllSalaryRecords() {
        List<SalaryStandard> allSalaryRecords = salaryStandardService.getAllSalaryRecords();
        return ResponseEntity.ok(allSalaryRecords);
    }
}
