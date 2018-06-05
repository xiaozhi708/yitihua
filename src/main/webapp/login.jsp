<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/5/005
  Time: 18:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <!--引入JQuery-->
    <script type="text/javascript" src="/static/js/jquery-3.3.1.min.js"></script>
    <!--引入bootstrap样式-->
    <link href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<form action="logon" method="post">
    <div class="input-group">
        <button type="button" class="btn btn-default" aria-label="Left Align">
            <span class="glyphicon glyphicon-user" id="basic-addon1"></span>
        </button>
        <input type="text" class="form-control" placeholder="Username" aria-describedby="basic-addon1">
    </div>
    <div class="input-group">
        <button type="button" class="btn btn-default" aria-label="Left Align">
            <span class="glyphicon glyphicon-eye-close" id="basic-addon2"></span>
        </button>
        <input type="text" class="form-control" placeholder="Password" aria-describedby="basic-addon1">
    </div>
    <input type="submit" value="Logon"/>
</form>

</body>
</html>
