<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>后台管理 - SportsStore</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 顶部导航 -->
<nav class="navbar navbar-inverse navbar-fixed-top" style="background:#1a1a2e; border:none;">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard"
               style="color:#ff6b35; font-weight:bold;">
                <i class="fa fa-dashboard"></i> SportsStore 后台
            </a>
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="${pageContext.request.contextPath}/fore/home" target="_blank" style="color:#fff;">
                <i class="fa fa-eye"></i> 查看前台</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/logout" style="color:#fff;">
                <i class="fa fa-sign-out"></i> 退出</a></li>
        </ul>
    </div>
</nav>

<!-- 侧边栏 -->
<div style="position:fixed; left:0; top:50px; width:200px; bottom:0; background:#2c3e50; overflow-y:auto;">
    <ul class="nav nav-pills nav-stacked" style="padding-top:20px;">
        <li id="menuDashboard">
            <a href="${pageContext.request.contextPath}/admin/dashboard" style="color:#fff; border-radius:0;">
                <i class="fa fa-tachometer"></i> 控制台</a></li>
        <li id="menuCategory">
            <a href="${pageContext.request.contextPath}/admin/category/list" style="color:#fff; border-radius:0;">
                <i class="fa fa-list"></i> 分类管理</a></li>
        <li id="menuProduct">
            <a href="${pageContext.request.contextPath}/admin/product/list" style="color:#fff; border-radius:0;">
                <i class="fa fa-cubes"></i> 商品管理</a></li>
        <li id="menuUser">
            <a href="${pageContext.request.contextPath}/admin/user/list" style="color:#fff; border-radius:0;">
                <i class="fa fa-users"></i> 用户管理</a></li>
        <li id="menuOrder">
            <a href="${pageContext.request.contextPath}/admin/order/list" style="color:#fff; border-radius:0;">
                <i class="fa fa-file-text"></i> 订单管理</a></li>
    </ul>
</div>

<!-- 主内容区 -->
<div style="margin-left:200px; padding:20px; padding-top:50px;">
