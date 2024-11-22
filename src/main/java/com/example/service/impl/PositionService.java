package com.example.service.impl;

import com.example.mapper.PositionMapper;
import com.example.pojo.Position;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PositionService {
    @Autowired
    private PositionMapper positionMapper;

    public void addPosition(Position position) {
        positionMapper.insertPosition(position);
    }

    public Position getPosition(int positionId) {
        return positionMapper.findById(positionId);
    }

    public void editPosition(Position position) {
        positionMapper.updatePosition(position);
    }

    public void deletePosition(int positionId) {
        positionMapper.deletePosition(positionId);
    }

    public List<Position> getPositionsByCategoryId(int categoryId) {
        return positionMapper.findByCategoryId(categoryId);
    }

    public List<Position> getAllPositions() {
        return positionMapper.findAll();
    }
}
