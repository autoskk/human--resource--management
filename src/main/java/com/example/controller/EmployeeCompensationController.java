package com.example.controller;

import com.example.pojo.EmployeeCompensation;
import com.example.pojo.EmployeeRecord;
import com.example.service.EmployeeCompensationService;
import com.example.service.impl.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/employees/compensation")
public class EmployeeCompensationController {

    @Autowired
    private EmployeeCompensationService employeeCompensationService;
    @Autowired
    private EmployeeService employeeService;

    @PostMapping
    public ResponseEntity<Void> createEmployeeCompensation(@RequestBody EmployeeCompensation employeeCompensation) {
        employeeCompensationService.saveEmployeeCompensation(employeeCompensation);
        return ResponseEntity.status(201).build(); // 201 Created
    }

    @GetMapping("/search")
    public String getEmployeeCompensationByEmployeeIdANDTime(@RequestParam(required = false) String employeeId,@RequestParam(required = false)  String time,Model model) {
        System.out.println(employeeId);
        System.out.println(time);
        List<EmployeeCompensation> employeeCompensation = employeeCompensationService.getEmployeeCompensationByEmployeeId(employeeId);
//        System.out.println(employeeCompensation);
        Set<EmployeeCompensation> result=new HashSet<>();
        if(employeeCompensation!=null){
            result.addAll(employeeCompensation);
        }
        List<EmployeeCompensation> temp=employeeCompensationService.getAllEmployeeCompensations();
        for(EmployeeCompensation employeeCompensation1:temp){
                if(employeeCompensation1.getDistributionId().substring(0,6).equals(time)){
                    result.add(employeeCompensation1);
                }
        }

        if((time==null||time.isEmpty())&&(employeeId==null||employeeId.isEmpty())){
            List<EmployeeCompensation>result1 = employeeCompensationService.getAllEmployeeCompensations();
            result.addAll(result1);
        }
        List<EmployeeCompensation> employeeCompensations=result.stream().collect(Collectors.toList());
        System.out.println(employeeCompensations);
        model.addAttribute("employeeCompensations", employeeCompensations);

        return "searchEmployeeCompensation";
    }

    @GetMapping("/searchEmployeeCompensation")
    public ResponseEntity<List<EmployeeCompensation>> searchEmployeeCompensationByEmployeeIdANDTime(
            @RequestParam(required = false) String employeeId,@RequestParam(required = false)  String time) {

        System.out.println("Employee ID: " + employeeId);
        System.out.println("Time: " + time);

        List<EmployeeCompensation> employeeCompensation = employeeCompensationService.getEmployeeCompensationByEmployeeId(employeeId);
//        System.out.println(employeeCompensation);
        Set<EmployeeCompensation> result=new HashSet<>();
        if(employeeCompensation!=null){
            result.addAll(employeeCompensation);
        }
        List<EmployeeCompensation> temp=employeeCompensationService.getAllEmployeeCompensations();
        for(EmployeeCompensation employeeCompensation1:temp){
            if(employeeCompensation1.getDistributionId().substring(0,6).equals(time)){
                result.add(employeeCompensation1);
            }
        }

        if((time==null||time.isEmpty())&&(employeeId==null||employeeId.isEmpty())){
            List<EmployeeCompensation>result1 = employeeCompensationService.getAllEmployeeCompensations();
            result.addAll(result1);
        }
        List<EmployeeCompensation> employeeCompensations=result.stream().collect(Collectors.toList());
        System.out.println(employeeCompensations);
        return ResponseEntity.ok(employeeCompensations); // 无论是空的或是非空的，始终返回一个有效的列表
    }

    @GetMapping("/{employeeId}")
    public ResponseEntity<EmployeeCompensation> getEmployeeCompensation(@PathVariable String employeeId,@RequestParam  String distributionId) {
//        System.out.println(employeeId);
//        System.out.println(distributionId);
        EmployeeCompensation employeeCompensation = employeeCompensationService.getEmployeeCompensationById(employeeId,distributionId);
//        System.out.println(employeeCompensation);
        return employeeCompensation != null ? ResponseEntity.ok(employeeCompensation) : ResponseEntity.notFound().build();
    }
    @GetMapping("/distribution/{distributionId}")
    public ResponseEntity< List<EmployeeCompensation>> getDistributionEmployeeCompensation(@PathVariable String distributionId ,Model model) {
        List<EmployeeCompensation> employeeCompensation = employeeCompensationService.getDistributionEmployeeCompensations(distributionId);
        return employeeCompensation != null ? ResponseEntity.ok(employeeCompensation) : ResponseEntity.notFound().build();
    }

    @GetMapping("/getEmployeeCompensation/{distributionId}")
    public String getEmployeeCompensation(@PathVariable String distributionId ,Model model) {
        List<EmployeeCompensation> employeeCompensation = employeeCompensationService.getDistributionEmployeeCompensations(distributionId);
        model.addAttribute("employeeCompensations", employeeCompensation);
        return "/createDistribution";
    }

    @GetMapping("/getEmployeeCompensationEdit/{distributionId}")
    public String getEmployeeCompensationEdit(@PathVariable String distributionId ,Model model) {
        List<EmployeeCompensation> employeeCompensation = employeeCompensationService.getDistributionEmployeeCompensations(distributionId);
        model.addAttribute("employeeCompensations", employeeCompensation);
        List<EmployeeRecord> employees = employeeService.getAllEmployees();
        model.addAttribute("employees", employees);
        return "/editDistribution";
    }


    @GetMapping("/getEmployeeCompensationPending/{distributionId}")
    public String getEmployeeCompensationPending(@PathVariable String distributionId ,Model model) {
        List<EmployeeCompensation> employeeCompensation = employeeCompensationService.getDistributionEmployeeCompensations(distributionId);
        model.addAttribute("employeeCompensations", employeeCompensation);
        List<EmployeeRecord> employees = employeeService.getAllEmployees();
        model.addAttribute("employees", employees);
        return "/pendingDistribution";
    }

    @PutMapping("/{employeeId}")
    public ResponseEntity<Void> updateEmployeeCompensation(@PathVariable String employeeId, @RequestBody EmployeeCompensation employeeCompensation) {
        employeeCompensation.setEmployeeId(employeeId); // 确保 ID 一致
//        System.out.println(employeeId);

        employeeCompensationService.updateEmployeeCompensation(employeeCompensation);
//        System.out.println(employeeCompensation);
        return ResponseEntity.ok().build(); // 200 OK
    }

    @DeleteMapping("/{employeeId}")
    public ResponseEntity<Void> deleteEmployeeCompensation(@PathVariable String employeeId ,@RequestParam  String distributionId) {
        employeeCompensationService.deleteEmployeeCompensation(employeeId,distributionId);
        return ResponseEntity.ok().build(); // 204 No Content
    }


    @GetMapping
    public ResponseEntity<List<EmployeeRecord>> getEmployeeIds() {
        List<EmployeeRecord> employees = employeeService.getAllEmployees();// 替换为您实际的服务调用
//        System.out.println(employees);
        return ResponseEntity.ok(employees);
    }

}
