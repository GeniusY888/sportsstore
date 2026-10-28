<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp"/>

<div class="container" style="margin-top:30px;">
    <h3><i class="fa fa-shopping-cart"></i> 我的购物车</h3>
    <hr>

    <c:choose>
        <c:when test="${not empty cartList}">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th width="100">图片</th>
                        <th>商品名称</th>
                        <th width="120">单价</th>
                        <th width="160">数量</th>
                        <th width="120">小计</th>
                        <th width="80">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${cartList}" var="cart">
                        <tr id="cartRow${cart.id}">
                            <td>
                                <c:choose>
                                    <c:when test="${not empty cart.product.image}">
                                        <img src="${pageContext.request.contextPath}/${cart.product.image}"
                                             alt="${cart.product.name}" width="70" height="70" style="object-fit:cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="data:image/svg+xml;charset=UTF-8,<svg xmlns='http://www.w3.org/2000/svg' width='400' height='300'><rect fill='%23f0f0f0' width='400' height='300'/><text fill='%23999' x='200' y='150' text-anchor='middle' font-size='14'>暂无图片</text></svg>"
                                             width="70" height="70">
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/fore/product/detail?id=${cart.product.id}">
                                    ${cart.product.name}
                                </a>
                                <c:if test="${not empty cart.spec}">
                                    <p style="color:#999; font-size:12px; margin-top:4px;">规格: ${cart.spec}</p>
                                </c:if>
                            </td>
                            <td>¥<fmt:formatNumber value="${cart.product.price}" pattern="#,##0.00"/></td>
                            <td>
                                <div class="input-group input-group-sm" style="width:120px;">
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" onclick="updateQty(${cart.id}, -1)">-</button>
                                    </span>
                                    <input type="text" id="qty${cart.id}" value="${cart.quantity}"
                                           class="form-control text-center" readonly>
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" onclick="updateQty(${cart.id}, 1)">+</button>
                                    </span>
                                </div>
                            </td>
                            <td class="text-danger" id="subtotal${cart.id}">
                                ¥<fmt:formatNumber value="${cart.subtotal}" pattern="#,##0.00"/>
                            </td>
                            <td>
                                <button class="btn btn-sm btn-danger" onclick="deleteCart(${cart.id})">删除</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- 结算栏 -->
            <div class="row" style="margin-top:20px;">
                <div class="col-md-4 col-md-offset-8">
                    <div class="panel panel-default">
                        <div class="panel-body text-right">
                            <p>商品总计: <span id="cartTotal" class="text-danger" style="font-size:24px;
                                font-weight:bold;">¥<fmt:formatNumber value="${total}" pattern="#,##0.00"/></span></p>
                            <button class="btn btn-danger btn-block" onclick="clearCart()">清空购物车</button>
                            <a href="${pageContext.request.contextPath}/fore/order/checkout"
                               class="btn btn-warning btn-block" style="background:#ff6b35;
                               border-color:#ff6b35; margin-top:10px;">去结算</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center" style="padding:80px 0;">
                <i class="fa fa-shopping-cart" style="font-size:64px; color:#ccc;"></i>
                <h4 style="color:#999; margin-top:20px;">购物车还是空的</h4>
                <a href="${pageContext.request.contextPath}/fore/home" class="btn btn-warning"
                   style="background:#ff6b35; border-color:#ff6b35; margin-top:15px;">去逛逛</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
function updateQty(cartId, delta) {
    var curQty = parseInt($('#qty' + cartId).val());
    var newQty = curQty + delta;
    if (newQty < 1) return;
    $.post('${pageContext.request.contextPath}/fore/cart/updateQuantity', {
        id: cartId, quantity: newQty
    }, function(res) {
        if (res.code === 200) {
            location.reload();
        } else {
            alert(res.msg);
        }
    }, 'json');
}

function deleteCart(cartId) {
    if (!confirm('确定要移除该商品吗？')) return;
    $.post('${pageContext.request.contextPath}/fore/cart/delete', { id: cartId }, function(res) {
        if (res.code === 200) {
            $('#cartRow' + cartId).fadeOut(function() { location.reload(); });
        }
    }, 'json');
}

function clearCart() {
    if (!confirm('确定要清空购物车吗？')) return;
    $.post('${pageContext.request.contextPath}/fore/cart/clear', function(res) {
        if (res.code === 200) location.reload();
    }, 'json');
}
</script>

<jsp:include page="footer.jsp"/>
