package com.example.pojo;

public class Level3Organization {
    private int level3Id;
    private int level2Id;      // 二级机构ID
    private String level3Name; // 三级机构名称

    // Getters and Setters
    public int getLevel3Id() { return level3Id; }
    public void setLevel3Id(int level3Id) { this.level3Id = level3Id; }
    public int getLevel2Id() { return level2Id; }
    public void setLevel2Id(int level2Id) { this.level2Id = level2Id; }
    public String getLevel3Name() { return level3Name; }
    public void setLevel3Name(String level3Name) { this.level3Name = level3Name; }
}
