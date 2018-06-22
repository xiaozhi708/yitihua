<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/24/024
  Time: 20:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<style>
    .pagination {
        margin : 0 240px !important;
    }
    .righli {
        width:869px;
    }
    .righli button{
        float:right !important;
        display:inline-block !important;
        margin : 0 30px 0 0;
    }
</style>
<head>
    <title>员工列表</title>
    <%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <!--web路径
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题
    以/开始的相对路径，找资源，以服务器的根路径为标准（http:localhost:3306）,需要加上项目名
    -->
    <!--引入JQuery-->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
    <!--引入bootstrap样式-->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="Bookmark" href="/admin/favicon.ico" >
    <link rel="Shortcut Icon" href="/admin/favicon.ico" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="/admin/lib/html5shiv.js"></script>
    <script type="text/javascript" src="/admin/lib/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="/admin/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="/admin/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="/admin/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="/admin/static/h-ui.admin/skin/green/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="/admin/static/h-ui.admin/css/style.css" />
    <!--[if IE 6]>
    <script type="text/javascript" src="/admin/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
</head>
<body>

<!-- 员工修改的模态框Modal -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name ="email" class="form-control" id="email_update_input" placeholder="email@atguigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!--部门提交部门id即可-->
                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>
<!-- 员工添加的模态框Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name ="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name ="email" class="form-control" id="email_add_input" placeholder="email@atguigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!--部门提交部门id即可-->
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<!--搭建显示页面-->
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 员工管理 <span class="c-gray en">&gt;</span> 员工列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="container">
    <!--标题行-->
    <div class="row">
        <div class=".col-md-12">
            <h1>小智有限公司</h1>
        </div>
    </div>
    <!--增加，删除按钮-->
        <div class="row">
            <div class="col-lg-4 col-lg-offset-8 righli">
                <button class="btn btn-primary righli1" id="emp_add_modal_btn">新增</button>
                <button class="btn btn-danger righli2" id="emp_delete_all_btn">删除</button>
            </div>
        </div>

    <!--显示表格信息-->
    <div class="row">
        <div class="col-lg-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>ID</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!--分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-lg-6" id="page_info_area">
        </div>
        <!--分页条信息-->
        <div class="col-lg-6" id="page_nav_area">
        </div>

    </div>
</div>

