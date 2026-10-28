<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>500 - 服务器错误</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
<div class="container text-center" style="margin-top:150px;">
    <h1 style="font-size:72px; color:#dc3545;">500</h1>
    <h3>服务器内部错误</h3>
    <p style="color:#999;">抱歉，服务器遇到了问题，请稍后再试</p>
    <p style="color:#999;">${message}</p>
    <a href="${pageContext.request.contextPath}/fore/home" class="btn btn-warning"
       style="background:#ff6b35; border-color:#ff6b35;">返回首页</a>
</div>
</body>
</html>
