package com.example.controller;

import com.example.pojo.EmployeeCompensation;
import com.example.pojo.SalaryDistribution;
import com.example.service.EmployeeCompensationService;
import com.example.service.SalaryDistributionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/salary-distributions")
public class SalaryDistributionController {

    @Autowired
    private SalaryDistributionService salaryDistributionService;
    @Autowired
    private EmployeeCompensationService employeeCompensationService;

    // 获取所有薪酬
    @GetMapping
    public String getAllSalaryDistribution(Model model) {




        List<SalaryDistribution> allSalaryDistribution = salaryDistributionService.getAllSalaryDistributions();

//        System.out.println(allSalaryDistribution);
        // 假设还有员工薪酬信息
        List<EmployeeCompensation> allEmployeeCompensations = employeeCompensationService.getAllEmployeeCompensations();


        model.addAttribute("salaryDistribution", allSalaryDistribution); // 将结果添加到模型中
        model.addAttribute("employeeCompensations", allEmployeeCompensations); // 将员工薪酬信息添加到模型中
        System.out.println(allSalaryDistribution);
        return "redirect:/salaryDistributionManagement"; // 返回相应的 JSP 视图名
    }


    // 创建薪资分配
    @PostMapping
    public ResponseEntity<String> createSalaryDistribution(@RequestBody SalaryDistribution salaryDistribution) {
        try {
            System.out.println(salaryDistribution);
            salaryDistributionService.saveSalaryDistribution(salaryDistribution);
            return ResponseEntity.status(HttpStatus.CREATED).body("薪资分配创建成功"); // 201 Created
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("薪资分配创建失败: " + e.getMessage());
        }
    }

    // 根据 ID 获取薪资分配
    @GetMapping("/{id}")
    public String getSalaryDistribution(@PathVariable Integer id, Model model) {
        List<SalaryDistribution> salaryDistribution = salaryDistributionService.getSalaryDistributionById(id);
        model.addAttribute("salaryDistribution", salaryDistribution);
        return "salaryDistributionManagement"; // 返回薪资分配详情的视图
    }
    @GetMapping("/getDistribution/{id}")
    public ResponseEntity<SalaryDistribution> getSalaryDistributionById(@PathVariable Integer id) {
        SalaryDistribution salaryDistribution = salaryDistributionService.getDistributionById(id);
        System.out.println(salaryDistribution);
        if (salaryDistribution != null) {
            return ResponseEntity.ok(salaryDistribution); // 200 OK with data
        } else {
            return ResponseEntity.notFound().build(); // 404 Not Found
        }
    }

    // 更新薪资分配
    @PutMapping("/{id}")
    public ResponseEntity<String> updateSalaryDistribution(@PathVariable Integer id, @RequestBody SalaryDistribution salaryDistribution) {
        try {
            System.out.println(salaryDistribution);
            salaryDistribution.setDistributionID(id); // 确保 ID 一致
            salaryDistributionService.updateSalaryDistribution(salaryDistribution);
            return ResponseEntity.ok("薪资分配更新成功"); // 200 OK
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("薪资分配更新失败: " + e.getMessage());
        }
    }

    // 删除薪资分配
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteSalaryDistribution(@PathVariable Integer id) {
        try {
            employeeCompensationService.deleteDistributionEmployeeCompensation(id);
            salaryDistributionService.deleteSalaryDistribution(id);
            return ResponseEntity.ok("薪资分配删除成功"); // 204 No Content
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("薪资分配删除失败: " + e.getMessage());
        }
    }

    @GetMapping("/status/{status}")
    public String getDistributionsByStatus(@PathVariable String status, Model model) {
        List<SalaryDistribution> salaryDistributions = salaryDistributionService.getDistributionsByStatus(status);
        model.addAttribute("salaryDistribution", salaryDistributions);
        return "salaryDistributionManagement"; // 返回待处理薪资分配的视图
    }

    // 根据 ID 或关键字搜索薪酬标准
    @GetMapping("/search")
    public String searchSalaryDistributions(
            @RequestParam(required = false) Integer distributionID,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startTime,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endTime,
            Model model) {
        List<SalaryDistribution> results = salaryDistributionService.searchSalaryDistributions(distributionID, keyword, startTime, endTime);
        model.addAttribute("salaryDistribution", results); // 将结果添加到模型中
        return "salaryDistributionManagement"; // 返回相应的 JSP 视图名
    }
}
