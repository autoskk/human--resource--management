package com.example.controller;

import com.example.pojo.SalaryStandard;
import com.example.service.SalaryStandardService;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/salary-standards")
public class SalaryStandardController {

    @Autowired
    private SalaryStandardService salaryStandardService;
    @Autowired
    private UserService userService;
    // 创建薪酬标准
    @PostMapping("/create")
    public ResponseEntity<String> createSalaryStandard(@RequestBody SalaryStandard salaryStandard) {
        try {
            salaryStandardService.createSalaryStandard(salaryStandard);
            return ResponseEntity.status(HttpStatus.CREATED).body("薪酬标准创建成功");
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("薪酬标准创建失败: " + e.getMessage());
        }
    }
    // 根据 ID 或关键字搜索薪酬标准
    @GetMapping("/search")
    public String searchSalaryStandards(
            @RequestParam(required = false) Integer salaryStandardID,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date  startTime,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endTime,
            @RequestParam(required = false)  String status,
            Model model) {
        List<SalaryStandard> salaryStandards = salaryStandardService.findApprovedSalaryStandards(status);
        List<SalaryStandard> results = salaryStandardService.searchSalaryStandards(salaryStandardID, keyword, startTime, endTime);

        // 获取交集
        List<SalaryStandard> intersection = salaryStandards.stream()
                .filter(results::contains) // 仅保留在 results 中存在的元素
                .collect(Collectors.toList());

        model.addAttribute("salaryStandards", intersection); // 将结果添加到模型中
        return "salaryStandardManagement"; // 返回相应的 JSP 视图名，比如 "salaryStandards.jsp"
    }

    // 根据状态查询薪酬标准
    @GetMapping("/status/{status}")
    public String findByStatus(@PathVariable String status, Model model) {
        List<SalaryStandard> standards = salaryStandardService.findByStatus(status);
        model.addAttribute("salaryStandards", standards); // 将结果添加到模型中
        return "salaryStandardManagement"; // 返回相应的 JSP 视图名
    }
    @GetMapping("/getByStatus/{status}")
    public ResponseEntity<List<SalaryStandard>> GetByStatus(@PathVariable String status, Model model) {
        List<SalaryStandard> standards = salaryStandardService.findByStatus(status);
        if (standards == null) {
            return ResponseEntity.notFound().build(); // Return 404 Not Found if standard doesn't exist
        }

        return ResponseEntity.ok(standards);
    }

    // 根据登记时间范围查询薪酬标准
    @GetMapping("/registration-time")
    public String findByRegistrationTime(
            @RequestParam Date startTime,
            @RequestParam Date endTime,
            Model model) {
        List<SalaryStandard> standards = salaryStandardService.findByRegistrationTimeBetween(startTime, endTime);
        model.addAttribute("salaryStandards", standards); // 将结果添加到模型中
        return "salaryStandardManagement"; // 返回相应的 JSP 视图名
    }

    // 根据基础工资范围查询薪酬标准
    @GetMapping("/base-salary")
    public String findByBaseSalary(
            @RequestParam Double minSalary,
            @RequestParam Double maxSalary,
            Model model) {
        List<SalaryStandard> standards = salaryStandardService.findByBaseSalaryBetween(minSalary, maxSalary);
        model.addAttribute("salaryStandards", standards); // 将结果添加到模型中
        return "salaryStandardManagement"; // 返回相应的 JSP 视图名
    }

    // 获取所有薪酬标准
    @GetMapping
    public String getAllSalaryRecords(Model model) {
        List<SalaryStandard> allSalaryRecords = salaryStandardService.getAllSalaryRecords();
        model.addAttribute("salaryStandards", allSalaryRecords); // 将结果添加到模型中
        return "redirect:/salaryStandardManagement"; // 返回相应的 JSP 视图名
    }

    // 获取所有薪酬标准
    @GetMapping("/getAllSalaryRecords")
    public ResponseEntity<List<SalaryStandard>> getAllSalaryRecords() {
        List<SalaryStandard> allSalaryRecords = salaryStandardService.getAllSalaryRecords();
        return ResponseEntity.ok(allSalaryRecords); // 返回200 OK，以及薪酬标准列表
    }

    // 删除薪酬标准
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteSalaryStandard(@PathVariable Integer id) {
        try {
            salaryStandardService.deleteSalaryStandard(id);
            return ResponseEntity.ok("薪酬标准删除成功");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("薪酬标准删除失败: " + e.getMessage());
        }
    }

    @GetMapping("/review/{id}")
    public String getReviewSalaryStandard(@PathVariable Integer id, Model model) {
        SalaryStandard salaryStandard = salaryStandardService.findById(id);
        model.addAttribute("salaryStandard", salaryStandard);
        return "pendingSalaryStandard"; // 返回编辑薪资标准的视图
    }
    // 获取单个薪酬标准用于编辑
    @GetMapping("/{id}")
    public String getSalaryStandard(@PathVariable Integer id, Model model) {
        SalaryStandard salaryStandard = salaryStandardService.findById(id);
        model.addAttribute("salaryStandard", salaryStandard);
        return "editSalaryStandard"; // 返回编辑薪资标准的视图
    }

    // 编辑薪酬标准
    @PostMapping("/edit")
    public String editSalaryStandard(@ModelAttribute SalaryStandard salaryStandard, Model model) {
        try {
            salaryStandardService.updateSalaryStandard(salaryStandard);
            model.addAttribute("message", "薪酬标准编辑成功");
        } catch (Exception e) {
            model.addAttribute("message", "薪酬标准编辑失败: " + e.getMessage());
        }
        return "redirect:/salaryStandardManagement"; // redirect到薪酬标准管理页面
    }


    @PutMapping("/registration/{id}")
    public ResponseEntity<String> registrationSalaryStandard(@PathVariable Integer id) {
        try {
            salaryStandardService.registrationSalaryStandard(id);
            return ResponseEntity.ok("薪酬标准登记成功");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("薪酬标准登记失败: " + e.getMessage());
        }
    }

    // 获取单个薪酬标准用于编辑
    @GetMapping("/getStandard/{id}")
    public ResponseEntity<SalaryStandard> getSalaryStandard(@PathVariable Integer id) {
        SalaryStandard salaryStandard = salaryStandardService.findById(id);
        // Check if salaryStandard exists
        if (salaryStandard == null) {
            return ResponseEntity.notFound().build(); // Return 404 Not Found if standard doesn't exist
        }

        return ResponseEntity.ok(salaryStandard); // Return the salary standard as JSON
    }

}
