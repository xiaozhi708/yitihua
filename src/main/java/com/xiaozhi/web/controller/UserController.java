package com.xiaozhi.web.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaozhi.common.entity.*;
import com.xiaozhi.mapper.UserRoleMapper;
import com.xiaozhi.service.RoleService;
import com.xiaozhi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2018/6/21/021.
 */
@Controller
public class UserController {
    @Autowired
    UserService userService;
    @Autowired
    RoleService roleService;
    @Autowired
    UserRoleMapper userRoleMapper;

    /**
     * 去用户列表页面
     *
     * @return
     */
    @RequestMapping(value = "/toUsers", method = RequestMethod.GET)
    public String toUsers() {
        return "users";
    }

    /**
     * 用json格式返回用户数据
     *
     * @param pn
     * @return
     */
    @RequestMapping("/users")
    @ResponseBody
    public Msg getUsersWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 5);
        List<User> users = userService.getAllUser();
//        for(int i=0;i<users.size();i++){
//            System.out.println(users.get(i).getuId());
//        }
        //用PageInfo对结果进行包装，只需要将pageInfo交给页面就行了（封装了详细的分页信息，包括有我们查询出来的数据）
        PageInfo page = new PageInfo(users, 5);//5为连续显示的页码
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 检查用户的名字是否可用
     *
     * @param username
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkUserName")
    public Msg checkUserName(@RequestParam("username") String username) {
        //先判断用户名是否是合法的表达式
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!username.matches(regx)) {
            return Msg.fail().add("va_msg", "用户名可以是2-5位中文或6-16位英文和数字的组合");
        }
        //数据库用户名重复校验
        boolean b = userService.checkUserName(username);
        if (b) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "用户名不可用");
        }

    }

    /**
     * 保存用户
     * @return
     */
    @RequestMapping(value="/user",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveUser(@Valid User user, BindingResult result){
        if(result.hasErrors()){
            System.out.println("数据有误！");
            //校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            //将错误信息封装在map里传给前台
            Map<String, Object> map =new HashMap<String, Object>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError:errors
                    ) {
                System.out.println("错误的字段名，"+fieldError.getField());
                System.out.println("错误信息，"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else{
            //存储用户的信息（部门信息无需操作，因为deptId没填的话默认应为-1与数据库中dept_id的默认值一致）
            if(user.getRole().getId()!=3){//不是部门经理，deptId置-1
                user.setDeptId(-1);
            }
            userService.saveUser(user);
            //拿到刚才存进去的用户的id
            List<User> userList =userService.getAllUser();
            int userId =userList.get(userList.size()-1).getuId();
            //存储用户的角色
            UserRole userRole =new UserRole();
            userRole.setUserId(userId);
            userRole.setRoleId(user.getRole().getId());
            userRoleMapper.insert(userRole);
            //System.out.println("用户的角色id:"+user.getRole().getId());
            //System.out.println("成功保存了用户！");
            return Msg.success();
        }

    }

    /**
     * 根据id查询用户
     * @param uId
     * @return
     */
    @RequestMapping(value = "/user/{uId}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getUser(@PathVariable("uId") Integer uId){
        User user =userService.getUser(uId);
        System.out.println("用户名："+user.getUsername());
        return Msg.success().add("user",user);
    }

    /**
     * 更新用户数据
     * @param user
     * @return
     */
    @RequestMapping(value = "/user/{uId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateUser(User user){
        //更新用户的角色信息
        UserRoleExample example = new UserRoleExample();
        UserRoleExample.Criteria criteria =example.createCriteria();
        criteria.andUserIdEqualTo(user.getuId());
        UserRole newUserRole =new UserRole(user.getuId(),user.getRole().getId());
        userRoleMapper.updateByExample(newUserRole,example);
        //更新用户的部门信息
        if(user.getRole().getId()!=3||user.getDeptId()==null){//用户角色不是部门经理||没有填写部门信息则默认为-1
            user.setDeptId(-1);
        }
        //更新用户其他信息
        userService.updateUser(user);
        return Msg.success();
    }


    /**
     * 单个批量二合一
     * 批量删除，1-2-3
     * 单个删除，1
     *
     * @param ids
     * @return
     */
    @RequestMapping(value = "/user/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteUserById(@PathVariable("ids") String ids){
        //批量删除
        if(ids.contains("-")){
            List<Integer> del_ids =new ArrayList<Integer>();
            String[] str_ids =ids.split("-");
            //组装id的集合
            for (String str_id:str_ids) {
                if(!"1".equals(str_id)){//用户liangzc不能删除
                    del_ids.add(Integer.parseInt(str_id));
                }
            }
            userService.deleteBatch(del_ids);
            roleService.deleteBatch(del_ids);//根据用户id删除用户与角色的关联信息
        }else{//单个删除
            Integer id = Integer.parseInt(ids);
            if(id!=1){//用户liangzc不能删除
                //删除用户基本信息
                userService.deleteUser(id);
                //删除用户角色信息
                roleService.deleteRole(id);
            }

        }

        return Msg.success();
    }

    /**
     * 为弹出框查询所有角色信息
     * @return
     */
    @RequestMapping(value = "/user/roles" ,method = RequestMethod.GET)
    @ResponseBody
    public Msg get() {
        List<Role> roleList =roleService.getAllRoles();
        return Msg.success().add("roles", roleList);
    }
}
