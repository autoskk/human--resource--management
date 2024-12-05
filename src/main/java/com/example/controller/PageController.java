package com.example.controller;

import com.example.pojo.EmployeeCompensation;
import com.example.pojo.EmployeeRecord;
import com.example.pojo.Level1Organization;
import com.example.pojo.PositionCategory;
import com.example.service.EmployeeCompensationService;
import com.example.service.SalaryStandardService;
import com.example.service.impl.EmployeeService;
import com.example.service.impl.Level1OrganizationService;
import com.example.service.impl.PositionCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class PageController {

    @Autowired
    private Level1OrganizationService level1OrganizationService;
    @Autowired
    private PositionCategoryService positionCategoryService;
    @Autowired
    private SalaryStandardService salaryStandardService;
    @Autowired
    private EmployeeService employeeService;
    @Autowired
    private EmployeeCompensationService employeeCompensationService;

    @GetMapping("/index")
    public String indexPage() {
        return "index"; // 返回 login.jsp
    }

    @GetMapping("/login")
    public String loginPage() {
        return "login"; // 返回 login.jsp
    }
    @GetMapping("/register")
    public String registerPage() {
        return "register"; // 返回 register.jsp
    }

    @GetMapping("/reset-password")
    public String resetPasswordPage() {
        return "reset_password"; // 返回 reset_password.jsp
    }

    @GetMapping("/salaryStandardManagement")
    public String salaryStandardManagementPage() {
        return "salaryStandardManagementPage";
    }
    @GetMapping("/salaryDistributionManagement")
    public String salaryDistributionManagementPage() {
        return "salaryDistributionManagementPage";
    }

    @GetMapping("/createSalaryStandard")
    public String createSalaryStandardPage() {
        return "createSalaryStandard";
    }

    @GetMapping("/createDistribution")
    public String createDistributionPage(Model model) {
        // 获取一级机构、二级机构、职位类别的数据，用于下拉框展示
        List<Level1Organization> level1Organizations = level1OrganizationService.getAllLevel1Organizations();
        List<PositionCategory> positionCategories = positionCategoryService.getAllPositionCategories();
        List<EmployeeRecord> employees = employeeService.getAllEmployees();
        model.addAttribute("employees", employees);
        model.addAttribute("level1Organizations", level1Organizations);
        model.addAttribute("positionCategories", positionCategories);
        return "createDistribution";
    }
    @GetMapping("/editDistribution")
    public String editDistributionPage(Model model) {
        // 获取一级机构、二级机构、职位类别的数据，用于下拉框展示
        List<Level1Organization> level1Organizations = level1OrganizationService.getAllLevel1Organizations();
        List<PositionCategory> positionCategories = positionCategoryService.getAllPositionCategories();
        List<EmployeeRecord> employees = employeeService.getAllEmployees();
        model.addAttribute("employees", employees);
        model.addAttribute("level1Organizations", level1Organizations);
        model.addAttribute("positionCategories", positionCategories);

        return "editDistribution";


    }
    @GetMapping("/searchEmployeeCompensation")
    public String searchEmployeeCompensationPage(Model model) {

        List<EmployeeCompensation> employeeCompensations = employeeCompensationService.getAllEmployeeCompensations();

        model.addAttribute("employeeCompensations", employeeCompensations);

        return "searchEmployeeCompensation";
    }
}
