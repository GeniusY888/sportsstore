<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp"/>

<div class="container" style="margin-top:30px;">
    <div class="row">
        <!-- 商品图片 -->
        <div class="col-md-5">
            <c:choose>
                <c:when test="${not empty product.image}">
                    <img src="${pageContext.request.contextPath}/${product.image}"
                         alt="${product.name}" class="img-responsive" style="width:100%; border-radius:8px;">
                </c:when>
                <c:otherwise>
                    <img src="data:image/svg+xml;charset=UTF-8,<svg xmlns='http://www.w3.org/2000/svg' width='400' height='300'><rect fill='%23f0f0f0' width='400' height='300'/><text fill='%23999' x='200' y='150' text-anchor='middle' font-size='14'>暂无图片</text></svg>"
                         alt="${product.name}" class="img-responsive" style="width:100%;">
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 商品信息 -->
        <div class="col-md-7">
            <h2>${product.name}</h2>
            <p style="color:#999;">分类: ${product.category.name}</p>

            <div style="background:#fff5f0; padding:15px; border-radius:6px; margin:20px 0;">
                <span style="font-size:32px; color:#ff6b35; font-weight:bold;">
                    ¥<fmt:formatNumber value="${product.price}" pattern="#,##0.00"/>
                </span>
                <div style="margin-top:10px;">
                    <span id="avgRating">--</span>
                    <span style="color:#999; margin-left:10px;" id="reviewCount">0</span> 条评价
                </div>
            </div>

            <div class="product-detail-info">
                <p><strong>库存:</strong>
                    <c:choose>
                        <c:when test="${product.stock > 0}">
                            <span style="color:green;">${product.stock} 件</span>
                        </c:when>
                        <c:otherwise>
                            <span style="color:red;">暂时缺货</span>
                        </c:otherwise>
                    </c:choose>
                </p>
                <p><strong>已售:</strong> ${product.salesVolume} 件</p>
            </div>

            <div style="margin:20px 0;">
                <div id="specContainer" style="margin-bottom:20px;">
                    <c:forEach items="${specGroups}" var="group">
                        <div class="form-group">
                            <label><strong>${group.name}:</strong></label>
                            <div class="spec-options">
                                <c:forEach items="${group.values}" var="value">
                                    <label class="spec-option">
                                        <input type="radio" name="spec_${group.id}" value="${value.value}" class="spec-radio">
                                        <span>${value.value}</span>
                                    </label>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="input-group" style="width:150px; display:inline-block;">
                    <span class="input-group-btn">
                        <button class="btn btn-default" type="button" onclick="changeQty(-1)">-</button>
                    </span>
                    <input type="text" id="quantity" class="form-control text-center" value="1" readonly>
                    <span class="input-group-btn">
                        <button class="btn btn-default" type="button" onclick="changeQty(1)">+</button>
                    </span>
                </div>
                <button type="button" class="btn btn-lg btn-warning" style="background:#ff6b35; border-color:#ff6b35;
                        margin-left:15px; padding:10px 30px;" onclick="addToCart()">
                    <i class="fa fa-cart-plus"></i> 加入购物车
                </button>
            </div>

            <div class="alert alert-warning" id="cartMsg" style="display:none;"></div>
        </div>
    </div>

    <!-- 商品描述 -->
    <div class="row" style="margin-top:40px;">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading"><strong>商品详情</strong></div>
                <div class="panel-body">
                    <c:choose>
                        <c:when test="${not empty product.description}">
                            ${product.description}
                        </c:when>
                        <c:otherwise>
                            <p style="color:#999;">暂无详细描述</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- 商品评价 -->
    <div class="row" style="margin-top:40px;">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong>用户评价</strong>
                    <button type="button" id="reviewBtn" class="btn btn-primary btn-sm pull-right" 
                            onclick="showReviewForm()" style="display:none;">
                        发表评价
                    </button>
                </div>
                <div class="panel-body">
                    <!-- 评价表单 -->
                    <div id="reviewForm" style="display:none; margin-bottom:30px; padding:20px; background:#f9f9f9; border-radius:6px;">
                        <div class="form-group review-form-group">
                            <label>评分:</label>
                            <div class="star-rating">
                                <input type="radio" name="rating" value="5" id="star5"><label for="star5">★</label>
                                <input type="radio" name="rating" value="4" id="star4"><label for="star4">★</label>
                                <input type="radio" name="rating" value="3" id="star3"><label for="star3">★</label>
                                <input type="radio" name="rating" value="2" id="star2"><label for="star2">★</label>
                                <input type="radio" name="rating" value="1" id="star1"><label for="star1">★</label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>评价内容:</label>
                            <textarea id="reviewContent" class="form-control" rows="3" placeholder="请输入您的评价..."></textarea>
                        </div>
                        <button type="button" class="btn btn-primary" onclick="submitReview()">提交评价</button>
                        <button type="button" class="btn btn-default" onclick="hideReviewForm()">取消</button>
                        <div class="alert alert-warning" id="reviewMsg" style="display:none; margin-top:10px;"></div>
                    </div>

                    <!-- 评价列表 -->
                    <div id="reviewList" style="display:none;">
                        <p style="text-align:center; color:#999; padding:40px;">加载中...</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.spec-options {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin-top: 8px;
}
.spec-option {
    display: inline-flex;
    align-items: center;
    padding: 6px 16px;
    border: 1px solid #ddd;
    border-radius: 4px;
    cursor: pointer;
    transition: all 0.2s;
    background: #fff;
}
.spec-option:hover {
    border-color: #ff6b35;
}
.spec-option input[type="radio"] {
    display: none;
}
.spec-option span {
    font-size: 14px;
    color: #333;
}
.spec-option input[type="radio"]:checked + span {
    color: #ff6b35;
}
.spec-option input[type="radio"]:checked {
    border-color: #ff6b35;
    background: #fff5f0;
}
.review-form-group {
    display: flex;
    align-items: center;
}
.review-form-group label {
    margin-right: 15px;
    font-weight: normal;
}
.star-rating {
    font-size: 30px;
    color: #ddd;
}
.star-rating input {
    display: none;
}
.star-rating label {
    float: right;
    cursor: pointer;
}
.star-rating label:hover,
.star-rating label:hover ~ label,
.star-rating input:checked ~ label {
    color: #ffc107;
}
.star-rating label:last-child {
    margin-left: 0;
}
.review-item {
    padding: 15px 0;
    border-bottom: 1px solid #eee;
}
.review-item:last-child {
    border-bottom: none;
}
.review-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
}
.review-user-time {
    display: flex;
    align-items: center;
    gap: 15px;
}
.review-user {
    font-weight: bold;
    color: #333;
}
.review-time {
    color: #999;
    font-size: 12px;
}
.review-actions {
    margin-left: auto;
}
.review-delete {
    margin-left: 15px;
}
.review-rating {
    color: #ffc107;
    font-size: 16px;
}
.review-content {
    color: #666;
    line-height: 1.6;
}
.empty-review {
    text-align: center;
    color: #999;
    padding: 40px;
}
</style>

