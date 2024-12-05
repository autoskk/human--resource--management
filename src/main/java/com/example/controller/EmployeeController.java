package com.example.controller;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.example.pojo.*;
import com.example.service.EmployeeCompensationService;
import com.example.service.SalaryDistributionService;
import com.example.service.SalaryStandardService;
import com.example.service.UserService;
import com.example.service.impl.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.text.SimpleDateFormat;
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

    @Autowired
    private SalaryDistributionService salaryDistributionService;
    @Autowired
    private EmployeeCompensationService employeeCompensationService;

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
        model.addAttribute("salaryStandards", salaryStandardService.findApprovedSalaryStandards("已复核"));
        return "employee_register";
    }

    @PostMapping("/register")
    public String registerEmployee(@ModelAttribute EmployeeRecord employeeRecord,
                                   @RequestParam("photoUpload") MultipartFile file) {
        if (file != null && !file.isEmpty()) {
            String photoUrl = uploadFileToOSS(file); // 上传文件并获取URL
            employeeRecord.setPhotoUrl(photoUrl); // 设置图片URL
        }

        employeeService.addEmployee(employeeRecord); // 保存员工记录

        SalaryStandard salaryStandard = salaryStandardService.getStandard(employeeRecord.getSalaryStandardId());
        String distributionId = salaryDistributionService.generateId(employeeRecord.getLevel1Id(), employeeRecord.getLevel2Id(), employeeRecord.getLevel3Id());
        SalaryDistribution distribution = salaryDistributionService.getDistributionById(distributionId);
        if(distribution==null){
            distribution = new SalaryDistribution(distributionId,employeeRecord.getLevel1Id(),employeeRecord.getLevel2Id(),employeeRecord.getLevel3Id(),1,salaryStandard.getBaseSalary(),"待登记",null,null);
            salaryDistributionService.saveSalaryDistribution(distribution);
        }else{
            distribution.setNumberOfEmployees(distribution.getNumberOfEmployees()+1);
            distribution.setTotalBaseSalary(distribution.getTotalBaseSalary()+salaryStandard.getBaseSalary());
            salaryDistributionService.updateSalaryDistribution(distribution);
        }

        employeeCompensationService.saveEmployeeCompensation(new EmployeeCompensation(employeeRecord.getRecordId(),employeeRecord.getSalaryStandardId(),0.0,0.0,0.0,distributionId,salaryStandard.getBaseSalary(),salaryStandard.getPensionInsurance(),salaryStandard.getMedicalInsurance(),salaryStandard.getUnemploymentInsurance(),salaryStandard.getHousingFund()));


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
        SalaryStandard salaryStandard = salaryStandardService.getStandard(employee.getSalaryStandardId());


        model.addAttribute("standardName", salaryStandard != null ? salaryStandard.getStandardName() : "未找到");
        model.addAttribute("level1OrgName", level1Org != null ? level1Org.getLevel1Name() : "未找到");
//        model.addAttribute("level1OrgId", employee.getLevel1Id());
        model.addAttribute("level2OrgName", level2Org != null ? level2Org.getLevel2Name() : "未找到");
        model.addAttribute("level3OrgName", level3Org != null ? level3Org.getLevel3Name() : "未找到");
        model.addAttribute("categoryName", category != null ? category.getCategoryName() : "未找到");
        model.addAttribute("positionName", position != null ? position.getPositionName() : "未找到");
        model.addAttribute("userName", user != null ? user.getUserName() : "未找到");
        model.addAttribute("standardName", salaryStandard != null ? salaryStandard.getStandardName() : "未找到");
        model.addAttribute("salaryStandards", salaryStandardService.findApprovedSalaryStandards("已复核"));


        return "employee_update";  // 返回更新页面
    }

    @PostMapping("/update")
    public String updateEmployee(@ModelAttribute EmployeeRecord employeeRecord,
                                 @RequestParam(value = "photoUpload", required = false) MultipartFile file) {

        if (file != null && !file.isEmpty()) {
            String photoUrl = uploadFileToOSS(file); // 上传文件并获取URL
            employeeRecord.setPhotoUrl(photoUrl); // 设置图片URL
        }

        employeeRecord.setStatus(employeeRecord.getStatus());
        EmployeeRecord employee=employeeService.getEmployee(employeeRecord.getRecordId());

        if(employee.getSalaryStandardId()!=employeeRecord.getSalaryStandardId()){

            SalaryStandard newSalaryStandard = salaryStandardService.getStandard(employeeRecord.getSalaryStandardId());
            SalaryStandard salaryStandard = salaryStandardService.getStandard(employee.getSalaryStandardId());
            String distributionId = salaryDistributionService.generateId(employee.getLevel1Id(), employee.getLevel2Id(), employee.getLevel3Id());
            SalaryDistribution distribution = salaryDistributionService.getDistributionById(distributionId);

            if(distribution!=null){
                distribution.setTotalBaseSalary(distribution.getTotalBaseSalary()+newSalaryStandard.getBaseSalary()-salaryStandard.getBaseSalary());
                salaryDistributionService.updateSalaryDistribution(distribution);

                EmployeeCompensation employeeCompensation=employeeCompensationService.getEmployeeCompensationById(employeeRecord.getRecordId(),distributionId);
                employeeCompensation.setBaseSalary(newSalaryStandard.getBaseSalary());
                employeeCompensation.setSalaryStandardID(employeeRecord.getSalaryStandardId());
                employeeCompensationService.updateEmployeeCompensation(employeeCompensation);
            }
        }

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
        SalaryStandard salaryStandard = salaryStandardService.getStandard(employee.getSalaryStandardId());


        model.addAttribute("standardName", salaryStandard != null ? salaryStandard.getStandardName() : "未找到");
        model.addAttribute("level1OrgName", level1Org != null ? level1Org.getLevel1Name() : "未找到");
//        model.addAttribute("level1OrgId", employee.getLevel1Id());
        model.addAttribute("level2OrgName", level2Org != null ? level2Org.getLevel2Name() : "未找到");
        model.addAttribute("level3OrgName", level3Org != null ? level3Org.getLevel3Name() : "未找到");
        model.addAttribute("categoryName", category != null ? category.getCategoryName() : "未找到");
        model.addAttribute("positionName", position != null ? position.getPositionName() : "未找到");
        model.addAttribute("userName", user != null ? user.getUserName() : "未找到");
        model.addAttribute("standardName", salaryStandard != null ? salaryStandard.getStandardName() : "未找到");
        model.addAttribute("salaryStandards", salaryStandardService.findApprovedSalaryStandards("已复核"));


        return "employee_review_detail"; // 返回复核详细页面
    }

    // 处理复核操作
    @PostMapping("/review")
    public String processReview(@ModelAttribute EmployeeRecord employeeRecord,
                                @RequestParam(value = "photoUpload", required = false) MultipartFile file) {

        if (file != null && !file.isEmpty()) {
            String photoUrl = uploadFileToOSS(file); // 上传文件并获取URL
            employeeRecord.setPhotoUrl(photoUrl); // 设置图片URL
        }

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
