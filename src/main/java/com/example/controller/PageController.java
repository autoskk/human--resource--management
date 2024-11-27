package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

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

    @GetMapping("/salaryManagement")
    public String salaryManagementPage() {
        return "salaryManagement";
    }

    @GetMapping("/salaryStandardManagement")
    public String salaryStandardManagementPage() {
        return "salaryStandardManagement";
    }

    @GetMapping("/salaryDistributionManagement")
    public String salaryDistributionManagementPage() {
        return "salaryDistributionManagement";
    }

    @GetMapping("/createSalaryStandard")
    public String createSalaryStandardPage() {
        return "createSalaryStandard";
    }

    @GetMapping("/createDistribution")
    public String createDistributionPage() {
        return "createDistribution";
    }
}
