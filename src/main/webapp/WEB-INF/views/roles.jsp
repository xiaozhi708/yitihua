<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/24/024
  Time: 20:01
  To change this trolelate use File | Settings | File Trolelates.
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
    <title>角色列表</title>
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
    <!--<script type="text/javascript" src="/admin/lib/html5shiv.js"></script>-->
    <!--<script type="text/javascript" src="/admin/lib/respond.min.js"></script>-->
    <![endif]-->
    <%--<link rel="stylesheet" type="text/css" href="/admin/static/h-ui/css/H-ui.min.css" />--%>
    <link rel="stylesheet" type="text/css" href="/admin/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="/admin/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <%--<link rel="stylesheet" type="text/css" href="/admin/static/h-ui.admin/skin/green/skin.css" id="skin" />--%>
    <%--<link rel="stylesheet" type="text/css" href="/admin/static/h-ui.admin/css/style.css" />--%>
    <!--[if IE 6]>
    <script type="text/javascript" src="/admin/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
</head>
<body>

<!-- 角色修改的模态框Modal -->
<div class="modal fade" id="roleUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">角色修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">角色名</label>
                        <div class="col-sm-10">
                            <input type="text" name ="name" class="form-control" id="roleName_update_input" placeholder="">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="description_update_input" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10">
                            <input type="description" name ="description" class="form-control" id="description_update_input" placeholder="不多于30字">
                            <span class="help-block"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="role_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>
<!-- 角色添加的模态框Modal -->
<div class="modal fade" id="roleAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">角色添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">角色名</label>
                        <div class="col-sm-10">
                            <input type="text" name ="name" class="form-control" id="roleName_add_input" placeholder="">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="description_add_input" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10">
                            <input type="description" name ="description" class="form-control" id="description_add_input" placeholder="不多于30字">
                            <span class="help-block"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="role_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<!--搭建显示页面-->
