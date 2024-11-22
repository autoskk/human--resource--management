package com.example.pojo;

public class Position {
    private int positionId;            // 职位ID
    private int categoryId;            // 职务分类ID
    private String positionName;       // 职位名称

    // Getters and Setters
    public int getPositionId() { return positionId; }
    public void setPositionId(int positionId) { this.positionId = positionId; }
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
    public String getPositionName() { return positionName; }
    public void setPositionName(String positionName) { this.positionName = positionName; }
}
