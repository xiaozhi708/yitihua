package com.xiaozhi.web.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaozhi.common.entity.Department;
import com.xiaozhi.common.entity.Msg;
import com.xiaozhi.common.entity.Role;
import com.xiaozhi.common.entity.RoleExample;
import com.xiaozhi.mapper.RoleMapper;
import com.xiaozhi.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
public class RoleController {

    @Autowired
    RoleService roleService;
    @Autowired
    RoleMapper roleMapper;
    /**
     * 前往角色列表页面
     * @return
     */
    @RequestMapping(value = "/toRoles",method = RequestMethod.GET)
    public String toRole(Model model){
        System.out.println("进入了roles");
        List<Role> roleList =roleService.getAllRoles();
        //统计数量
        RoleExample roleExample =new RoleExample();
        long roleNum = roleMapper.countByExample(roleExample);

        model.addAttribute("roleList",roleList);
        model.addAttribute("roleNum",roleNum);
        return "roles";
    }


    /**
     * 保存角色
     * @return
     */
    @RequestMapping(value="/role",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveRole(@Valid Role role, BindingResult result){
        if(result.hasErrors()){
            System.out.println("保存的角色数据有误！");
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
            roleService.saveRole(role);
            return Msg.success();
        }

    }


    /**
     * 检查角色的名字是否可用
     *
     * @param roleName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkRoleName")
    public Msg checkRoleName(@RequestParam("roleName") String roleName) {
        //先判断用户名是否是合法的表达式
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!roleName.matches(regx)) {
            return Msg.fail().add("va_msg", "角色名可以是2-5位中文或6-16位英文和数字的组合");
        }
        //数据库用户名重复校验
        boolean b = roleService.checkRoleName(roleName);
        if (b) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "角色名不可用");
        }

    }

    /**
     * 拿到所有的角色
     * @return
     */
    @RequestMapping(value = "/roles",method = RequestMethod.GET)
    @ResponseBody
    public Msg getRolesWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        //查出的所有部门信息
        PageHelper.startPage(pn, 5);
        List<Role> roleList =roleService.getAllRoles();
        PageInfo page = new PageInfo(roleList, 5);//5为连续显示的页码
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 根据角色id查询角色
     * @param id
     * @return
     */
    @RequestMapping(value = "/role/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getRoleById(@PathVariable("id") Integer id){
        Role role =roleService.getRoleById(id);
        System.out.println("角色名："+role.getName());
        return Msg.success().add("role",role);
    }

    /**
     * 更新角色数据
     * @param role
     * @return
     */
    @RequestMapping(value = "/role/{id}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateRole(Role role){
        roleService.updateRole(role);
        return Msg.success();
    }
    /**
     * 前往角色编辑页
     * @return
     */
    @RequestMapping(value = "roleEdit",method = RequestMethod.GET)
    public String toRoleEdit(){
        return "roleEdit";
    }


    /**
     * 单个批量二合一
     * 批量删除，1-2-3
     * 单个删除，1
     *
     * @param ids
     * @return
     */
    @RequestMapping(value = "/role/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteRoleById(@PathVariable("ids") String ids){
        //批量删除
        if(ids.contains("-")){
            List<Integer> del_ids =new ArrayList<Integer>();
            String[] str_ids =ids.split("-");
            //组装id的集合
            for (String str_id:str_ids) {
//                if(!"1".equals(str_id)){//角色admin不能删除
//                    del_ids.add(Integer.parseInt(str_id));
//                }
                if((!"1".equals(str_id))&&(!"2".equals(str_id))&&(!"3".equals(str_id))){//角色admin,总经理，部门经理不能删除
                    del_ids.add(Integer.parseInt(str_id));
                }
            }
            roleService.deleteBatchByRoleIds(del_ids);
        }else{//单个删除
            Integer id = Integer.parseInt(ids);
            //删除角色信息
//            if(id!=1){//角色admin不能删除
//                roleService.deleteRoleByRoleId(id);
//            }
            if(id!=1&&id!=2&&id!=3){//角色admin,总经理，部门经理不能删除
                roleService.deleteRoleByRoleId(id);
            }

        }

        return Msg.success();
    }



}
