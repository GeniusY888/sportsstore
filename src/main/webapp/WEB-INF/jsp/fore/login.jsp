<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户登录 - 体育用品商城</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
</head>
<body style="background:#f5f5f5;">

<div class="container" style="margin-top:80px;">
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <div class="panel panel-default">
                <div class="panel-heading" style="background:#1a1a2e; color:#fff;">
                    <h3 class="panel-title text-center"><i class="fa fa-sign-in"></i> 用户登录</h3>
                </div>
                <div class="panel-body">
                    <form id="loginForm">
                        <div class="form-group">
                            <label>用户名</label>
                            <input type="text" name="username" id="username" class="form-control"
                                   placeholder="请输入用户名" required>
                        </div>
                        <div class="form-group">
                            <label>密码</label>
                            <input type="password" name="password" id="password" class="form-control"
                                   placeholder="请输入密码" required>
                        </div>
                        <button type="submit" class="btn btn-warning btn-block" style="background:#ff6b35; border-color:#ff6b35;">
                            登 录
                        </button>
                    </form>
                    <div class="text-center" style="margin-top:15px;">
                        <a href="${pageContext.request.contextPath}/fore/user/registerPage">还没有账号？立即注册</a>
                        &nbsp;|&nbsp;
                        <a href="${pageContext.request.contextPath}/fore/home">返回首页</a>
                    </div>
                    <div id="loginMsg" class="text-center" style="margin-top:10px; color:red;"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
$('#loginForm').submit(function(e) {
    e.preventDefault();
    $.post('${pageContext.request.contextPath}/fore/user/login', {
        username: $('#username').val(),
        password: $('#password').val()
    }, function(res) {
        if (res.code === 200) {
            window.location.href = '${pageContext.request.contextPath}/fore/home';
        } else {
            $('#loginMsg').text(res.msg);
        }
    }, 'json');
});
</script>
</body>
</html>
