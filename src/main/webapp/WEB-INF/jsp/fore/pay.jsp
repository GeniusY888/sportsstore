<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp"/>

<style>
.pay-container {
    max-width: 600px;
    margin: 0 auto;
    padding: 30px 0;
}
.pay-header {
    text-align: center;
    margin-bottom: 30px;
}
.pay-header h3 {
    color: #333;
    font-size: 24px;
}
.pay-card {
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 2px 12px rgba(0,0,0,0.08);
    padding: 25px;
    margin-bottom: 20px;
}
.pay-method {
    display: flex;
    align-items: center;
    padding: 15px 20px;
    border: 2px solid #eee;
    border-radius: 8px;
    margin-bottom: 15px;
    cursor: pointer;
    transition: all 0.2s;
}
.pay-method:hover {
    border-color: #ff6b35;
}
.pay-method.active {
    border-color: #ff6b35;
    background: #fff5f0;
}
.pay-method-icon {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
    margin-right: 15px;
}
.wechat-icon {
    background: #07c160;
    color: #fff;
}
.alipay-icon {
    background: #1677ff;
    color: #fff;
}
.pay-method-info {
    flex: 1;
}
.pay-method-name {
    font-weight: bold;
    color: #333;
    font-size: 16px;
}
.pay-method-desc {
    font-size: 12px;
    color: #999;
    margin-top: 2px;
}
.pay-method-radio {
    width: 20px;
    height: 20px;
}
.pay-password-section {
    margin-top: 25px;
}
.pay-password-label {
    display: block;
    margin-bottom: 15px;
    font-weight: bold;
    color: #333;
}
.pay-password-input {
    display: flex;
    justify-content: center;
    gap: 10px;
}
.pay-password-box {
    width: 50px;
    height: 55px;
    border: 2px solid #ddd;
    border-radius: 8px;
    text-align: center;
    font-size: 28px;
    font-weight: bold;
    color: #333;
    outline: none;
    transition: border-color 0.2s;
}
.pay-password-box:focus {
    border-color: #ff6b35;
}
.pay-password-box.error {
    border-color: #ff4d4f;
    background: #fff1f0;
}
.pay-btn {
    width: 100%;
    padding: 16px;
    background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%);
    color: #fff;
    font-size: 18px;
    font-weight: bold;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    margin-top: 30px;
    transition: opacity 0.2s;
}
.pay-btn:hover {
    opacity: 0.95;
}
.pay-btn:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}
.pay-tip {
    text-align: center;
    color: #999;
    font-size: 14px;
    margin-top: 15px;
}
.modal-overlay {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.5);
    z-index: 9999;
}
.modal-overlay.show {
    display: block;
}
.modal-content {
    background: #fff;
    border-radius: 12px;
    width: 90%;
    max-width: 450px;
    overflow: hidden;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    animation: modalIn 0.3s ease;
}
@keyframes modalIn {
    from { opacity: 0; transform: translate(-50%, -50%) scale(0.9); }
    to { opacity: 1; transform: translate(-50%, -50%) scale(1); }
}
.modal-header {
    background: linear-gradient(135deg, #52c41a 0%, #389e0d 100%);
    color: #fff;
    padding: 20px;
    text-align: center;
}
.modal-header i {
    font-size: 48px;
    margin-bottom: 10px;
}
.modal-header h4 {
    margin: 0;
    font-size: 20px;
}
.modal-body {
    padding: 25px;
}
.modal-section {
    margin-bottom: 20px;
}
.modal-section-title {
    font-weight: bold;
    color: #333;
    margin-bottom: 10px;
    font-size: 16px;
}
.modal-item {
    display: flex;
    justify-content: space-between;
    padding: 8px 0;
    border-bottom: 1px solid #f0f0f0;
}
.modal-item:last-child {
    border-bottom: none;
}
.modal-item-label {
    color: #666;
}
.modal-item-value {
    color: #333;
    font-weight: 500;
}
.modal-footer {
    padding: 0 25px 25px;
}
.modal-close-btn {
    width: 100%;
    padding: 14px;
    background: #52c41a;
    color: #fff;
    border: none;
    border-radius: 8px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
}
.order-summary {
    background: #f9f9f9;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 15px;
}
.order-summary-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 8px;
}
.order-summary-row:last-child {
    margin-bottom: 0;
    font-weight: bold;
    color: #ff6b35;
    font-size: 16px;
}
</style>

