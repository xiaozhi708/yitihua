package com.xiaozhi.test;


import com.xiaozhi.common.entity.Department;
import com.xiaozhi.mapper.DepartmentMapper;
import com.xiaozhi.mapper.EmployeeMapper;
import com.xiaozhi.mapper.RoleMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Iterator;
import java.util.Set;


/**
 * 测试dao层的工作
 * Created by Administrator on 2018/3/23/023.
 * 推荐Spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
 * 1.导入SpringTest模块
 * 2.@ContextConfiguration指定Spring配置文件的位置
 * 3.直接autowired要使用的组件即可
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;
    @Autowired
    RoleMapper roleMapper;
    /**
     * 测试DepartmentMapper
     */
    @Test
    public void testCRUD(){
        System.out.println(departmentMapper);

        //1.插入几个部门
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));
        departmentMapper.insertSelective(new Department(null,"产品部"));
        //2.生成员工数据，测试员工插入
        //employeeMapper.insertSelective(new Employee(null,"梁志承","M","1815117902@qq.com",1));
        //批量插入多个员工，使用可以执行批量操作的sqlSession
//        for(){//不叫批量，耗时
//            employeeMapper.insertSelective(new Employee(null,"梁志承","M","1815117902@qq.com",1));
//        }
//        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//        for (int i = 0; i < 1000; i++) {
//            String uid = UUID.randomUUID().toString().substring(0,5)+i;
//            mapper.insertSelective(new Employee(null,uid,"M",uid+"@qq.com",1));
//        }
//        System.out.println("批量完成");

    }

    /**
     * 测试roleMapper
     */
    @Test
    public void testRole(){
        Set<String> roles =roleMapper.selectByUserId(1);
        Iterator<String> it =roles.iterator();
        while (it.hasNext()){
            String str =it.next();
            System.out.println(str);
        }
    }

}
