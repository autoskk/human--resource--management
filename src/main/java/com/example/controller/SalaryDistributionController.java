package com.example.controller;

import com.example.pojo.SalaryDistribution;
import com.example.service.SalaryDistributionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/salary-distributions")
public class SalaryDistributionController {

    @Autowired
    private SalaryDistributionService salaryDistributionService;

    @PostMapping
    public ResponseEntity<Void> createSalaryDistribution(@RequestBody SalaryDistribution salaryDistribution) {
        salaryDistributionService.saveSalaryDistribution(salaryDistribution);
        return ResponseEntity.status(201).build(); // 201 Created
    }

    @GetMapping("/{id}")
    public ResponseEntity<SalaryDistribution> getSalaryDistribution(@PathVariable Integer id) {
        SalaryDistribution salaryDistribution = salaryDistributionService.getSalaryDistributionById(id);
        return salaryDistribution != null ? ResponseEntity.ok(salaryDistribution) : ResponseEntity.notFound().build();
    }

    @PutMapping("/{id}")
    public ResponseEntity<Void> updateSalaryDistribution(@PathVariable Integer id, @RequestBody SalaryDistribution salaryDistribution) {
        salaryDistribution.setDistributionID(id); // 确保 ID 一致
        salaryDistributionService.updateSalaryDistribution(salaryDistribution);
        return ResponseEntity.ok().build(); // 200 OK
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteSalaryDistribution(@PathVariable Integer id) {
        salaryDistributionService.deleteSalaryDistribution(id);
        return ResponseEntity.noContent().build(); // 204 No Content
    }

    @GetMapping("/pending")
    public ResponseEntity<List<SalaryDistribution>> getPendingDistributions() {
        List<SalaryDistribution> pendingDistributions = salaryDistributionService.getPendingDistributions();
        return ResponseEntity.ok(pendingDistributions);
    }
}
