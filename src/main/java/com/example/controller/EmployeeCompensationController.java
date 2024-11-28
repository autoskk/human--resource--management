package com.example.controller;

import com.example.pojo.EmployeeCompensation;
import com.example.service.EmployeeCompensationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/employees/compensation")
public class EmployeeCompensationController {

    @Autowired
    private EmployeeCompensationService employeeCompensationService;

    @PostMapping
    public ResponseEntity<Void> createEmployeeCompensation(@RequestBody EmployeeCompensation employeeCompensation) {
        employeeCompensationService.saveEmployeeCompensation(employeeCompensation);
        return ResponseEntity.status(201).build(); // 201 Created
    }

    @GetMapping("/{employeeId}")
    public ResponseEntity<EmployeeCompensation> getEmployeeCompensation(@PathVariable String employeeId,@RequestParam  Integer distributionId) {
        System.out.println(employeeId);
        System.out.println(distributionId);
        EmployeeCompensation employeeCompensation = employeeCompensationService.getEmployeeCompensationById(employeeId,distributionId);
        System.out.println(employeeCompensation);
        return employeeCompensation != null ? ResponseEntity.ok(employeeCompensation) : ResponseEntity.notFound().build();
    }

    @GetMapping("/distribution/{distributionId}")
    public ResponseEntity< List<EmployeeCompensation>> getDistributionEmployeeCompensation(@PathVariable Integer distributionId ,Model model) {
        List<EmployeeCompensation> employeeCompensation = employeeCompensationService.getDistributionEmployeeCompensations(distributionId);
        return employeeCompensation != null ? ResponseEntity.ok(employeeCompensation) : ResponseEntity.notFound().build();
    }

    @GetMapping("/getEmployeeCompensation/{distributionId}")
    public String getEmployeeCompensation(@PathVariable Integer distributionId ,Model model) {
        List<EmployeeCompensation> employeeCompensation = employeeCompensationService.getDistributionEmployeeCompensations(distributionId);
        model.addAttribute("employeeCompensations", employeeCompensation);
        return "/createDistribution";
    }

    @GetMapping("/getEmployeeCompensationEdit/{distributionId}")
    public String getEmployeeCompensationEdit(@PathVariable Integer distributionId ,Model model) {
        List<EmployeeCompensation> employeeCompensation = employeeCompensationService.getDistributionEmployeeCompensations(distributionId);
        model.addAttribute("employeeCompensations", employeeCompensation);
        return "/editDistribution";
    }

    @GetMapping("/getEmployeeCompensationPending/{distributionId}")
    public String getEmployeeCompensationPending(@PathVariable Integer distributionId ,Model model) {
        List<EmployeeCompensation> employeeCompensation = employeeCompensationService.getDistributionEmployeeCompensations(distributionId);
        model.addAttribute("employeeCompensations", employeeCompensation);
        return "/pendingDistribution";
    }

    @PutMapping("/{employeeId}")
    public ResponseEntity<Void> updateEmployeeCompensation(@PathVariable String employeeId, @RequestBody EmployeeCompensation employeeCompensation) {
        employeeCompensation.setEmployeeId(employeeId); // 确保 ID 一致
        System.out.println(employeeId);

        employeeCompensationService.updateEmployeeCompensation(employeeCompensation);
        System.out.println(employeeCompensation);
        return ResponseEntity.ok().build(); // 200 OK
    }

    @DeleteMapping("/{employeeId}")
    public ResponseEntity<Void> deleteEmployeeCompensation(@PathVariable String employeeId ,@RequestParam  Integer distributionId) {
        employeeCompensationService.deleteEmployeeCompensation(employeeId,distributionId);
        return ResponseEntity.ok().build(); // 204 No Content
    }




}
