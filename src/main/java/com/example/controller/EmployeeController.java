package com.example.controller;

import com.example.pojo.*;
import com.example.service.impl.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
        return "employee_register";  // 返回注册页面
    }

    @PostMapping("/register")
    public String registerEmployee(@ModelAttribute EmployeeRecord employeeRecord) {
        employeeService.addEmployee(employeeRecord);

        //添加逻辑
        //添加机构发放单记录和员工薪酬记录
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

        // 获取一级机构、二级机构、职位类别的数据，用于下拉框展示
        List<Level1Organization> level1Organizations = level1OrganizationService.getAllLevel1Organizations();
        List<PositionCategory> positionCategories = positionCategoryService.getAllPositionCategories();

        model.addAttribute("employees", employees);
        model.addAttribute("level1Organizations", level1Organizations);
        model.addAttribute("positionCategories", positionCategories);

        return "employee_list";  // 返回员工列表
    }


    // 人力资源档案变更
    @GetMapping("/update")
    public String showUpdateForm(@RequestParam String recordId, Model model) {
        EmployeeRecord employee = employeeService.getEmployee(recordId);
        model.addAttribute("employee", employee);
        return "employee_update";  // 返回更新页面
    }

    @PostMapping("/update")
    public String updateEmployee(@ModelAttribute EmployeeRecord employeeRecord) {
        employeeService.editEmployee(employeeRecord);
        return "redirect:/employee/list"; // 更新后重定向到员工列表
    }

    // 人力资源档案复核
    @GetMapping("/review")
    public String reviewEmployees(Model model) {
        List<EmployeeRecord> pendingReviews = employeeService.getPendingEmployees();
        model.addAttribute("pendingReviews", pendingReviews);
        return "employee_review";  // 返回复核页面
    }

    @PostMapping("/review")
    public String reviewEmployee(@RequestParam String recordId, @RequestParam boolean approve) {
        EmployeeRecord employee = employeeService.getEmployee(recordId);
        if (approve) {
            employee.setStatus("正常"); // 修改状态为正常
        } else {
            employee.setStatus("已删除"); // 修改状态为已删除
        }
        employeeService.editEmployee(employee);
        return "redirect:/employee/review"; // 复核后重定向到复核列表
    }

    @GetMapping("/level1")
    @ResponseBody
    public List<Level1Organization> getLevel1Organizations() {
        return level1OrganizationService.getAllLevel1Organizations();
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


    @GetMapping("/getCount")
    public String getCountEmployeesByLevel(@RequestParam Integer level1Id,
                                @RequestParam Integer level2Id,
                                @RequestParam Integer level3Id
                              ) {
        Integer Count = employeeService.countEmployeesByLevel(level1Id, level2Id, level3Id);
        System.out.println(Count);
        return String.valueOf(Count != null ? Count : 0.0); // 处理 null
    }

    @GetMapping("/getTotalBaseSalary")
    public String getTotalBaseSalary(@RequestParam Integer level1Id,
                                        @RequestParam Integer level2Id,
                                        @RequestParam Integer level3Id
    ) {
        Double total = employeeService.calculateTotalBaseSalary(level1Id, level2Id, level3Id);
        System.out.println(total);
        return String.valueOf(total != null ? total : 0.0); // 处理 null
    }

    @GetMapping("/{recordId}")
    public ResponseEntity<EmployeeRecord> getEmployeeRecord(@PathVariable String recordId) {
        EmployeeRecord employee = employeeService.getEmployee(recordId);
        //System.out.println(employee);
        // Check if salaryStandard exists
        if (employee == null) {
            return ResponseEntity.notFound().build(); // Return 404 Not Found if standard doesn't exist
        }

        return ResponseEntity.ok(employee); // Return the salary standard as JSON
    }



}