<script>
function changeQty(delta) {
    var qty = parseInt($('#quantity').val()) + delta;
    if (qty < 1) qty = 1;
    if (qty > ${product.stock}) qty = ${product.stock};
    $('#quantity').val(qty);
}

function addToCart() {
    <c:if test="${empty sessionScope.user}">
        alert('请先登录');
        window.location.href = '${pageContext.request.contextPath}/fore/user/loginPage';
        return;
    </c:if>
    var specParts = [];
    $('.spec-radio:checked').each(function() {
        specParts.push($(this).val());
    });
    var spec = specParts.length > 0 ? specParts.join(',') : '';
    $.post('${pageContext.request.contextPath}/fore/cart/add', {
        productId: ${product.id},
        quantity: $('#quantity').val(),
        spec: spec
    }, function(res) {
        var msg = $('#cartMsg');
        msg.show();
        if (res.code === 200) {
            msg.removeClass('alert-warning').addClass('alert-success').text(res.msg);
            $.get('${pageContext.request.contextPath}/fore/cart/count', function(r) {
                if (r.code === 200) $('#cartCount').text(r.data);
            });
        } else {
            msg.removeClass('alert-success').addClass('alert-warning').text(res.msg);
        }
        setTimeout(function() { msg.fadeOut(); }, 2000);
    }, 'json');
}

function loadReviewStats() {
    $.get('${pageContext.request.contextPath}/fore/review/stats', {
        productId: ${product.id}
    }, function(res) {
        if (res.code === 200) {
            var data = res.data;
            $('#reviewCount').text(data.count);
            if (data.count > 0) {
                var stars = generateStars(data.avgRating);
                $('#avgRating').html(stars + ' ' + data.avgRating.toFixed(1) + '分');
            } else {
                $('#avgRating').html('<span style="color:#ddd;">暂无评分</span>');
            }
        }
    }, 'json');
}

