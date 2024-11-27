package com.example.controller;

import com.example.pojo.Level1Organization;
import com.example.pojo.Level2Organization;
import com.example.pojo.Level3Organization;
import com.example.service.impl.Level1OrganizationService;
import com.example.service.impl.Level2OrganizationService;
import com.example.service.impl.Level3OrganizationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
@Controller
@RequestMapping("/organizations")
public class OrganizationController {

    @Autowired
    private Level1OrganizationService level1OrganizationService;

    @Autowired
    private Level2OrganizationService level2OrganizationService; // 添加这一行

    @Autowired
    private Level3OrganizationService level3OrganizationService; // 添加这一行

    // 根据一级机构 ID 获取名称
    @GetMapping("/level1/{id}")
    @ResponseBody
    public String getLevel1OrganizationName(@PathVariable Integer id) {
        Level1Organization organization = level1OrganizationService.getOrganizationById(id);
       // System.out.println(organization);
        return organization != null ? organization.getLevel1Name() : "";
    }

    // 根据二级机构 ID 获取名称
    @GetMapping("/level2/{id}")
    @ResponseBody
    public String getLevel2OrganizationName(@PathVariable Integer id) {
        Level2Organization organization = level2OrganizationService.getOrganizationById(id);
       // System.out.println(organization);
        return organization != null ? organization.getLevel2Name() : "";
    }

    // 根据三级机构 ID 获取名称
    @GetMapping("/level3/{id}")
    @ResponseBody
    public String getLevel3OrganizationName(@PathVariable Integer id) {
        Level3Organization organization = level3OrganizationService.getOrganizationById(id);
      //  System.out.println(organization);
        return organization != null ? organization.getLevel3Name() : "";
    }
}
