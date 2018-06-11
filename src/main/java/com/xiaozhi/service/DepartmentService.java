package com.xiaozhi.service;

import com.xiaozhi.common.entity.Department;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2018/6/7/007.
 */
public interface DepartmentService {

    public List<Department> getDepts();
}
