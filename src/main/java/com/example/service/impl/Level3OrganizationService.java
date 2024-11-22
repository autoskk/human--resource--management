package com.example.service.impl;

import com.example.mapper.Level3OrganizationMapper;
import com.example.pojo.Level3Organization;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class Level3OrganizationService {
    @Autowired
    private Level3OrganizationMapper level3OrganizationMapper;

    public void addLevel3Organization(Level3Organization level3Organization) {
        level3OrganizationMapper.insertLevel3Organization(level3Organization);
    }

    public Level3Organization getLevel3Organization(int level3Id) {
        return level3OrganizationMapper.findById(level3Id);
    }

    public List<Level3Organization> getAllLevel3OrganizationsByLevel2Id(int level2Id) {
        return level3OrganizationMapper.findByLevel2Id(level2Id);
    }

    public void editLevel3Organization(Level3Organization level3Organization) {
        level3OrganizationMapper.updateLevel3Organization(level3Organization);
    }

    public void deleteLevel3Organization(int level3Id) {
        level3OrganizationMapper.deleteLevel3Organization(level3Id);
    }

    public List<Level3Organization> getAllLevel3Organizations() {
        return level3OrganizationMapper.findAll();
    }
}
