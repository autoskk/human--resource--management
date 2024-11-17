package com.example.pojo;

public enum SalaryStatus {
    PENDING("待登记"),
    UNDER_REVIEW("待复核"),
    COMPLETED("已复核");

    private String description;

    SalaryStatus(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
