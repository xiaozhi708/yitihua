package com.xiaozhi.service.Impl;

import com.github.pagehelper.PageHelper;
import com.xiaozhi.common.entity.Employee;
import com.xiaozhi.common.entity.EmployeeExample;
import com.xiaozhi.common.entity.User;
import com.xiaozhi.common.entity.UserExample;
import com.xiaozhi.mapper.EmployeeMapper;
import com.xiaozhi.mapper.UserMapper;
import com.xiaozhi.service.EmployeeService;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2018/3/24/024.
 */
@Service
public class EmployeeServiceImpl implements EmployeeService{

    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    UserMapper userMapper;

    /**
     * 查询所有员工
     *
     * @return
     */
    public List<Employee> getAll() {
        EmployeeExample example = new EmployeeExample();
       example.setOrderByClause("emp_id ASC");
        return employeeMapper.selectByExampleWithDept(example);
    }

    /**
     * 根据部门id查询员工
     * @return
     */
    public List<Employee> selectByDept(int userDeptId){
        //根据部门id查询部门员工
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andDIdEqualTo(userDeptId);
        example.setOrderByClause("emp_id ASC");
        return employeeMapper.selectByExampleWithDept(example);
    }
    /**
     * 员工保存
     *
     * @param employee
     */
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /**
     * 检验用户名是否可用
     *
     * @param empName
     * @return true 表明当前姓名可用，否则不可用
     */
    public boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

    /**
     * 根据员工id查询员工
     *
     * @param id
     * @return
     */
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKeyWithDept(id);
        return employee;
    }

    /**
     * 员工更新
     *
     * @param employee
     */
    public void updateEmp(Employee employee) {
//        EmployeeExample example =new EmployeeExample();
//        EmployeeExample.Criteria criteria =example.createCriteria();
//        criteria.andEmpIdEqualTo(employee.getEmpId());
//        employeeMapper.updateByExampleSelective(employee,example);
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 根据员工id删除员工
     *
     * @param id
     */
    public void deleteEmp(Integer id) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdEqualTo(id);
        employeeMapper.deleteByExample(example);
    }

    /**
     * 批量删除员工
     * @param ids
     */
    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example =new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
