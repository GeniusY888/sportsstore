<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp"/>

<div class="container" style="margin-top:30px;">
    <div class="row">
        <div class="col-md-3">
            <!-- 分类侧边栏 -->
            <div class="panel panel-default">
                <div class="panel-heading"><strong>商品分类</strong></div>
                <div class="list-group" style="margin-bottom:0;">
                    <a href="${pageContext.request.contextPath}/fore/product/list"
                       class="list-group-item ${empty categoryId ? 'active' : ''}">全部分类</a>
                    <c:forEach items="${categories}" var="cat">
                        <a href="${pageContext.request.contextPath}/fore/product/list?categoryId=${cat.id}"
                           class="list-group-item ${categoryId == cat.id ? 'active' : ''}">${cat.name}</a>
                    </c:forEach>
                </div>
            </div>
        </div>

        <div class="col-md-9">
            <!-- 搜索结果提示 -->
            <c:if test="${not empty keyword}">
                <div class="alert alert-info">
                    <i class="fa fa-search"></i> 搜索 "<strong>${keyword}</strong>" 的结果
                </div>
            </c:if>

            <!-- 商品列表 -->
            <div class="row">
                <c:forEach items="${pageInfo.list}" var="p">
                    <div class="col-md-4 col-sm-6">
                        <div class="product-card">
                            <a href="${pageContext.request.contextPath}/fore/product/detail?id=${p.id}">
                                <div class="product-img">
                                    <c:choose>
                                        <c:when test="${not empty p.image}">
                                            <img src="${pageContext.request.contextPath}/${p.image}" alt="${p.name}">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="data:image/svg+xml;charset=UTF-8,<svg xmlns='http://www.w3.org/2000/svg' width='400' height='300'><rect fill='%23f0f0f0' width='400' height='300'/><text fill='%23999' x='200' y='150' text-anchor='middle' font-size='14'>暂无图片</text></svg>" alt="${p.name}">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="product-info">
                                    <h5 class="product-name">${p.name}</h5>
                                    <div class="product-price">
                                        <span class="price-current">¥<fmt:formatNumber value="${p.price}" pattern="#,##0.00"/></span>
                                    </div>
                                    <div class="product-meta">
                                        <span>库存: ${p.stock}</span>
                                        <span class="pull-right">已售: ${p.salesVolume}</span>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty pageInfo.list}">
                    <div class="col-md-12 text-center" style="padding:60px 0;">
                        <i class="fa fa-inbox" style="font-size:48px; color:#ccc;"></i>
                        <p style="color:#999; margin-top:15px;">暂无商品</p>
                    </div>
                </c:if>
            </div>

            <!-- 分页 -->
            <c:if test="${pageInfo.pages > 1}">
                <nav class="text-center">
                    <ul class="pagination">
                        <li class="${pageInfo.isFirstPage ? 'disabled' : ''}">
                            <a href="?pageNum=${pageInfo.prePage}&categoryId=${categoryId}&keyword=${keyword}">&laquo;</a>
                        </li>
                        <c:forEach begin="1" end="${pageInfo.pages}" var="i">
                            <li class="${pageInfo.pageNum == i ? 'active' : ''}">
                                <a href="?pageNum=${i}&categoryId=${categoryId}&keyword=${keyword}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="${pageInfo.isLastPage ? 'disabled' : ''}">
                            <a href="?pageNum=${pageInfo.nextPage}&categoryId=${categoryId}&keyword=${keyword}">&raquo;</a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>
