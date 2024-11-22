package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

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

    @GetMapping("/SalaryStandard")
    public String salaryStandardPage() {
        return "SalaryStandard";
    }

}
