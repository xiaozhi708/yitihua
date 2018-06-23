package com.xiaozhi.common.entity;

import javax.validation.constraints.Pattern;

public class Role {
    private Integer id;
    @Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})",
            message = "角色名必须是2-5位中文或6-16位英文和数字的组合")
    private String name;

    @Pattern(regexp = "(^[\\s\\S]{0,30})",
            message = "字数不能超过30个")
    private String description;

    public Role(Integer id, String name, String description) {
        this.id = id;
        this.name = name;
        this.description = description;
    }

    public Role() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }
}