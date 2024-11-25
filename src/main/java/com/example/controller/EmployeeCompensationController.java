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
    public ResponseEntity<EmployeeCompensation> getEmployeeCompensation(@PathVariable String employeeId) {
        EmployeeCompensation employeeCompensation = employeeCompensationService.getEmployeeCompensationById(employeeId);
        return employeeCompensation != null ? ResponseEntity.ok(employeeCompensation) : ResponseEntity.notFound().build();
    }

    @GetMapping("/distribution/{distributionId}")
    public String getDistributionEmployeeCompensation(@PathVariable Integer distributionId ,Model model) {
        List<EmployeeCompensation> employeeCompensation = employeeCompensationService.getDistributionEmployeeCompensations(distributionId);
        model.addAttribute("employeeCompensations", employeeCompensation);
        return "createDistribution";
    }

    @PutMapping("/{employeeId}")
    public ResponseEntity<Void> updateEmployeeCompensation(@PathVariable String employeeId, @RequestBody EmployeeCompensation employeeCompensation) {
        employeeCompensation.setEmployeeId(employeeId); // 确保 ID 一致
        employeeCompensationService.updateEmployeeCompensation(employeeCompensation);
        return ResponseEntity.ok().build(); // 200 OK
    }

    @DeleteMapping("/{employeeId}")
    public ResponseEntity<Void> deleteEmployeeCompensation(@PathVariable String employeeId) {
        employeeCompensationService.deleteEmployeeCompensation(employeeId);
        return ResponseEntity.noContent().build(); // 204 No Content
    }

}
