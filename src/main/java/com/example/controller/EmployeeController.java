package com.example.controller;

import com.example.pojo.*;
//<<<<<<< HEAD
import com.example.service.SalaryStandardService;
import com.example.service.UserService;
//=======
//>>>>>>> ca48bc6ac24878be5ebe8e624b2776f9cb3e0292
import com.example.service.impl.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

//<<<<<<< HEAD
import java.text.SimpleDateFormat;
import java.util.ArrayList;
//=======
//>>>>>>> ca48bc6ac24878be5ebe8e624b2776f9cb3e0292
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
    private SalaryStandardService salaryStandardService; // 添加这一行

    @Autowired
    private UserService userService; // 添加这一行

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
        model.addAttribute("salaryStandards", salaryStandardService.findApprovedSalaryStandards());
        return "employee_register";
    }


    @PostMapping("/register")
    public String registerEmployee(@ModelAttribute EmployeeRecord employeeRecord,
                                   @RequestParam("photoUrl") String photoUrl) {
        // 这里可以进行进一步处理，例如处理上传的 Base64 数据
        employeeRecord.setPhotoUrl(photoUrl); // 设置 photoUrl
        employeeService.addEmployee(employeeRecord);
//<<<<<<< HEAD
        System.out.println(employeeRecord);
//=======

        //添加逻辑
        //添加机构发放单记录和员工薪酬记录
//>>>>>>> ca48bc6ac24878be5ebe8e624b2776f9cb3e0292
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


    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        dateFormat.setLenient(false); // 不允许不严格的日期格式
        binder.registerCustomEditor(Date.class, "createdDate", new CustomDateEditor(dateFormat, true));
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
        User user = userService.getUserById((long) employee.getCreatedBy());
        SalaryStandard salaryStandard =  salaryStandardService.getStandard(employee.getSalaryStandardId());


        model.addAttribute("standardName", salaryStandard != null ? salaryStandard.getStandardName() : "未找到");
        model.addAttribute("level1OrgName", level1Org != null ? level1Org.getLevel1Name() : "未找到");
//        model.addAttribute("level1OrgId", employee.getLevel1Id());
        model.addAttribute("level2OrgName", level2Org != null ? level2Org.getLevel2Name() : "未找到");
        model.addAttribute("level3OrgName", level3Org != null ? level3Org.getLevel3Name() : "未找到");
        model.addAttribute("categoryName", category != null ? category.getCategoryName() : "未找到");
        model.addAttribute("positionName", position != null ? position.getPositionName() : "未找到");
        model.addAttribute("userName", user != null ? user.getUserName() : "未找到");
        model.addAttribute("standardName", salaryStandard != null ? salaryStandard.getStandardName() : "未找到");
        model.addAttribute("salaryStandards", salaryStandardService.findApprovedSalaryStandards());


        return "employee_update";  // 返回更新页面
    }

    @PostMapping("/update")
    public String updateEmployee(@ModelAttribute EmployeeRecord employeeRecord) {


        // 验证传入的组织层次ID是否有效
        if (level1OrganizationService.getLevel1Organization(employeeRecord.getLevel1Id()) == null) {
            throw new IllegalArgumentException("一级机构不存在");
        }
        if (level2OrganizationService.getLevel2Organization(employeeRecord.getLevel2Id()) == null) {
            throw new IllegalArgumentException("二级机构不存在");
        }
        if (level3OrganizationService.getLevel3Organization(employeeRecord.getLevel3Id()) == null) {
            throw new IllegalArgumentException("三级机构不存在");
        }

        employeeRecord.setStatus(employeeRecord.getStatus());
        employeeService.editEmployee(employeeRecord);
        System.out.println(employeeRecord);
        return "redirect:/employee/list"; // 更新后重定向到员工列表
    }


    @PostMapping("/delete")
    public String deleteEmployee(@RequestParam String recordId) {
        try {
            employeeService.softDeleteEmployee(recordId);
        } catch (IllegalArgumentException e) {
            // 处理错误，例如返回错误信息到页面
        }
        return "redirect:/employee/list"; // 重定向到员工列表
    }


    @PostMapping("/restore")
    public String restoreEmployee(@RequestParam String recordId) {
        try {
            employeeService.restoreEmployee(recordId);
        } catch (IllegalArgumentException e) {
            // 处理错误，例如返回错误信息到页面
        }
        return "redirect:/employee/list"; // 重定向到员工列表
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
        User user = userService.getUserById((long) employee.getCreatedBy());
        SalaryStandard salaryStandard =  salaryStandardService.getStandard(employee.getSalaryStandardId());


        model.addAttribute("standardName", salaryStandard != null ? salaryStandard.getStandardName() : "未找到");
        model.addAttribute("level1OrgName", level1Org != null ? level1Org.getLevel1Name() : "未找到");
//        model.addAttribute("level1OrgId", employee.getLevel1Id());
        model.addAttribute("level2OrgName", level2Org != null ? level2Org.getLevel2Name() : "未找到");
        model.addAttribute("level3OrgName", level3Org != null ? level3Org.getLevel3Name() : "未找到");
        model.addAttribute("categoryName", category != null ? category.getCategoryName() : "未找到");
        model.addAttribute("positionName", position != null ? position.getPositionName() : "未找到");
        model.addAttribute("userName", user != null ? user.getUserName() : "未找到");
        model.addAttribute("standardName", salaryStandard != null ? salaryStandard.getStandardName() : "未找到");
        model.addAttribute("salaryStandards", salaryStandardService.findApprovedSalaryStandards());


        return "employee_review_detail"; // 返回复核详细页面
    }

    // 处理复核操作
    @PostMapping("/review")
    public String processReview(@ModelAttribute EmployeeRecord employeeRecord) {
        employeeRecord.setStatus("正常"); // 将状态修改为正常
        employeeService.editEmployee(employeeRecord); // 保存修改
        return "redirect:/employee/review"; // 复核后重定向到复核列表
    }



//<<<<<<< HEAD

//=======
    @GetMapping("/level1")
    @ResponseBody
    public List<Level1Organization> getLevel1Organizations() {
        return level1OrganizationService.getAllLevel1Organizations();
    }
//>>>>>>> ca48bc6ac24878be5ebe8e624b2776f9cb3e0292
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
