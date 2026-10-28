<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp"/>

<div class="container" style="margin-top:30px;">
    <h3><i class="fa fa-file-text"></i> 订单详情</h3>
    <hr>

    <div class="row">
        <div class="col-md-8">
            <!-- 订单状态 -->
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
                    <p><strong>下单时间:</strong> <fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                    <c:if test="${not empty order.payTime}">
                        <p><strong>付款时间:</strong> <fmt:formatDate value="${order.payTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                    </c:if>
                    <c:if test="${not empty order.shipTime}">
                        <p><strong>发货时间:</strong> <fmt:formatDate value="${order.shipTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                    </c:if>
                </div>
            </div>

            <!-- 订单明细 -->
            <div class="panel panel-default">
                <div class="panel-heading"><strong>商品明细</strong></div>
                <table class="table">
                    <thead>
                        <tr><th>商品</th><th width="100">单价</th><th width="80">数量</th><th width="100">小计</th></tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${order.orderItems}" var="item">
                            <tr>
                                <td>
                                    ${item.productName}
                                    <c:if test="${not empty item.spec}">
                                        <p style="color:#999; font-size:12px;">规格: ${item.spec}</p>
                                    </c:if>
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
            <!-- 收货信息 -->
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

            <!-- 金额汇总 -->
            <div class="panel panel-default">
                <div class="panel-body text-right">
                    <h4>订单总额:
                        <span style="color:#ff6b35; font-weight:bold;">
                            ¥<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/>
                        </span>
                    </h4>
                </div>
            </div>

            <!-- 操作按钮 -->
            <c:if test="${order.status == 0}">
                <button class="btn btn-warning btn-block" onclick="payOrder(${order.id})">立即支付</button>
                <button class="btn btn-danger btn-block" onclick="cancelOrder(${order.id})">取消订单</button>
            </c:if>
            <c:if test="${order.status == 2}">
                <button class="btn btn-success btn-block" onclick="confirmReceived(${order.id})">确认收货</button>
            </c:if>

            <a href="${pageContext.request.contextPath}/fore/order/list" class="btn btn-default btn-block" style="margin-top:10px;">返回订单列表</a>
        </div>
    </div>
</div>

<script>
function payOrder(id) {
    if (!confirm('确认支付？')) return;
    $.post('${pageContext.request.contextPath}/fore/order/pay', { orderId: id }, function(res) {
        alert(res.msg); if (res.code === 200) location.reload();
    }, 'json');
}
function cancelOrder(id) {
    if (!confirm('确定取消？')) return;
    $.post('${pageContext.request.contextPath}/fore/order/cancel', { orderId: id }, function(res) {
        alert(res.msg); if (res.code === 200) location.reload();
    }, 'json');
}
function confirmReceived(id) {
    if (!confirm('确认已收货？')) return;
    $.post('${pageContext.request.contextPath}/fore/order/confirmReceived', { orderId: id }, function(res) {
        alert(res.msg); if (res.code === 200) location.reload();
    }, 'json');
}
</script>

<jsp:include page="footer.jsp"/>
