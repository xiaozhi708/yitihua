package com.xiaozhi.service;

import com.xiaozhi.common.entity.Department;
import com.xiaozhi.mapper.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2018/3/25/025.
 */
@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts() {
         List<Department> list =departmentMapper.selectByExample(null);
         return list;
    }
}
