<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp"/>

<div class="container" style="margin-top:30px;">
    <h3><i class="fa fa-list-alt"></i> 我的订单</h3>
    <hr>

    <c:choose>
        <c:when test="${not empty pageInfo.list}">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>订单编号</th>
                        <th>金额</th>
                        <th>状态</th>
                        <th>时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${pageInfo.list}" var="order">
                        <tr>
                            <td>${order.orderNo}</td>
                            <td>¥<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.status == 0}"><span class="label label-warning">未付款</span></c:when>
                                    <c:when test="${order.status == 1}"><span class="label label-info">已付款</span></c:when>
                                    <c:when test="${order.status == 2}"><span class="label label-primary">已发货</span></c:when>
                                    <c:when test="${order.status == 3}"><span class="label label-success">已完成</span></c:when>
                                    <c:when test="${order.status == 4}"><span class="label label-default">已取消</span></c:when>
                                </c:choose>
                            </td>
                            <td><fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/fore/order/detail?id=${order.id}"
                                   class="btn btn-xs btn-default">详情</a>
                                <c:if test="${order.status == 0}">
                                    <a href="${pageContext.request.contextPath}/fore/order/payPage?id=${order.id}"
                                       class="btn btn-xs btn-warning">支付</a>
                                    <button class="btn btn-xs btn-danger"
                                            onclick="cancelOrder(${order.id})">取消</button>
                                </c:if>
                                <c:if test="${order.status == 2}">
                                    <button class="btn btn-xs btn-success"
                                            onclick="confirmReceived(${order.id})">确认收货</button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- 分页 -->
            <c:if test="${pageInfo.pages > 1}">
                <nav class="text-center">
                    <ul class="pagination">
                        <li class="${pageInfo.isFirstPage ? 'disabled' : ''}">
                            <a href="?pageNum=${pageInfo.prePage}">&laquo;</a></li>
                        <c:forEach begin="1" end="${pageInfo.pages}" var="i">
                            <li class="${pageInfo.pageNum == i ? 'active' : ''}">
                                <a href="?pageNum=${i}">${i}</a></li>
                        </c:forEach>
                        <li class="${pageInfo.isLastPage ? 'disabled' : ''}">
                            <a href="?pageNum=${pageInfo.nextPage}">&raquo;</a></li>
                    </ul>
                </nav>
            </c:if>
        </c:when>
        <c:otherwise>
            <div class="text-center" style="padding:80px 0;">
                <i class="fa fa-file-text-o" style="font-size:64px; color:#ccc;"></i>
                <h4 style="color:#999; margin-top:20px;">暂无订单</h4>
                <a href="${pageContext.request.contextPath}/fore/home" class="btn btn-warning"
                   style="background:#ff6b35; margin-top:15px;">去逛逛</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
function payOrder(orderId) {
    if (!confirm('确认支付？')) return;
    $.post('${pageContext.request.contextPath}/fore/order/pay', { orderId: orderId }, function(res) {
        alert(res.msg);
        if (res.code === 200) location.reload();
    }, 'json');
}

function cancelOrder(orderId) {
    if (!confirm('确定取消订单？')) return;
    $.post('${pageContext.request.contextPath}/fore/order/cancel', { orderId: orderId }, function(res) {
        alert(res.msg);
        if (res.code === 200) location.reload();
    }, 'json');
}

function confirmReceived(orderId) {
    if (!confirm('确认已收到货物？')) return;
    $.post('${pageContext.request.contextPath}/fore/order/confirmReceived', { orderId: orderId }, function(res) {
        alert(res.msg);
        if (res.code === 200) location.reload();
    }, 'json');
}
</script>

<jsp:include page="footer.jsp"/>
