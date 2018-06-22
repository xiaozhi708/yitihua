package com.xiaozhi.service;

import com.xiaozhi.common.entity.Employee;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2018/6/7/007.
 */
public interface EmployeeService {
    public List<Employee> getAll();
    public List<Employee> selectByDept(int userDeptId);
    public void saveEmp(Employee employee);
    public boolean checkUser(String empName);
    public Employee getEmp(Integer id);
    public void updateEmp(Employee employee);
    public void deleteEmp(Integer id);
    public void deleteBatch(List<Integer> ids);
}
