<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"/>

<h3><i class="fa fa-tachometer"></i> 控制台</h3>
<hr>

<div class="row">
    <div class="col-md-3">
        <div class="panel panel-primary">
            <div class="panel-body text-center">
                <i class="fa fa-cubes" style="font-size:36px;"></i>
                <h4><a href="${pageContext.request.contextPath}/admin/product/list">商品管理</a></h4>
                <p>新增、编辑、上下架商品</p>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="panel panel-info">
            <div class="panel-body text-center">
                <i class="fa fa-list" style="font-size:36px;"></i>
                <h4><a href="${pageContext.request.contextPath}/admin/category/list">分类管理</a></h4>
                <p>管理商品分类</p>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="panel panel-success">
            <div class="panel-body text-center">
                <i class="fa fa-users" style="font-size:36px;"></i>
                <h4><a href="${pageContext.request.contextPath}/admin/user/list">用户管理</a></h4>
                <p>查看、启用/禁用用户</p>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="panel panel-warning">
            <div class="panel-body text-center">
                <i class="fa fa-file-text" style="font-size:36px;"></i>
                <h4><a href="${pageContext.request.contextPath}/admin/order/list">订单管理</a></h4>
                <p>查看订单、发货处理</p>
            </div>
        </div>
    </div>
</div>

<div class="panel panel-default" style="margin-top:20px;">
    <div class="panel-heading"><strong>快速操作</strong></div>
    <div class="panel-body">
        <a href="${pageContext.request.contextPath}/admin/product/addPage" class="btn btn-primary">
            <i class="fa fa-plus"></i> 新增商品</a>
        <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-info">
            <i class="fa fa-list"></i> 管理分类</a>
        <a href="${pageContext.request.contextPath}/admin/order/list?status=1" class="btn btn-warning">
            <i class="fa fa-truck"></i> 待发货订单</a>
        <a href="${pageContext.request.contextPath}/fore/home" target="_blank" class="btn btn-default">
            <i class="fa fa-eye"></i> 预览前台</a>
    </div>
</div>

<jsp:include page="footer.jsp"/>
