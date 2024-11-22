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

    // 显示薪酬标准列表页面
    @GetMapping("/SalaryStandardList")
    public String salaryStandardListPage() {
        return "SalaryStandardList"; // 返回 SalaryStandardList.jsp
    }

    // 显示创建薪酬标准页面
    @GetMapping("/SalaryStandardCreate")
    public String salaryStandardCreatePage() {
        return "SalaryStandardCreate"; // 返回 SalaryStandardCreate.jsp
    }

    // 显示审核薪酬标准页面
    @GetMapping("/SalaryStandardReview")
    public String salaryStandardReviewPage() {
        return "SalaryStandardReview"; // 返回 SalaryStandardReview.jsp
    }

    // 显示搜索薪酬标准页面
    @GetMapping("/SalaryStandardSearch")
    public String salaryStandardSearchPage() {
        return "SalaryStandardSearch"; // 返回 SalaryStandardSearch.jsp
    }

    @GetMapping("/SalaryStandard")
    public String salaryStandardPage() {
        return "SalaryStandard";
    }

}
