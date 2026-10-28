<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp"/>

<h3><i class="fa fa-file-text"></i> 订单管理</h3>
<hr>

<div class="row" style="margin-bottom:15px;">
    <div class="col-md-8">
        <form class="form-inline" action="${pageContext.request.contextPath}/admin/order/list" method="get">
            <select name="status" class="form-control">
                <option value="">全部状态</option>
                <option value="0" ${status == 0 ? 'selected' : ''}>未付款</option>
                <option value="1" ${status == 1 ? 'selected' : ''}>已付款</option>
                <option value="2" ${status == 2 ? 'selected' : ''}>已发货</option>
                <option value="3" ${status == 3 ? 'selected' : ''}>已完成</option>
                <option value="4" ${status == 4 ? 'selected' : ''}>已取消</option>
            </select>
            <input type="text" name="orderNo" class="form-control" placeholder="订单号" value="${orderNo}">
            <button type="submit" class="btn btn-default"><i class="fa fa-search"></i> 查询</button>
        </form>
    </div>
</div>

<table class="table table-hover table-striped">
    <thead>
        <tr><th>订单号</th><th>用户</th><th>金额</th><th>状态</th><th>下单时间</th><th>操作</th></tr>
    </thead>
    <tbody>
        <c:forEach items="${pageInfo.list}" var="order">
            <tr>
                <td><code>${order.orderNo}</code></td>
                <td>${order.user.username}</td>
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
                    <a href="${pageContext.request.contextPath}/admin/order/detail?id=${order.id}"
                       class="btn btn-xs btn-info">详情</a>
                    <c:if test="${order.status == 1}">
                        <button class="btn btn-xs btn-primary"
                                onclick="shipOrder(${order.id})">发货</button>
                    </c:if>
                    <c:if test="${order.status == 2}">
                        <button class="btn btn-xs btn-success"
                                onclick="completeOrder(${order.id})">完成</button>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<c:if test="${pageInfo.pages > 1}">
    <nav class="text-center"><ul class="pagination">
        <li><a href="?pageNum=${pageInfo.prePage}&status=${status}&orderNo=${orderNo}">&laquo;</a></li>
        <c:forEach begin="1" end="${pageInfo.pages}" var="i">
            <li class="${pageInfo.pageNum == i ? 'active' : ''}">
                <a href="?pageNum=${i}&status=${status}&orderNo=${orderNo}">${i}</a></li>
        </c:forEach>
        <li><a href="?pageNum=${pageInfo.nextPage}&status=${status}&orderNo=${orderNo}">&raquo;</a></li>
    </ul></nav>
</c:if>

<script>
function shipOrder(id) {
    if (!confirm('确认发货？')) return;
    $.post('${pageContext.request.contextPath}/admin/order/ship', { id: id }, function(res) {
        alert(res.msg);
        if (res.code === 200) location.reload();
    }, 'json');
}
function completeOrder(id) {
    if (!confirm('确认完成此订单？')) return;
    $.post('${pageContext.request.contextPath}/admin/order/complete', { id: id }, function(res) {
        alert(res.msg);
        if (res.code === 200) location.reload();
    }, 'json');
}
</script>

<jsp:include page="footer.jsp"/>