<div class="pay-container">
    <div class="pay-header">
        <h3><i class="fa fa-credit-card"></i> 确认支付</h3>
    </div>

    <div class="pay-card">
        <div class="order-summary">
            <div class="order-summary-row">
                <span>订单号</span>
                <span>${order.orderNo}</span>
            </div>
            <div class="order-summary-row">
                <span>支付金额</span>
                <span>¥<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></span>
            </div>
        </div>

        <div class="modal-section" style="margin-top:20px;">
            <div class="modal-section-title"><i class="fa fa-shopping-cart"></i> 商品信息</div>
            <div style="max-height:200px; overflow-y:auto;">
                <c:forEach items="${order.orderItems}" var="item">
                    <div class="modal-item">
                        <div style="flex:1;">${item.productName}</div>
                        <div style="text-align:right;">
                            <span>¥<fmt:formatNumber value="${item.productPrice}" pattern="#,##0.00"/></span> x ${item.quantity}
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div class="modal-section">
            <div class="modal-section-title"><i class="fa fa-map-marker"></i> 收货地址</div>
            <div class="modal-item">
                <span class="modal-item-label">收货人</span>
                <span class="modal-item-value">${order.receiverName}</span>
            </div>
            <div class="modal-item">
                <span class="modal-item-label">联系电话</span>
                <span class="modal-item-value">${order.receiverPhone}</span>
            </div>
            <div class="modal-item">
                <span class="modal-item-label">详细地址</span>
                <span class="modal-item-value">${order.receiverAddress}</span>
            </div>
        </div>
    </div>

    <div class="pay-card">
        <h4 style="margin-bottom:20px; color:#333;"><i class="fa fa-credit-card"></i> 选择支付方式</h4>
        
        <div class="pay-method" onclick="selectPayMethod('wechat')">
            <div class="pay-method-icon wechat-icon"><i class="fa fa-weixin"></i></div>
            <div class="pay-method-info">
                <div class="pay-method-name">微信支付</div>
                <div class="pay-method-desc">推荐使用，安全快捷</div>
            </div>
            <input type="radio" name="payMethod" value="wechat" class="pay-method-radio" checked>
        </div>

        <div class="pay-method" onclick="selectPayMethod('alipay')">
            <div class="pay-method-icon alipay-icon"><i class="fa fa-credit-card-alt"></i></div>
            <div class="pay-method-info">
                <div class="pay-method-name">支付宝支付</div>
                <div class="pay-method-desc">支持花呗、余额宝</div>
            </div>
            <input type="radio" name="payMethod" value="alipay" class="pay-method-radio">
        </div>
    </div>

    <div class="pay-card">
        <h4 style="margin-bottom:20px; color:#333;"><i class="fa fa-lock"></i> 支付密码</h4>
        <p class="pay-tip">请输入支付密码（默认密码：123456）</p>
        
        <div class="pay-password-section">
            <div class="pay-password-input">
                <input type="password" class="pay-password-box" maxlength="1" oninput="nextInput(this, 1)">
                <input type="password" class="pay-password-box" maxlength="1" oninput="nextInput(this, 2)">
                <input type="password" class="pay-password-box" maxlength="1" oninput="nextInput(this, 3)">
                <input type="password" class="pay-password-box" maxlength="1" oninput="nextInput(this, 4)">
                <input type="password" class="pay-password-box" maxlength="1" oninput="nextInput(this, 5)">
                <input type="password" class="pay-password-box" maxlength="1" oninput="nextInput(this, 6)">
            </div>
        </div>

        <button class="pay-btn" onclick="submitPayment()">确认支付</button>
    </div>
</div>

<div class="modal-overlay" id="successModal">
    <div class="modal-content">
        <div class="modal-header">
            <i class="fa fa-check-circle"></i>
            <h4>支付成功</h4>
        </div>
        <div class="modal-body">
            <div class="modal-section">
                <div class="modal-section-title"><i class="fa fa-shopping-cart"></i> 购买商品</div>
                <div style="max-height:200px; overflow-y:auto;">
                    <c:forEach items="${order.orderItems}" var="item">
                        <div class="modal-item">
                            <div style="flex:1;">${item.productName}
                                <c:if test="${not empty item.spec}">
                                    <span style="color:#999; font-size:12px;">(${item.spec})</span>
                                </c:if>
                            </div>
                            <div style="text-align:right;">
                                <span>¥<fmt:formatNumber value="${item.productPrice}" pattern="#,##0.00"/></span> x ${item.quantity}
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <div class="modal-section">
                <div class="modal-section-title"><i class="fa fa-map-marker"></i> 收货地址</div>
                <div class="modal-item">
                    <span class="modal-item-label">收货人</span>
                    <span class="modal-item-value">${order.receiverName}</span>
                </div>
                <div class="modal-item">
                    <span class="modal-item-label">联系电话</span>
                    <span class="modal-item-value">${order.receiverPhone}</span>
                </div>
                <div class="modal-item">
                    <span class="modal-item-label">详细地址</span>
                    <span class="modal-item-value">${order.receiverAddress}</span>
                </div>
            </div>

            <div class="order-summary" style="background:#f6ffed; border:1px solid #b7eb8f;">
                <div class="order-summary-row">
                    <span>订单号</span>
                    <span>${order.orderNo}</span>
                </div>
                <div class="order-summary-row">
                    <span>支付金额</span>
                    <span>¥<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></span>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button class="modal-close-btn" onclick="closeModal()">查看订单</button>
        </div>
    </div>
</div>

<script>
var selectedPayMethod = 'wechat';

function selectPayMethod(method) {
    selectedPayMethod = method;
    $('.pay-method').removeClass('active');
    $('input[name="payMethod"][value="' + method + '"]').closest('.pay-method').addClass('active');
    $('input[name="payMethod"][value="' + method + '"]').prop('checked', true);
}

function nextInput(input, index) {
    if (input.value.length === 1) {
        if (index < 6) {
            $('.pay-password-box').eq(index).focus();
        } else {
            input.blur();
            submitPayment();
        }
    }
}

function submitPayment() {
    var password = '';
    $('.pay-password-box').each(function() {
        password += $(this).val();
    });

    if (password.length < 6) {
        alert('请输入完整的6位支付密码');
        return;
    }

    if (password !== '123456') {
        alert('支付密码错误，请输入默认密码：123456');
        $('.pay-password-box').addClass('error');
        setTimeout(function() {
            $('.pay-password-box').removeClass('error');
            $('.pay-password-box').val('');
            $('.pay-password-box').eq(0).focus();
        }, 500);
        return;
    }

    $.post('${pageContext.request.contextPath}/fore/order/pay', {
        orderId: ${order.id}
    }, function(res) {
        if (res.code === 200) {
            $('#successModal').addClass('show');
        } else {
            alert(res.msg);
        }
    }, 'json');
}

function closeModal() {
    window.location.href = '${pageContext.request.contextPath}/fore/order/list';
}

$('.pay-password-box').eq(0).focus();
</script>

<jsp:include page="footer.jsp"/>