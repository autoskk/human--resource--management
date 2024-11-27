package com.example.service.impl;

import com.example.mapper.Level2OrganizationMapper;
import com.example.pojo.Level2Organization;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class Level2OrganizationService {
    @Autowired
    private Level2OrganizationMapper level2OrganizationMapper;

    public void addLevel2Organization(Level2Organization level2Organization) {
        level2OrganizationMapper.insertLevel2Organization(level2Organization);
    }

    public Level2Organization getLevel2Organization(int level2Id) {
        return level2OrganizationMapper.findById(level2Id);
    }

    public void editLevel2Organization(Level2Organization level2Organization) {
        level2OrganizationMapper.updateLevel2Organization(level2Organization);
    }

    public void deleteLevel2Organization(int level2Id) {
        level2OrganizationMapper.deleteLevel2Organization(level2Id);
    }

    // Level2OrganizationService
    public List<Level2Organization> getAllLevel2OrganizationsByLevel1Id(int level1Id) {
        return level2OrganizationMapper.findByLevel1Id(level1Id);
    }

    public List<Level2Organization> getAllLevel2Organizations() {
        return level2OrganizationMapper.findAll();
    }

    public Level2Organization getOrganizationById(Integer id) {
         return level2OrganizationMapper.findById(id);
    }
}
