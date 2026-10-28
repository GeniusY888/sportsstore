<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>体育用品商城 - SportsStore</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<!-- ==================== 顶部导航栏 ==================== -->
<nav class="navbar navbar-default navbar-fixed-top" style="background:#1a1a2e; border:none;">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar">
                <span class="sr-only">菜单</span>
                <span class="icon-bar" style="background:#fff;"></span>
                <span class="icon-bar" style="background:#fff;"></span>
                <span class="icon-bar" style="background:#fff;"></span>
            </button>
            <a class="navbar-brand" href="${pageContext.request.contextPath}/fore/home" style="color:#ff6b35; font-weight:bold; font-size:20px;">
                <i class="fa fa-futbol-o"></i> SportsStore
            </a>
        </div>

        <div class="collapse navbar-collapse" id="navbar">
            <ul class="nav navbar-nav">
                <li><a href="${pageContext.request.contextPath}/fore/home" style="color:#fff;">首页</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color:#fff;">
                        全部分类 <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" id="categoryMenu">
                        <c:forEach items="${categories}" var="cat">
                            <li><a href="${pageContext.request.contextPath}/fore/product/list?categoryId=${cat.id}">${cat.name}</a></li>
                        </c:forEach>
                    </ul>
                </li>
            </ul>

            <!-- 搜索框 -->
            <form class="navbar-form navbar-left" action="${pageContext.request.contextPath}/fore/product/list" method="get">
                <div class="input-group">
                    <input type="text" name="keyword" class="form-control" placeholder="搜索体育用品..."
                           value="${keyword}" style="width:250px;">
                    <span class="input-group-btn">
                        <button type="submit" class="btn btn-warning"><i class="fa fa-search"></i></button>
                    </span>
                </div>
            </form>

            <ul class="nav navbar-nav navbar-right">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li><a href="${pageContext.request.contextPath}/fore/cart/list" style="color:#fff;">
                            <i class="fa fa-shopping-cart"></i> 购物车
                            <span id="cartCount" class="badge" style="background:#ff6b35;">0</span>
                        </a></li>
                        <li><a href="${pageContext.request.contextPath}/fore/order/list" style="color:#fff;">
                            <i class="fa fa-list-alt"></i> 我的订单
                        </a></li>
                        <li><a href="${pageContext.request.contextPath}/fore/user/center" style="color:#fff;">
                            <i class="fa fa-user"></i> ${sessionScope.user.username}
                        </a></li>
                        <li><a href="${pageContext.request.contextPath}/fore/user/logout" style="color:#ccc;">退出</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="${pageContext.request.contextPath}/fore/user/loginPage" style="color:#fff;">登录</a></li>
                        <li><a href="${pageContext.request.contextPath}/fore/user/registerPage" style="color:#ff6b35;">注册</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<!-- 占位高度 (避免被固定导航栏遮挡) -->
<div style="padding-top:70px;"></div>
