package com.xiaozhi.common.entity;

public class Department {
    private Integer deptId;

    private String deptName;

    public Department(Integer deptId, String deptName) {//构造有参构造器必须要写无参构造器
        this.deptId = deptId;
        this.deptName = deptName;
    }

    public Department() {
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? null : deptName.trim();
    }
}