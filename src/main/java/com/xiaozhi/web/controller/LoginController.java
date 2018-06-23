package com.xiaozhi.web.controller;

import com.xiaozhi.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Created by Administrator on 2018/6/14/014.
 */
@Controller
public class LoginController {
    @Autowired
    UserService userService;

    private final Logger log = LoggerFactory.getLogger(this.getClass());
    /**
     * 去登录页
     * @return
     */
    @RequestMapping(value = "/login",method = RequestMethod.GET)
    public String toLogin(){
        return "login";
    }

    /**
     * 登录
     * @param username
     * @param password
     * @return
     */
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public String login(@RequestParam("username")String username, @RequestParam("password")String password,Model model){
        //1.创建Subject实例
        Subject currentUser = SecurityUtils.getSubject();
        String error =null;
        //2.判断当前用户是否登录
        if (currentUser.isAuthenticated()==false){
            //3.将用户名和密码封装到UsernamePasswordToken
            UsernamePasswordToken token = new UsernamePasswordToken(username, password);
            try {
                currentUser.login(token);
                Session session = currentUser.getSession();
                session.setAttribute("realName", userService.selectRealNameByUserName(username));
                log.info("用户名和密码正确，登录成功");
                return "redirect:/index";
            } catch (AuthenticationException e) {
                error = "用户名或密码错误";
            }
        }
        model.addAttribute("error",error);//认证失败
        return "login";
    }

    /**
     * 退出登录
     * @return
     */
    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public String logout(){
        //shiro退出
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        return "login";
    }
}
