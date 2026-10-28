<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp"/>
<script src="${pageContext.request.contextPath}/static/js/area-data.js"></script>

<div class="container" style="margin-top:30px;">
    <h3><i class="fa fa-credit-card"></i> 确认订单</h3>
    <hr>

    <c:if test="${not empty cartList}">
        <div class="row">
            <div class="col-md-8">
                <div class="panel panel-default">
                    <div class="panel-heading"><strong>订单商品</strong></div>
                    <table class="table">
                        <thead>
                            <tr><th>商品</th><th width="100">单价</th><th width="80">数量</th><th width="100">小计</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${cartList}" var="cart">
                                <tr>
                                    <td>${cart.product.name}</td>
                                    <td>¥<fmt:formatNumber value="${cart.product.price}" pattern="#,##0.00"/></td>
                                    <td>${cart.quantity}</td>
                                    <td>¥<fmt:formatNumber value="${cart.subtotal}" pattern="#,##0.00"/></td>
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
                        <form id="orderForm">
                            <div class="form-group">
                                <label>收货人</label>
                                <input type="text" name="receiverName" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>联系电话</label>
                                <input type="text" name="receiverPhone" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>所在地区</label>
                                <div class="row" style="margin-bottom:10px;">
                                    <div class="col-xs-4">
                                        <select name="province" id="province" class="form-control" required onchange="loadCities()">
                                            <option value="">请选择省份</option>
                                        </select>
                                    </div>
                                    <div class="col-xs-4">
                                        <select name="city" id="city" class="form-control" required onchange="loadDistricts()">
                                            <option value="">请选择城市</option>
                                        </select>
                                    </div>
                                    <div class="col-xs-4">
                                        <select name="district" id="district" class="form-control" required>
                                            <option value="">请选择区县</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>详细地址</label>
                                <textarea name="detailAddress" class="form-control" rows="2" placeholder="请输入详细地址（如街道、楼栋号等）" required></textarea>
                                <input type="hidden" name="receiverAddress" id="receiverAddress">
                            </div>
                            <div class="form-group">
                                <label>备注</label>
                                <textarea name="remark" class="form-control" rows="2"></textarea>
                            </div>
                        </form>
                    </div>
                    <div class="panel-footer text-right">
                        <span style="font-size:18px;">合计: </span>
                        <span style="font-size:24px; color:#ff6b35; font-weight:bold;">
                            ¥<fmt:formatNumber value="${total}" pattern="#,##0.00"/>
                        </span>
                        <button class="btn btn-lg btn-warning" style="background:#ff6b35; border-color:#ff6b35;
                                margin-left:15px;" onclick="submitOrder()">
                            确认下单
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
    <c:if test="${empty cartList}">
        <div class="text-center" style="padding:80px 0;">
            <h4 style="color:#999;">购物车为空，请先添加商品</h4>
            <a href="${pageContext.request.contextPath}/fore/home" class="btn btn-warning"
               style="background:#ff6b35; margin-top:15px;">去逛逛</a>
        </div>
    </c:if>
</div>

<script>
// 初始化省份选择器
function initProvinces() {
    var provinceSelect = document.getElementById('province');
    provinceSelect.innerHTML = '<option value="">请选择省份</option>';
    for (var i = 0; i < areaData.provinces.length; i++) {
        var province = areaData.provinces[i];
        provinceSelect.innerHTML += '<option value="' + province.code + '">' + province.name + '</option>';
    }
}

// 加载城市
function loadCities() {
    var provinceCode = document.getElementById('province').value;
    var citySelect = document.getElementById('city');
    var districtSelect = document.getElementById('district');

    citySelect.innerHTML = '<option value="">请选择城市</option>';
    districtSelect.innerHTML = '<option value="">请选择区县</option>';

    if (provinceCode && areaData.cities[provinceCode]) {
        var cities = areaData.cities[provinceCode];
        for (var i = 0; i < cities.length; i++) {
            citySelect.innerHTML += '<option value="' + cities[i].code + '">' + cities[i].name + '</option>';
        }
    }
}

// 加载区县
function loadDistricts() {
    var cityCode = document.getElementById('city').value;
    var districtSelect = document.getElementById('district');

    districtSelect.innerHTML = '<option value="">请选择区县</option>';

    if (cityCode && areaData.districts[cityCode]) {
        var districts = areaData.districts[cityCode];
        for (var i = 0; i < districts.length; i++) {
            districtSelect.innerHTML += '<option value="' + districts[i].code + '">' + districts[i].name + '</option>';
        }
    }
}

// 获取选中的地区名称
function getSelectedAreaNames() {
    var provinceSelect = document.getElementById('province');
    var citySelect = document.getElementById('city');
    var districtSelect = document.getElementById('district');

    var provinceName = provinceSelect.options[provinceSelect.selectedIndex] ? provinceSelect.options[provinceSelect.selectedIndex].text : '';
    var cityName = citySelect.options[citySelect.selectedIndex] ? citySelect.options[citySelect.selectedIndex].text : '';
    var districtName = districtSelect.options[districtSelect.selectedIndex] ? districtSelect.options[districtSelect.selectedIndex].text : '';

    return provinceName + cityName + districtName;
}

function submitOrder() {
    var provinceSelect = document.getElementById('province');
    var citySelect = document.getElementById('city');
    var districtSelect = document.getElementById('district');
    var detailAddress = document.querySelector('textarea[name="detailAddress"]').value;

    if (!provinceSelect.value) {
        alert('请选择省份');
        return;
    }
    if (!citySelect.value) {
        alert('请选择城市');
        return;
    }
    if (!districtSelect.value) {
        alert('请选择区县');
        return;
    }
    if (!detailAddress.trim()) {
        alert('请输入详细地址');
        return;
    }

    // 拼接完整地址
    var fullAddress = getSelectedAreaNames() + detailAddress;
    document.getElementById('receiverAddress').value = fullAddress;

    var data = $('#orderForm').serialize();
    $.post('${pageContext.request.contextPath}/fore/order/create', data, function(res) {
        if (res.code === 200) {
            alert('下单成功！订单号: ' + res.data.orderNo);
            window.location.href = '${pageContext.request.contextPath}/fore/order/list';
        } else {
            alert(res.msg);
        }
    }, 'json');
}

// 页面加载时初始化
$(document).ready(function() {
    initProvinces();
});
</script>

<jsp:include page="footer.jsp"/>
