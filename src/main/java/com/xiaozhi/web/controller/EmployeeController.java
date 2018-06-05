package com.xiaozhi.web.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaozhi.common.entity.Employee;
import com.xiaozhi.common.entity.Msg;
import com.xiaozhi.service.EmployeeService;
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
 * 处理员工的增删改查（CRUD）的请求
 * Created by Administrator on 2018/3/24/024.
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 单个批量二合一
     * 批量删除，1-2-3
     * 单个删除，1
     *
     * @param ids
     * @return
     */
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpById(@PathVariable("ids")String ids){
        //批量删除
        if(ids.contains("-")){
            List<Integer> del_ids =new ArrayList<Integer>();
            String[] str_ids =ids.split("-");
            //组装id的集合
            for (String str_id:str_ids) {
                del_ids.add(Integer.parseInt(str_id));
            }
            employeeService.deleteBatch(del_ids);
        }else{//单个删除
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }

        return Msg.success();
    }

    /**
     * 如果直接发送ajax=PUT形式的请求
     * 封装的数据为Employee{empId=1005, empName='null', gender='null', email='null', dId=null, department=null}
     *
     * 问题
     * 请求体中有数据
     * 但是Employee对象封装不上
     *
     * 原因
     * tomcat ：将请求体中的数据分装成一个map request.getParameter("empName")就会从这个map中取值
     * springMvc：封装POJO对象的时候，采用request.getParameter（）
     * ajax发送PUT请求的血案
     * tomcat一看是PUT请求就不会封装请求体中的数据为map，只有post才封装
     *
     *解决方案
     * 我们要能支持直接发送PUT之类的请求还要封装请求体中的数据配置上HttpPutFormContentFilter
     * 它的作用：将请求体中的数据解析包装成一个map，request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
     * 更新员工
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee){
        System.out.println("将要更新的员工的数据"+employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }
    /**
     * 根据id查询员工
     * @param id
     * @return
     */
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee =employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    /**
     * @param pn
     * @return
     * @ResponseBody要能用必须导入jackson包 用json返回员工数据
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        //这不是一个分页查询
        //引入PageHelper分页插件
        //在查询之前只需调用PageHelper.startPage,传入页码和每页的大小
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //用PageInfo对结果进行包装，只需要将pageInfo交给页面就行了（封装了详细的分页信息，包括有我们查询出来的数据）
        PageInfo page = new PageInfo(emps, 5);//5为连续显示的页码
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 查询员工数据（分页查询）
     *
     * @return
     */
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        //这不是一个分页查询
        //引入PageHelper分页插件
        //在查询之前只需调用PageHelper.startPage,传入页码和每页的大小
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //用PageInfo对结果进行包装，只需要将pageInfo交给页面就行了（封装了详细的分页信息，包括有我们查询出来的数据）
        PageInfo page = new PageInfo(emps, 5);//5为连续显示的页码
        model.addAttribute("pageInfo", page);
        return "list";
    }

    /**
     * 保存员工
     * 1.支持JSR303校验
     * 2.导入Hibernate-Validator，在entity里加@Pattern指定自己的校验规则，在controller方法里参数前加@Valid，后面跟BindingResult result来接受校验结果
     * @return
     */
    @RequestMapping(value="/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee,BindingResult result){
        if(result.hasErrors()){
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
            employeeService.saveEmp(employee);
            return Msg.success();
        }

    }

    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkuser(@RequestParam("empName") String empName){
        //先判断用户名是否是合法的表达式
        String regx="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名可以是2-5位中文或6-16位英文和数字的组合");
        }
        //数据库用户名重复校验
        boolean b = employeeService.checkUser(empName);
        if(b){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg","用户名不可用");
        }

    }
}
