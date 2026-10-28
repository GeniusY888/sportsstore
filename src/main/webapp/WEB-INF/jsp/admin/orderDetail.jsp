<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp"/>

<h3><i class="fa fa-file-text"></i> 订单详情</h3>
<hr>

<div class="row">
    <div class="col-md-8">
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>订单编号: ${order.orderNo}</strong>
                <span class="pull-right">
                    <c:choose>
                        <c:when test="${order.status == 0}"><span class="label label-warning">未付款</span></c:when>
                        <c:when test="${order.status == 1}"><span class="label label-info">已付款</span></c:when>
                        <c:when test="${order.status == 2}"><span class="label label-primary">已发货</span></c:when>
                        <c:when test="${order.status == 3}"><span class="label label-success">已完成</span></c:when>
                        <c:when test="${order.status == 4}"><span class="label label-default">已取消</span></c:when>
                    </c:choose>
                </span>
            </div>
            <div class="panel-body">
                <p><strong>下单用户:</strong> ${order.user.username}</p>
                <p><strong>下单时间:</strong> <fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                <c:if test="${not empty order.payTime}">
                    <p><strong>付款时间:</strong> <fmt:formatDate value="${order.payTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                </c:if>
                <c:if test="${not empty order.shipTime}">
                    <p><strong>发货时间:</strong> <fmt:formatDate value="${order.shipTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                </c:if>
                <c:if test="${not empty order.completeTime}">
                    <p><strong>完成时间:</strong> <fmt:formatDate value="${order.completeTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                </c:if>
            </div>
        </div>

        <!-- 商品明细 -->
        <div class="panel panel-default">
            <div class="panel-heading"><strong>商品明细</strong></div>
            <table class="table">
                <thead><tr><th>商品</th><th>单价</th><th>数量</th><th>小计</th></tr></thead>
                <tbody>
                    <c:forEach items="${order.orderItems}" var="item">
                        <tr>
                            <td>
                                <c:if test="${not empty item.productImage}">
                                    <img src="${pageContext.request.contextPath}/${item.productImage}"
                                         width="40" height="40" style="object-fit:cover; margin-right:8px;">
                                </c:if>
                                ${item.productName}
                            </td>
                            <td>¥<fmt:formatNumber value="${item.productPrice}" pattern="#,##0.00"/></td>
                            <td>${item.quantity}</td>
                            <td>¥<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="col-md-4">
        <div class="panel panel-default">
            <div class="panel-heading"><strong>收货信息</strong></div>
            <div class="panel-body">
                <p>收货人: ${order.receiverName}</p>
                <p>电话: ${order.receiverPhone}</p>
                <p>地址: ${order.receiverAddress}</p>
                <c:if test="${not empty order.remark}">
                    <p>备注: ${order.remark}</p>
                </c:if>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-body text-right">
                <h4>订单总额:
                    <span style="color:#ff6b35; font-weight:bold;">
                        ¥<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/>
                    </span>
                </h4>
            </div>
        </div>

        <!-- 管理员操作 -->
        <c:if test="${order.status == 1}">
            <button class="btn btn-primary btn-block" onclick="shipOrder(${order.id})">
                <i class="fa fa-truck"></i> 发货</button>
        </c:if>
        <c:if test="${order.status == 2}">
            <button class="btn btn-success btn-block" onclick="completeOrder(${order.id})">
                <i class="fa fa-check"></i> 标记完成</button>
        </c:if>

        <a href="${pageContext.request.contextPath}/admin/order/list" class="btn btn-default btn-block"
           style="margin-top:10px;">返回列表</a>
    </div>
</div>

<script>
function shipOrder(id) {
    if (!confirm('确认发货？')) return;
    $.post('${pageContext.request.contextPath}/admin/order/ship', { id: id }, function(res) {
        alert(res.msg); if (res.code === 200) location.reload();
    }, 'json');
}
function completeOrder(id) {
    if (!confirm('确认完成此订单？')) return;
    $.post('${pageContext.request.contextPath}/admin/order/complete', { id: id }, function(res) {
        alert(res.msg); if (res.code === 200) location.reload();
    }, 'json');
}
</script>

<jsp:include page="footer.jsp"/>
