package com.xiaozhi.service.Impl;

import com.xiaozhi.common.entity.Department;
import com.xiaozhi.common.entity.DepartmentExample;
import com.xiaozhi.mapper.DepartmentMapper;
import com.xiaozhi.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2018/3/25/025.
 */
@Service
public class DepartmentServiceImpl implements DepartmentService{

    @Autowired
    private DepartmentMapper departmentMapper;

    //查询所有部门
    public List<Department> getDepts() {
         List<Department> list =departmentMapper.selectByExample(null);
         return list;
    }

    //根据部门id查询部门
    public Department selectDeptById(int deptId){
        DepartmentExample example = new DepartmentExample();
        DepartmentExample.Criteria criteria =example.createCriteria();
        criteria.andDeptIdEqualTo(deptId);
        List<Department> departmentList =departmentMapper.selectByExample(example);
        return departmentList.get(0);
    }
}
