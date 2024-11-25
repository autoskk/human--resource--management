package com.example.controller;

import com.example.pojo.*;
import com.example.service.impl.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    @Autowired
    private Level1OrganizationService level1OrganizationService;

    @Autowired
    private Level2OrganizationService level2OrganizationService; // 添加这一行

    @Autowired
    private Level3OrganizationService level3OrganizationService; // 添加这一行

    @Autowired
    private PositionCategoryService positionCategoryService;

    @Autowired
    private PositionService positionService; // 添加这一行

    @Autowired
    private SalaryStandardServiceImpl salaryStandardService; // 添加这一行

    // 主页
    @GetMapping("/")
    public String index() {
        return "index";  // 返回主页
    }

    // 返回主页
    @GetMapping("/home")
    public String home() {
        return "index";  // 主页链接
    }

    // 人力资源档案登记
    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("level1Organizations", level1OrganizationService.getAllLevel1Organizations());
        model.addAttribute("positionCategories", positionCategoryService.getAllPositionCategories());
        model.addAttribute("salaryStandards", salaryStandardService.getAllSalaryStandardsById()); // 省略的服务调用
        return "employee_register";
    }


    @PostMapping("/register")
    public String registerEmployee(@ModelAttribute EmployeeRecord employeeRecord) {
        employeeService.addEmployee(employeeRecord);
        return "redirect:/employee/list"; // 提交后重定向到员工列表
    }



    // 人力资源档案列表
    @GetMapping("/list")
    public String listEmployees(@RequestParam(required = false) Integer level1Id,
                                @RequestParam(required = false) Integer level2Id,
                                @RequestParam(required = false) Integer level3Id,
                                @RequestParam(required = false) Integer categoryId,
                                @RequestParam(required = false) Integer positionId,
                                @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
                                @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate,
                                Model model) {
        List<EmployeeRecord> employees = employeeService.searchEmployees(level1Id, level2Id, level3Id,
                categoryId, positionId, startDate, endDate);

        model.addAttribute("level1Organizations", level1OrganizationService.getAllLevel1Organizations());
        model.addAttribute("positionCategories", positionCategoryService.getAllPositionCategories());

        if (level1Id != null) {
            List<Level2Organization> level2s = level2OrganizationService.getAllLevel2OrganizationsByLevel1Id(level1Id);
            model.addAttribute("level2Organizations", level2s);
        }

        if (level2Id != null) {
            List<Level3Organization> level3s = level3OrganizationService.getAllLevel3OrganizationsByLevel2Id(level2Id);
            model.addAttribute("level3Organizations", level3s);
        }

        model.addAttribute("employees", employees);
        return "employee_list";  // 返回员工列表
    }


    // 人力资源档案变更
    @GetMapping("/update")
    public String showUpdateForm(@RequestParam String recordId, Model model) {
        EmployeeRecord employee = employeeService.getEmployee(recordId);

        model.addAttribute("employee", employee);

        // 通过id获取名称，直接传递中文名称给JSP
        Level1Organization level1Org = level1OrganizationService.getLevel1Organization(employee.getLevel1Id());
        Level2Organization level2Org = level2OrganizationService.getLevel2Organization(employee.getLevel2Id());
        Level3Organization level3Org = level3OrganizationService.getLevel3Organization(employee.getLevel3Id());
        PositionCategory category = positionCategoryService.getPositionCategory(employee.getCategoryId());
        Position position = positionService.getPosition(employee.getPositionId());

        model.addAttribute("level1OrgName", level1Org != null ? level1Org.getLevel1Name() : "未找到");
        model.addAttribute("level2OrgName", level2Org != null ? level2Org.getLevel2Name() : "未找到");
        model.addAttribute("level3OrgName", level3Org != null ? level3Org.getLevel3Name() : "未找到");
        model.addAttribute("categoryName", category != null ? category.getCategoryName() : "未找到");
        model.addAttribute("positionName", position != null ? position.getPositionName() : "未找到");

        return "employee_update";  // 返回更新页面
    }

    @PostMapping("/update")
    public String updateEmployee(@ModelAttribute EmployeeRecord employeeRecord) {
        employeeService.editEmployee(employeeRecord);
        return "redirect:/employee/list"; // 更新后重定向到员工列表
    }


    // 人力资源档案复核
    // 人力资源档案复核
    @GetMapping("/review")
    public String reviewEmployees(Model model) {
        List<EmployeeRecord> pendingReviews = employeeService.getPendingEmployees();
        model.addAttribute("pendingReviews", pendingReviews);
        return "employee_review";  // 返回复核页面
    }

    // 复核员工档案
    @GetMapping("/review/{recordId}")
    public String showReviewForm(@PathVariable String recordId, Model model) {
        EmployeeRecord employee = employeeService.getEmployee(recordId);

        model.addAttribute("employee", employee);

        // 通过id获取名称，直接传递中文名称给JSP
        Level1Organization level1Org = level1OrganizationService.getLevel1Organization(employee.getLevel1Id());
        Level2Organization level2Org = level2OrganizationService.getLevel2Organization(employee.getLevel2Id());
        Level3Organization level3Org = level3OrganizationService.getLevel3Organization(employee.getLevel3Id());
        PositionCategory category = positionCategoryService.getPositionCategory(employee.getCategoryId());
        Position position = positionService.getPosition(employee.getPositionId());

        model.addAttribute("level1OrgName", level1Org != null ? level1Org.getLevel1Name() : "未找到");
        model.addAttribute("level2OrgName", level2Org != null ? level2Org.getLevel2Name() : "未找到");
        model.addAttribute("level3OrgName", level3Org != null ? level3Org.getLevel3Name() : "未找到");
        model.addAttribute("categoryName", category != null ? category.getCategoryName() : "未找到");
        model.addAttribute("positionName", position != null ? position.getPositionName() : "未找到");


        return "employee_review_detail"; // 返回复核详细页面
    }

    // 处理复核操作
    @PostMapping("/review")
    public String processReview(@RequestParam String recordId, @RequestParam boolean approve) {
        EmployeeRecord employee = employeeService.getEmployee(recordId);
        employee.setStatus("已复核"); // 将状态修改为已复核

        // 这里可以加入额外的条件逻辑，保存审核的决定
        if (!approve) {
            // 处理拒绝逻辑，例如记录原因等
        }

        employeeService.editEmployee(employee); // 保存修改
        return "redirect:/employee/review"; // 复核后重定向到复核列表
    }


    @GetMapping("/level2")
    @ResponseBody
    public List<Level2Organization> getLevel2Organizations(@RequestParam int level1Id) {
        return level2OrganizationService.getAllLevel2OrganizationsByLevel1Id(level1Id);
    }

    @GetMapping("/level3")
    @ResponseBody
    public List<Level3Organization> getLevel3Organizations(@RequestParam int level2Id) {
        return level3OrganizationService.getAllLevel3OrganizationsByLevel2Id(level2Id);
    }

    @GetMapping("/positions")
    @ResponseBody
    public List<Position> getPositions(@RequestParam int categoryId) {
        return positionService.getPositionsByCategoryId(categoryId);
    }





}
