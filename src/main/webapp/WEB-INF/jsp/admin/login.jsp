<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员登录 - SportsStore</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
</head>
<body style="background:#1a1a2e;">

<div class="container" style="margin-top:120px;">
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <div class="text-center" style="margin-bottom:30px;">
                <h1 style="color:#ff6b35;"><i class="fa fa-futbol-o"></i> SportsStore</h1>
                <p style="color:#aaa;">后台管理系统</p>
            </div>
            <div class="panel panel-default">
                <div class="panel-body">
                    <form id="loginForm">
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                <input type="text" name="username" id="username" class="form-control"
                                       placeholder="管理员账号" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                                <input type="password" name="password" id="password" class="form-control"
                                       placeholder="管理员密码" required>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning btn-block"
                                style="background:#ff6b35; border-color:#ff6b35;">
                            管理员登录
                        </button>
                    </form>
                    <div id="loginMsg" class="text-center" style="margin-top:15px; color:red;"></div>
                </div>
            </div>
            <p class="text-center" style="color:#666;">默认管理员: admin / admin123</p>
        </div>
    </div>
</div>

<script>
$('#loginForm').submit(function(e) {
    e.preventDefault();
    $.post('${pageContext.request.contextPath}/admin/doLogin', {
        username: $('#username').val(),
        password: $('#password').val()
    }, function(res) {
        if (res.code === 200) {
            window.location.href = '${pageContext.request.contextPath}/admin/dashboard';
        } else {
            $('#loginMsg').text(res.msg);
        }
    }, 'json');
});
</script>
</body>
</html>
