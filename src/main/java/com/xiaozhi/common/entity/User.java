package com.xiaozhi.common.entity;

import javax.validation.constraints.Pattern;

public class User {
    private Integer uId;
    @Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})",
            message = "用户名必须是2-5位中文或6-16位英文和数字的组合")
    private String username;

    private String password;

    private String realName;
    @Pattern(regexp = "^[a-z\\d]+(\\.[a-z\\d]+)*@([\\da-z](-[\\da-z])?)+(\\.{1,2}[a-z]+)+$",
            message = "邮箱格式不正确")
    private String email;

    private Integer deptId;

    //查询用户的同时也查询用户的角色
    private Role role;
    public User(Integer uId, String username, String password, String realName, String email, Integer deptId) {
        this.uId = uId;
        this.username = username;
        this.password = password;
        this.realName = realName;
        this.email = email;
        this.deptId = deptId;
    }
    public User(){

    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Integer getuId() {
        return uId;
    }

    public void setuId(Integer uId) {
        this.uId = uId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName == null ? null : realName.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }
}