<nav class="breadcrumb" style="line-height:1.6em;"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 用户管理 <span class="c-gray en">&gt;</span> 角色列表 </nav>
<div class="container">
    <!--标题行-->
    <div class="row">
        <div class=".col-md-12">
            <h1>小智有限公司</h1>
        </div>
    </div>
    <!--增加，删除按钮-->
    <div class="row">
        <div class="col-lg-4 col-lg-offset-8">
            <button class="btn btn-primary" id="role_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="role_delete_all_btn">批量删除</button>
        </div>
    </div>

    <!--显示表格信息-->
    <div class="row">
        <div class="col-lg-12">
            <table class="table table-hover" id="roles_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>ID</th>
                    <th>角色名</th>
                    <th>描述</th>
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
            url: "/roles",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                //console.log(result);
                //1.解析并显示角色数据
                build_roles_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析并显示分页条
                build_page_nav(result);
            }
        });
    }
    //解析显示表格信息
    function build_roles_table(result) {
        //将全选取消
        $("#check_all").prop("checked",false);
        //清空table表格
        $("#roles_table tbody").empty();
        var roles = result.extend.pageInfo.list;
        $.each(roles, function (index, item) {
//            alert(item.roleName);
            var checkBoxTd =$("<td><input type='checkbox' class='check_item'></td>");
            var roleIdTd = $("<td></td>").append(item.id);
            var roleNameTd = $("<td></td>").append(item.name);
            var descriptionTd = $("<td></td>").append(item.description);
//            <button class="btn btn-primary btn-sm">
//                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
//                新增
//                </button>
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义的属性，来表示当前角色的id
            editBtn.attr("edit-id",item.id);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个自定义的属性，来表示当前角色的id
            delBtn.attr("del-id",item.id);
            var btnId = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append方法执行完成后还是返回原来的元素
            $("<tr></tr>")
                .append(checkBoxTd)
                .append(roleIdTd)
                .append(roleNameTd)
                .append(descriptionTd)
                <%--<shiro:hasAnyRoles name="admin">--%>
                .append(btnId)
                <%--</shiro:hasAnyRoles>--%>
                .appendTo("#roles_table tbody");
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
    $("#role_add_modal_btn").click(function () {
        //清除表单数据（表单完全重置（表单的数据，表单的样式））
        reset_form("#roleAddModal form");
        //弹出模态框
        $("#roleAddModal").modal({
            backdrop: "static"
        });
    });

    //校验表单数据,前端正则检验主要为展示错误提示
    function validate_add_form(){
        //1、拿到要检验的数据，使用正则表达式
        //验证角色名
        var roleName = $("#roleName_add_input").val();
        var regName = /^([a-zA-Z0-9_-]{6,16})|(^[\u2E80-\u9FFF]{2,5})$/;
        //alert(regName.test(roleName));
        if(!regName.test(roleName)){
            //alert("用户名可以是2~5位中文或者6~16位英文和数字的组合");
            show_validate_msg("#roleName_add_input","error","角色名可以是2~5位中文或者6~16位英文和数字的组合");
            return false;
        }else{
            show_validate_msg("#roleName_add_input","success","");
        }
        //验证description
        var description = $("#description_add_input").val();
        var regDescription = /^[\s\S]{0,30}$/;
        if(!regDescription.test(description)){
            //alert("邮箱格式不正确");
            //应该清空这个元素之前的样式
            show_validate_msg("#description_add_input","error","字数不能超过30个");
            return false;
        }else{
            show_validate_msg("#description_add_input","success","");
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
    $("#roleName_add_input").change(function () {
        //发送ajax请求校验用户名是否正确（不重复）
        var roleName = $("#roleName_add_input").val();
//        alert("用户名："+roleName);
        $.ajax({
            url:"/checkRoleName",
            type:"POST",
            data:"roleName="+roleName,
            success:function (result) {
                if(result.code==100){
                    show_validate_msg("#roleName_add_input","success","用户名可用");
                    $("#role_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#roleName_add_input","error",result.extend.va_msg);
                    $("#role_save_btn").attr("ajax-va","error");
                }
            }
        });
    });

    //点击保存，保存角色
    $("#role_save_btn").click(function () {
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
        //3.发送ajax请求保存角色
        $.ajax({
            url:"/role",
            type:"POST",
            data:$("#roleAddModal form").serialize(),
            success:function (result) {
                if(result.code==100){
                    //alert(result.msg);
                    //当角色保存成功
                    // 1.关闭模态框
                    $("#roleAddModal").modal('hide');
                    // 2.来到最后一页，显示刚才保存的数据
                    //发送ajax请求显示最后一页即可，用全局变量totalRecord,利用分页插件的特性，传入一个比总页数大的数进去总能显示最后一页
                    to_page(totalRecord);
                }else if(result.code==200){
                    //显示失败信息
                    //console.log(result);
                    //有那个字段的错误信息就显示那个字段的
                    if(undefined != result.extend.errorFields.description){
                        //显示描述错误信息
                        show_validate_msg("#description_add_input","error",result.extend.errorFields.description);
                    }
                    if(undefined != result.extend.errorFields.name){
                        //显示角色名字错误信息
                        show_validate_msg("#roleName_add_input","error",result.extend.errorFields.name);
                    }
                }


            }
        });
    });

    //我们是在按钮创建之前就绑定了click，所以绑定不上
    //1.可以在创建按钮时绑定 2.绑定点击，live
    //jquery新版没有live，使用on进行代替
    $(document).on("click",".edit_btn",function () {

        getRoleById($(this).attr("edit-id"));
        //3.把角色的id传递给模态框的更新按钮
        $("#role_update_btn").attr("edit-id",$(this).attr("edit-id"));
        //弹出模态框
        $("#roleUpdateModal").modal({
            backdrop: "static"
        });
    });
    //单个删除
    $(document).on("click",".delete_btn",function () {
        //弹出是否确认删除对话框
        var roleName = $(this).parents("tr").find("td:eq(2)").text();
        var roleId =$(this).attr("del-id");
        if(confirm("确认删除【"+roleName+"】吗？")){
            //确认，发出ajax请求即可
            $.ajax({
                url:"/role/"+roleId,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    //回到当前页
                    to_page(currentPage);
                }
            });
        }
    });
    //根据角色id拿到角色数据
    function getRoleById(id) {
        $.ajax({
            url:"/role/"+id,
            type:"GET",
            success:function (result) {
                //console.log(result);
                var roleData =result.extend.role;
                $("#roleName_update_input").val(roleData.name);
                $("#description_update_input").val(roleData.description);
            }
        });
    }
    //点击更新，更新角色信息
    $("#role_update_btn").click(function () {
        //验证描述信息
        var description = $("#description_update_input").val();
        var regDescription = /^[\s\S]{0,30}$/;
        if(!regDescription.test(description)){

            show_validate_msg("#description_update_input","error","字数不能超过30个");
            return false;
        }else{
            show_validate_msg("#description_update_input","success","");
        }
        //发送ajax请求保存角色的数据
        $.ajax({
            url:"/role/"+$(this).attr("edit-id"),
            type:"PUT",//如果用POST的话date需加+"&_method=PUT"
            data:$("#roleUpdateModal form").serialize(),
            success:function (result) {
                // alert(result.msg);
                //1.关闭模态框
                $("#roleUpdateModal").modal('hide');
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
    $("#role_delete_all_btn").click(function () {
        var roleNames ="";
        var del_idstr="";
        $.each($(".check_item:checked"),function () {
            roleNames += $(this).parents("tr").find("td:eq(2)").text()+",";//把要删除角色的名字拼起来
            //组装角色id的字符串
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //删除roleNames多于的逗号
        roleNames =roleNames.substring(0,roleNames.length-1);
        del_idstr =del_idstr.substring(0,del_idstr.length-1);
        if(confirm("确认删除【"+roleNames+"】吗？")){
            //发送ajax删除
            $.ajax({
                url:"/role/"+del_idstr,
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

</body>
</html>
