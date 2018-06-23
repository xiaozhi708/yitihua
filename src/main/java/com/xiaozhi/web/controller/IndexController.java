package com.xiaozhi.web.controller;

import com.xiaozhi.service.DepartmentService;
import com.xiaozhi.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by Administrator on 2018/6/20/020.
 */
@Controller
public class IndexController {

    @Autowired
    UserService userService;
    @Autowired
    DepartmentService departmentService;

    /**
     * 去首页
     * @return
     */
    @RequestMapping(value = "/index",method = RequestMethod.GET)
    public String toLogin(Model model){
        //构造首页用户的头衔
        String title ="";
        if(SecurityUtils.getSubject().hasRole("admin")){
            title ="admin";
        }else if(SecurityUtils.getSubject().hasRole("总经理")){
            title ="总经理";
        }else if(SecurityUtils.getSubject().hasRole("部门经理")){
            String userName = (String) SecurityUtils.getSubject().getPrincipal();
            int deptId = userService.selectDeptIdByUserName(userName);
            String deptName = departmentService.selectDeptById(deptId).getDeptName();
            title =deptName+"经理";
        }
        //得到用户的真名
        Session session =SecurityUtils.getSubject().getSession();
        String realName = (String) session.getAttribute("realName");

        model.addAttribute("title",title);
        model.addAttribute("realName",realName);
        return "index";
    }



}
