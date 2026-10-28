<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>404 - 页面未找到</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
<div class="container text-center" style="margin-top:150px;">
    <h1 style="font-size:72px; color:#ff6b35;">404</h1>
    <h3>页面未找到</h3>
    <p style="color:#999;">您访问的页面不存在或已被移除</p>
    <a href="${pageContext.request.contextPath}/fore/home" class="btn btn-warning"
       style="background:#ff6b35; border-color:#ff6b35;">返回首页</a>
</div>
</body>
</html>
