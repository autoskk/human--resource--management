package com.example.pojo;

import lombok.Data;

@Data
public class Level2Organization {
    private int level2Id;
    private int level1Id;      // 一级机构ID
    private String level2Name; // 二级机构名称

    // Getters and Setters
    public int getLevel2Id() { return level2Id; }
    public void setLevel2Id(int level2Id) { this.level2Id = level2Id; }
    public int getLevel1Id() { return level1Id; }
    public void setLevel1Id(int level1Id) { this.level1Id = level1Id; }
    public String getLevel2Name() { return level2Name; }
    public void setLevel2Name(String level2Name) { this.level2Name = level2Name; }
}
