package com.example.service.impl;

import com.example.mapper.PositionCategoryMapper;
import com.example.pojo.PositionCategory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PositionCategoryService {
    @Autowired
    private PositionCategoryMapper positionCategoryMapper;

    public void addPositionCategory(PositionCategory positionCategory) {
        positionCategoryMapper.insertPositionCategory(positionCategory);
    }

    public PositionCategory getPositionCategory(int categoryId) {
        return positionCategoryMapper.findById(categoryId);
    }

    public void editPositionCategory(PositionCategory positionCategory) {
        positionCategoryMapper.updatePositionCategory(positionCategory);
    }

    public void deletePositionCategory(int categoryId) {
        positionCategoryMapper.deletePositionCategory(categoryId);
    }

    public List<PositionCategory> getAllPositionCategories() {
        return positionCategoryMapper.findAll();
    }
}
