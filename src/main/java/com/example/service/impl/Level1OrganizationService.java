package com.example.service.impl;

import com.example.mapper.Level1OrganizationMapper;
import com.example.pojo.Level1Organization;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class Level1OrganizationService {
    @Autowired
    private Level1OrganizationMapper level1OrganizationMapper;

    public void addLevel1Organization(Level1Organization level1Organization) {
        level1OrganizationMapper.insertLevel1Organization(level1Organization);
    }

    public Level1Organization getLevel1Organization(int level1Id) {
        return level1OrganizationMapper.findById(level1Id);
    }

    public void editLevel1Organization(Level1Organization level1Organization) {
        level1OrganizationMapper.updateLevel1Organization(level1Organization);
    }

    public void deleteLevel1Organization(int level1Id) {
        level1OrganizationMapper.deleteLevel1Organization(level1Id);
    }

    public List<Level1Organization> getAllLevel1Organizations() {
        return level1OrganizationMapper.findAll();
    }

    public Level1Organization getOrganizationById(Integer id) {
        return level1OrganizationMapper.findById(id);
    }
}