function loadReviews() {
    $('#reviewList').html('<p style="text-align:center; color:#999; padding:40px;">加载中...</p>');
    $.ajax({
        url: '${pageContext.request.contextPath}/fore/review/list',
        type: 'GET',
        data: { productId: ${product.id} },
        dataType: 'json',
        success: function(res) {
            if (res && res.code === 200 && res.data) {
                var reviews = res.data;
                if (reviews.length === 0) {
                    $('#reviewList').html('<p class="empty-review">暂无评价，快来发表第一条评价吧！</p>');
                } else {
                    var html = '';
                    var currentUserId = '<c:out value="${sessionScope.user.id}"/>';
                    currentUserId = currentUserId ? parseInt(currentUserId) : 0;
                    $.each(reviews, function(index, r) {
                        var stars = generateStars(r.rating);
                        var time = formatDate(new Date(r.createTime));
                        var deleteBtn = '';
                        if (currentUserId > 0 && r.user && r.user.id === currentUserId) {
                            deleteBtn = '<button class="btn btn-xs btn-danger" onclick="deleteReview(' + r.id + ')">删除</button>';
                        }
                        html += '<div class="review-item" id="review_' + r.id + '">' +
                            '<div class="review-header">' +
                            '<div class="review-user-time">' +
                            '<span class="review-user">' + r.user.username + '</span>' +
                            '<span class="review-time">' + time + '</span>' +
                            '</div>' +
                            '<div class="review-actions">' + deleteBtn + '</div>' +
                            '</div>' +
                            '<div class="review-rating">' + stars + '</div>' +
                            '<div class="review-content">' + r.content + '</div>' +
                            '</div>';
                    });
                    $('#reviewList').html(html);
                }
                $('#reviewList').show();
            }
        },
        error: function() {
            $('#reviewList').html('<p class="empty-review">加载评价失败，请稍后重试</p>');
            $('#reviewList').show();
        }
    });
}

function generateStars(rating) {
    var stars = '';
    for (var i = 1; i <= 5; i++) {
        if (i <= rating) {
            stars += '★';
        } else {
            stars += '☆';
        }
    }
    return stars;
}

function formatDate(date) {
    var year = date.getFullYear();
    var month = (date.getMonth() + 1).toString().padStart(2, '0');
    var day = date.getDate().toString().padStart(2, '0');
    var hours = date.getHours().toString().padStart(2, '0');
    var minutes = date.getMinutes().toString().padStart(2, '0');
    return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes;
}

function deleteReview(reviewId) {
    if (!confirm('确定要删除这条评价吗？')) {
        return;
    }
    $.ajax({
        url: '${pageContext.request.contextPath}/fore/review/delete',
        type: 'POST',
        data: { id: reviewId },
        dataType: 'json',
        success: function(res) {
            if (res && res.code === 200) {
                $('#review_' + reviewId).fadeOut('slow', function() {
                    $(this).remove();
                    loadReviewStats();
                });
                alert('删除成功');
            } else {
                alert(res ? res.msg : '删除失败');
            }
        },
        error: function() {
            alert('网络错误，请稍后重试');
        }
    });
}

function showReviewForm() {
    $('#reviewForm').show();
}

function hideReviewForm() {
    $('#reviewForm').hide();
    $('#reviewContent').val('');
    $('input[name="rating"]').prop('checked', false);
    $('#reviewMsg').hide();
}

function submitReview() {
    var rating = $('input[name="rating"]:checked').val();
    var content = $('#reviewContent').val().trim();
    
    if (!rating) {
        showReviewMsg('请选择评分', 'error');
        return;
    }
    if (!content) {
        showReviewMsg('请输入评价内容', 'error');
        return;
    }

    var ctx = '${pageContext.request.contextPath}';
    $.ajax({
        url: ctx + '/fore/review/add',
        type: 'POST',
        data: {
            productId: ${product.id},
            rating: parseInt(rating),
            content: content
        },
        dataType: 'json',
        success: function(res) {
            if (res && res.code === 200) {
                showReviewMsg(res.msg, 'success');
                setTimeout(function() {
                    hideReviewForm();
                    loadReviewStats();
                    loadReviews();
                }, 1000);
            } else {
                showReviewMsg(res ? res.msg : '提交失败', 'error');
            }
        },
        error: function(xhr, status, error) {
            showReviewMsg('网络错误，请稍后重试', 'error');
            console.error('评价提交失败:', error);
        }
    });
}

function showReviewMsg(msg, type) {
    var el = $('#reviewMsg');
    el.show().text(msg);
    if (type === 'success') {
        el.removeClass('alert-warning').addClass('alert-success');
    } else {
        el.removeClass('alert-success').addClass('alert-warning');
    }
}

function checkCanReview() {
    $.get('${pageContext.request.contextPath}/fore/review/canReview', {
        productId: ${product.id}
    }, function(res) {
        if (res && res.code === 200 && res.data) {
            $('#reviewBtn').show();
        }
    }, 'json');
}

$(document).ready(function() {
    loadReviewStats();
    loadReviews();
    checkCanReview();
    
    $('input[name="rating"]').click(function() {
        $('.star-rating label').css('color', '#ddd');
        var selected = parseInt($(this).val());
        for (var i = 5; i >= 5 - selected + 1; i--) {
            $('#star' + i).next('label').css('color', '#ffc107');
        }
    });
});
</script>

<jsp:include page="footer.jsp"/>