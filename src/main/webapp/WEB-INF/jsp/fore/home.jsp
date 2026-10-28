<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp"/>

<!-- ==================== 轮播图 ==================== -->
<div id="mainCarousel" class="carousel slide" data-ride="carousel" style="margin-top:-20px;">
    <!-- 指示器 -->
    <ol class="carousel-indicators">
        <c:forEach items="${carousels}" var="c" varStatus="s">
            <li data-target="#mainCarousel" data-slide-to="${s.index}" class="${s.first ? 'active' : ''}"></li>
        </c:forEach>
    </ol>
    <!-- 轮播项 -->
    <div class="carousel-inner">
        <c:forEach items="${carousels}" var="c" varStatus="s">
            <div class="item ${s.first ? 'active' : ''}">
                <img src="${pageContext.request.contextPath}/${c.imageUrl}"
                     alt="${c.title}" style="width:100%; height:420px; object-fit:cover;
                     background: linear-gradient(to bottom, #fff 0%, #fff 40px, transparent 40px);">
                <div class="carousel-caption">
                    <h3>${c.title}</h3>
                </div>
            </div>
        </c:forEach>
    </div>
    <!-- 左右箭头 -->
    <a class="left carousel-control" href="#mainCarousel" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left"></span>
    </a>
    <a class="right carousel-control" href="#mainCarousel" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right"></span>
    </a>
</div>

<!-- ==================== 热门商品 ==================== -->
<div class="container" style="margin-top:40px;">
    <div class="section-title">
        <h3><i class="fa fa-fire" style="color:#ff6b35;"></i> 热门推荐</h3>
        <a href="${pageContext.request.contextPath}/fore/product/list" class="btn btn-sm btn-link">查看更多 ></a>
    </div>
    <div class="row">
        <c:forEach items="${hotProducts}" var="p">
            <div class="col-md-3 col-sm-6">
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
                            <c:if test="${p.isHot == 1}">
                                <span class="badge badge-hot">热卖</span>
                            </c:if>
                        </div>
                        <div class="product-info">
                            <h5 class="product-name">${p.name}</h5>
                            <div class="product-price">
                                <span class="price-current">¥<fmt:formatNumber value="${p.price}" pattern="#,##0.00"/></span>
                            </div>
                            <div class="product-meta">
                                <span>已售 ${p.salesVolume}</span>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- ==================== 新品推荐 ==================== -->
<div class="container" style="margin-top:30px;">
    <div class="section-title">
        <h3><i class="fa fa-star" style="color:#ff6b35;"></i> 新品上市</h3>
        <a href="${pageContext.request.contextPath}/fore/product/list" class="btn btn-sm btn-link">查看更多 ></a>
    </div>
    <div class="row">
        <c:forEach items="${newProducts}" var="p">
            <div class="col-md-3 col-sm-6">
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
                            <c:if test="${p.isNew == 1}">
                                <span class="badge badge-new">新品</span>
                            </c:if>
                        </div>
                        <div class="product-info">
                            <h5 class="product-name">${p.name}</h5>
                            <div class="product-price">
                                <span class="price-current">¥<fmt:formatNumber value="${p.price}" pattern="#,##0.00"/></span>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="footer.jsp"/>
