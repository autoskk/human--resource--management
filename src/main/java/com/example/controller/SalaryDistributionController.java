package com.example.controller;

import com.example.pojo.*;
import com.example.service.EmployeeCompensationService;
import com.example.service.SalaryDistributionService;
import com.example.service.SalaryStandardService;
import com.example.service.impl.EmployeeService;
import com.example.service.impl.Level1OrganizationService;
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
@RequestMapping("/salary-distributions")
public class SalaryDistributionController {

    @Autowired
    private SalaryDistributionService salaryDistributionService;
    @Autowired
    private EmployeeCompensationService employeeCompensationService;
    @Autowired
    private Level1OrganizationService level1OrganizationService;
    @Autowired
    private EmployeeService employeeService;
    @Autowired
    private SalaryStandardService salaryStandardService;

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
    public String getSalaryDistribution(@PathVariable String id, Model model) {
        List<SalaryDistribution> salaryDistribution = salaryDistributionService.getSalaryDistributionById(id);
        model.addAttribute("salaryDistribution", salaryDistribution);
        return "salaryDistributionManagement"; // 返回薪资分配详情的视图
    }

    @GetMapping("/getDistribution/{id}")
    public ResponseEntity<SalaryDistribution> getSalaryDistributionById(@PathVariable String id) {
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
    public ResponseEntity<String> updateSalaryDistribution(@PathVariable String id, @RequestBody SalaryDistribution salaryDistribution) {
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
    public ResponseEntity<String> deleteSalaryDistribution(@PathVariable String id) {
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
        List<Level1Organization> level1Organizations = level1OrganizationService.getAllLevel1Organizations();
        model.addAttribute("level1Organizations", level1Organizations);
        return "salaryDistributionManagement"; // 返回待处理薪资分配的视图
    }
    // 根据 ID 或关键字搜索薪酬标准
    @GetMapping("/search")
    public String searchSalaryDistributions(
            @RequestParam(required = false) String distributionID,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startTime,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endTime,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String time,
            @RequestParam(required = false) Integer levelOneId,
            @RequestParam(required = false) Integer levelTwoId,
            @RequestParam(required = false) Integer levelThreeId,

            Model model) {
        System.out.println("distributionID:" + distributionID);
        // 获取一级、二级、三级机构的编号并转换为两位数字格式
        List<Level1Organization> level1Organizations = level1OrganizationService.getAllLevel1Organizations();
        model.addAttribute("level1Organizations", level1Organizations);

        List<SalaryDistribution> salaryDistributions = salaryDistributionService.getDistributionsByStatus(status);
        List<SalaryDistribution> results = salaryDistributionService.searchSalaryDistributions(distributionID, keyword, startTime, endTime, levelOneId, levelTwoId, levelThreeId, time);

        // 获取交集
        List<SalaryDistribution> intersection = salaryDistributions.stream()
                .filter(results::contains) // 仅保留在 results 中存在的元素
                .collect(Collectors.toList());

        model.addAttribute("salaryDistribution", intersection); // 将结果添加到模型中

        return "salaryDistributionManagement"; // 返回相应的 JSP 视图名

    }

    @GetMapping("/getDistributionId")
    public ResponseEntity<String> getSalaryDistributionById(@RequestParam Integer level1Id, @RequestParam Integer level2Id, @RequestParam Integer level3Id) {
        String distributionId = salaryDistributionService.generateId(level1Id, level2Id, level3Id);
        System.out.println(distributionId);
        if (distributionId != null) {
            return ResponseEntity.ok(distributionId); // 200 OK with data
        } else {
            return ResponseEntity.notFound().build(); // 404 Not Found
        }
    }

    @GetMapping("/import/{time}")
    public String ImportSalaryDistribution(@PathVariable String time, Model model) {
//        salaryDistributionService.CreateSalaryDistributionByTime(time);
        List<EmployeeRecord> employeeRecords = employeeService.getAllEmployees();
//        System.out.println(employeeRecords);
//
        for (EmployeeRecord employeeRecord : employeeRecords) {
            synchronized (this) { // 同步块，确保此块在同一时间只能被一个线程访问
                String distributionID = salaryDistributionService.generateId(employeeRecord.getLevel1Id(), employeeRecord.getLevel2Id(), employeeRecord.getLevel3Id());
                String newDistributionID = time + distributionID.substring(6);
                System.out.println(newDistributionID);

                SalaryDistribution distribution = salaryDistributionService.getDistributionById(newDistributionID);
                SalaryStandard salaryStandard = salaryStandardService.getStandard(employeeRecord.getSalaryStandardId());

                if (distribution != null) {
                    distribution.setNumberOfEmployees(distribution.getNumberOfEmployees() + 1);
                    distribution.setTotalBaseSalary(distribution.getTotalBaseSalary() + salaryStandard.getBaseSalary());
                    salaryDistributionService.updateSalaryDistribution(distribution);
                } else {
                    salaryDistributionService.saveSalaryDistribution(new SalaryDistribution(
                            newDistributionID,
                            employeeRecord.getLevel1Id(),
                            employeeRecord.getLevel2Id(),
                            employeeRecord.getLevel3Id(),
                            1, // 初始员工数量为1
                            salaryStandard.getBaseSalary(), // 初始化总薪资
                            "待登记",
                            null,
                            null
                    ));
                }

                EmployeeCompensation employeeCompensation = employeeCompensationService.getEmployeeCompensationById(employeeRecord.getRecordId(), newDistributionID);
                if (employeeCompensation == null) {
                    employeeCompensationService.saveEmployeeCompensation(new EmployeeCompensation(
                            employeeRecord.getRecordId(),
                            employeeRecord.getSalaryStandardId(),
                            0.0,
                            0.0,
                            0.0,
                            newDistributionID,
                            salaryStandard.getBaseSalary(),
                            salaryStandard.getPensionInsurance(),
                            salaryStandard.getMedicalInsurance(),
                            salaryStandard.getUnemploymentInsurance(),
                            salaryStandard.getHousingFund()
                    ));
                }
            }
        }
        List<SalaryDistribution> salaryDistribution = salaryDistributionService.getSalaryDistributionById(time);
        model.addAttribute("salaryDistribution", salaryDistribution);
        return "salaryDistributionManagement"; // 返回薪资分配详情的视图
    }

}
