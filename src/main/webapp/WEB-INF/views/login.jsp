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
    <title>企业员工管理</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <!--引入JQuery-->
    <script type="text/javascript" src="/static/js/jquery-3.3.1.min.js"></script>
    <!--引入bootstrap样式-->
    <link href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="shortcut icon" href="favicon.ico">
    <link href='https://fonts.googleapis.com/css?family=Varela+Round' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="/static/css/bootstrap.css">
    <!-- Flexslider  -->
    <link rel="stylesheet" href="/static/css/flexslider.css">
    <!-- Theme style  -->
    <link rel="stylesheet" href="/static/css/style.css">
    <link rel="stylesheet" type="text/css" href="/static/css/demo.css" />
    <link rel="stylesheet" type="text/css" href="/static/css/style0.css" />
    <script src="/static/js/modernizr-2.6.2.min.js"></script>
</head>
<body>
<div id="fh5co-page">
    <header id="fh5co-header" role="banner">
        <div class="container">
            <div class="row">
                <div class="header-inner">
                    <a href="home.html"><h1 class="biaoti">企业员工管理</h1></a>
                </div>
            </div>
        </div>
    </header>
</div>
<aside id="fh5co-hero" clsas="js-fullheight">
    <div class="flexslider js-fullheight">
        <ul class="slides">
            <li style="background-image: url(/static/images/slide_1.jpg);">
            </li>
            <li style="background-image: url(/static/images/slide_2.jpg);">
            </li>
            <li style="background-image: url(/static/images/slide_3.jpg);">
            </li>
        </ul>
    </div>
</aside>
</div>
<div class="login-wapper">
    <section>
        <div id="container_demo" >
            <a class="hiddenanchor" id="toregister"></a>
            <a class="hiddenanchor" id="tologin"></a>
            <div id="wrapper">
                <div id="login" class="animate form">
                    <form  action="/login" method="post" autocomplete="on">
                        <h1>登录</h1>
                        <p>
                            <label for="username" class="uname" >请输入您的账号 </label>
                            <input id="username" name="username" required="required" type="text" placeholder="账号"/>
                        </p>
                        <p>
                            <label for="password" class="youpasswd">请输入您的密码</label>
                            <input id="password" name="password" required="required" type="password" placeholder="密码" />
                        </p>
                        <p class="keeplogin">
                            <input type="checkbox" name="loginkeeping" id="loginkeeping" value="loginkeeping" />
                            <label for="loginkeeping">记住密码</label>
                        </p>
                        <span class="error-tip">${error}</span>
                        <p class="login button">
                            <input type="submit" value="登录" />
                        </p>
                    </form>
                </div>

            </div>
        </div>
    </section>
</div>
<!-- jQuery -->
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/jquery.flexslider-min.js"></script>
<!-- MAIN JS -->
<script src="/static/js/main.js"></script>
</body>
</html>
