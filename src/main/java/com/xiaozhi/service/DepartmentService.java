package com.xiaozhi.service;

import com.xiaozhi.common.entity.Department;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2018/6/7/007.
 */
public interface DepartmentService {
    //查询所有部门
    public List<Department> getDepts();

    //根据部门id查询部门
    public Department selectDeptById(int deptId);
}
