<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/24/024
  Time: 20:01
  To change this template use File | Settings | File Templates.
  普通版，先进入index.jsp页面，页面中只要<jsp:forward page="/emps"></jsp:forward>这句有用的话，发出emps的请求，
  controller得到请求将数据查出来显示到list.jsp页面（最好用ajax版，进入index.jsp页面，发送ajax请求，得到数据后在index.jsp页面用js将数据构建出来）
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <!--web路径
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题
    以/开始的相对路径，找资源，以服务器的根路径为标准（http:localhost:3306）,需要加上项目名
    -->
    <%--<!--引入JQuery-->--%>
    <%--<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>--%>
    <%--<!--引入bootstrap样式-->--%>
    <%--<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">--%>
    <%--<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>--%>
    <!--引入JQuery-->
    <script type="text/javascript" src="/static/js/jquery-3.3.1.min.js"></script>
    <!--引入bootstrap样式-->
    <link href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!--搭建显示页面-->
<div class="container">
    <!--标题行-->
    <div class="row">
        <div class=".col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!--增加，删除按钮-->
    <div class="row">
        <div class="col-lg-4 col-lg-offset-8">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <!--显示表格信息-->
    <div class="row">
        <div class="col-lg-12">
            <table class="table table-hover">
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>departmentName</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <th>${emp.empId}</th>
                        <th>${emp.empName}</th>
                        <th>${emp.gender=="M"?"男":"女"}</th>
                        <th>${emp.email}</th>
                        <th>${emp.department.deptName}</th>
                        <th>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                新增
                            </button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除
                            </button>
                        </th>
                    </tr>
                </c:forEach>

            </table>
        </div>
    </div>
    <!--分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-lg-6">
            当前第${pageInfo.pageNum}页,总${pageInfo.pages}页,总${pageInfo.total}条记录
        </div>
        <!--分页条信息-->
        <div class="col-lg-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="/emps?pn=1">首页</a></li>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_num">
                        <c:if test="${page_num==pageInfo.pageNum}">
                            <li class="active"><a href="#">${page_num}</a></li>
                        </c:if>
                        <c:if test="${page_num!=pageInfo.pageNum}">
                            <li><a href="/emps?pn=${page_num}">${page_num}</a></li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                    <li>
                        <a href="/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                    </c:if>
                    <li><a href="/emps?pn=${pageInfo.pages}">末页</a></li>
                </ul>
            </nav>
        </div>

    </div>
</div>
</body>
</html>