<script type="text/javascript">
    var totalRecord,currentPage;

    //1.页面加载完成以后，直接发送一个ajax请求，要到分页数据
    $(function () {
        //去首页
        to_page(1);
    });
    function to_page(pn) {
        $.ajax({
            url: "/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                //console.log(result);
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析并显示分页条
                build_page_nav(result);
            }
        });
    }
    //解析显示表格信息
    function build_emps_table(result) {
        //将全选取消
        $("#check_all").prop("checked",false);
        //清空table表格
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
//            alert(item.empName);
            var checkBoxTd =$("<td><input type='checkbox' class='check_item'></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
//            <button class="btn btn-primary btn-sm">
//                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
//                新增
//                </button>
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义的属性，来表示当前员工的id
            editBtn.attr("edit-id",item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个自定义的属性，来表示当前员工的id
            delBtn.attr("del-id",item.empId);
            var btnId = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append方法执行完成后还是返回原来的元素
            $("<tr></tr>")
                .append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                <%--<shiro:hasAnyRoles name="admin">--%>
                .append(btnId)
                <%--</shiro:hasAnyRoles>--%>
                .appendTo("#emps_table tbody");
        });
    }
    //解析显示分页信息
    function build_page_info(result) {
        //构建之前，清空之前的数据
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第" + result.extend.pageInfo.pageNum + "页,总" +
            result.extend.pageInfo.pages + "页,总" +
            result.extend.pageInfo.total + "条记录");
        totalRecord =result.extend.pageInfo.total;
        currentPage =result.extend.pageInfo.pageNum;
    }
    //解析显示分页条，点击需有动作
    function build_page_nav(result) {
        //构建之前，清空之前的数据
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        //构建元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append($("<span><span>").append("&laquo;")));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //为元素添加点击事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append($("<span><span>").append("&raquo;")));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }


        //添加首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi);
        //1,2,3遍历给ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {//显示当前页的效果
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        //给ul添加后一页和末页的提示
        ul.append(nextPageLi).append(lastPageLi);
        //把ul添加到nav元素中
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    //清空表单样式及内容
    function reset_form(ele) {
        //清空表单数据
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function () {
        //清除表单数据（表单完全重置（表单的数据，表单的样式））
        reset_form("#empAddModal form");
        //发出ajax请求，将部门信息查出来，显示在下拉列表中
        getDepts("#empAddModal select");
        //弹出模态框
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });
    //查出所有的部门信息并显示在下拉列表中
    function getDepts(ele) {
        //清空之前下拉列表的值
        $(ele).empty();
        $.ajax({
            url:"/depts",
            type:"GET",
            success:function (result) {
                //console.log(result);
                //显示部门信息在下拉列表中
                //$("#empAddModal select").append("")
                $.each(result.extend.depts,function () {
                    var optionEle =$("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    //校验表单数据,前端正则检验主要为展示错误提示
    function validate_add_form(){
        //1、拿到要检验的数据，使用正则表达式
        //验证用户名
        var empName = $("#empName_add_input").val();
        var regName = /^([a-zA-Z0-9_-]{6,16})|(^[\u2E80-\u9FFF]{2,5})$/;
        //alert(regName.test(empName));
        if(!regName.test(empName)){
            //alert("用户名可以是2~5位中文或者6~16位英文和数字的组合");
            show_validate_msg("#empName_add_input","error","用户名可以是2~5位中文或者6~16位英文和数字的组合");
            return false;
        }else{
            show_validate_msg("#empName_add_input","success","");
        }
        //验证email
        var email = $("#email_add_input").val();
        var regEmail = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式不正确");
            //应该清空这个元素之前的样式
            show_validate_msg("#email_add_input","error","邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#email_add_input","success","");
        }
        return true;
    }

    //显示校验结果的提示信息
    function show_validate_msg(ele,status,msg) {
        //清除当前元素的校验装态
        $(ele).parent().parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if(status === "success"){
            $(ele).parent().parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if(status === "error"){
            $(ele).parent().parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //校验用户名是否正确
    $("#empName_add_input").change(function () {
        //发送ajax请求校验用户名是否正确（不重复）
        var empName = $("#empName_add_input").val();
//        alert("用户名："+empName);
        $.ajax({
            url:"/checkuser",
            type:"POST",
            data:"empName="+empName,
            success:function (result) {
                if(result.code==100){
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        });
    });

    //点击保存，保存员工
    $("#emp_save_btn").click(function () {
        //1.将模态框中填写的表单数据提交给服务器进行保存
        //先对要提交给服务器的数据进行校验
        //1.前端jQuery校验（不查重）
        if(!validate_add_form()){
            return false;
        }
        //1.判断之前的用户名校验是否成功，如果成功了才往下走
        if($(this).attr("ajax-va")=="error"){
            return false;
        }
        //3.发送ajax请求保存员工
        $.ajax({
            url:"/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                if(result.code==100){
                    //alert(result.msg);
                    //当员工保存成功
                    // 1.关闭模态框
                    $("#empAddModal").modal('hide');
                    // 2.来到最后一页，显示刚才保存的数据
                    //发送ajax请求显示最后一页即可，用全局变量totalRecord,利用分页插件的特性，传入一个比总页数大的数进去总能显示最后一页
                    to_page(totalRecord);
                }else if(result.code==200){
                    //显示失败信息
                    //console.log(result);
                    //有那个字段的错误信息就显示那个字段的
                    if(undefined != result.extend.errorFields.email){
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                    if(undefined != result.extend.errorFields.empName){
                        //显示员工名字错误信息
                        show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                    }
                }


            }
        });
    });

    //我们是在按钮创建之前就绑定了click，所以绑定不上
    //1.可以在创建按钮时绑定 2.绑定点击，live
    //jquery新版没有live，使用on进行代替
    $(document).on("click",".edit_btn",function () {
        //alert("edit");
        //1.查出部门信息， 显示部门列表
        //发出ajax请求，将部门信息查出来，显示在下拉列表中
        getDepts("#empUpdateModal select");
        //2.查出员工信息，显示员工信息
        getEmp($(this).attr("edit-id"));
        //3.把员工的id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        //弹出模态框
        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    });
    //单个删除
    $(document).on("click",".delete_btn",function () {
        //弹出是否确认删除对话框
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId =$(this).attr("del-id");
        if(confirm("确认删除【"+empName+"】吗？")){
            //确认，发出ajax请求即可
            $.ajax({
                url:"/emp/"+empId,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    //回到当前页
                    to_page(currentPage);
                }
            });
        }
    });
    //根据员工id拿到员工数据
    function getEmp(id) {
        $.ajax({
            url:"/emp/"+id,
            type:"GET",
            success:function (result) {
                //console.log(result);
                var empData =result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }
    //点击更新，跟新员工信息
    $("#emp_update_btn").click(function () {
        //验证邮箱

        var email = $("#email_update_input").val();
        var regEmail = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
        if(!regEmail.test(email)){

            show_validate_msg("#email_update_input","error","邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#email_update_input","success","");
        }
        //发送ajax请求保存员工的数据
        $.ajax({
            url:"/emp/"+$(this).attr("edit-id"),
            type:"PUT",//如果用POST的话date需加+"&_method=PUT"
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {
               // alert(result.msg);
                //1.关闭模态框
                $("#empUpdateModal").modal('hide');
                //2.回到本页面
                to_page(currentPage);
            }
        });
    });

    //完成全选/全不选的功能
    $("#check_all").click(function () {
        //attr获取checked是undefined
        //我们这些dom原生的属性，attr获取自定义属性的值
        //prop修改和读取dom原生属性的值
        $(".check_item").prop("checked",$(this).prop("checked"));
    });
    //check_item
    $(document).on("click",".check_item",function () {
        //判断当前选择中的元素是不是5个
        var flag =$(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);

    });
    //点击全部删除，就批量删除
    $("#emp_delete_all_btn").click(function () {
        var empNames ="";
        var del_idstr="";
       $.each($(".check_item:checked"),function () {
           empNames += $(this).parents("tr").find("td:eq(2)").text()+",";//把要删除员工的名字拼起来
           //组装员工id的字符串
           del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
       });
       //删除empNames多于的逗号
        empNames =empNames.substring(0,empNames.length-1);
        del_idstr =del_idstr.substring(0,del_idstr.length-1);
       if(confirm("确认删除【"+empNames+"】吗？")){
           //发送ajax删除
           $.ajax({
               url:"/emp/"+del_idstr,
               type:"DELETE",
               success:function (result) {
                   alert(result.msg);
                   //回到当前页
                   to_page(currentPage);
               }
           });
       }
    });
</script>

<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="/admin/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="/admin/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="/admin/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="/admin/static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="/admin/lib/jquery.contextmenu/jquery.contextmenu.r2.js"></script>
<script type="text/javascript">
    $(function(){
        /*$("#min_title_list li").contextMenu('Huiadminmenu', {
         bindings: {
         'closethis': function(t) {
         console.log(t);
         if(t.find("i")){
         t.find("i").trigger("click");
         }
         },
         'closeall': function(t) {
         alert('Trigger was '+t.id+'\nAction was Email');
         },
         }
         });*/


        $("body").Huitab({
            tabBar:".navbar-wrapper .navbar-levelone",
            tabCon:".Hui-aside .menu_dropdown",
            className:"current",
            index:0,
        });
    });
    /*个人信息*/
    function myselfinfo(){
        layer.open({
            type: 1,
            area: ['300px','200px'],
            fix: false, //不固定
            maxmin: true,
            shade:0.4,
            title: '查看信息',
            content: '<div>管理员信息</div>'
        });
    }

    /*资讯-添加*/
    function article_add(title,url){
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }
    /*图片-添加*/
    function picture_add(title,url){
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }
    /*产品-添加*/
    function product_add(title,url){
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }
    /*用户-添加*/
    function member_add(title,url,w,h){
        layer_show(title,url,w,h);
    }


</script>
    </body>
</html>
