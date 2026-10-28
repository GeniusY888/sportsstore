<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp"/>

<h3><i class="fa fa-edit"></i> 编辑商品</h3>
<hr>

<form id="productForm" class="form-horizontal" enctype="multipart/form-data" method="post">
    <input type="hidden" name="id" value="${product.id}">
    <div class="form-group">
        <label class="col-sm-2 control-label">商品名称</label>
        <div class="col-sm-6"><input type="text" name="name" class="form-control" value="${product.name}" required></div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">商品分类</label>
        <div class="col-sm-4">
            <select name="categoryId" class="form-control" required>
                <c:forEach items="${categories}" var="cat">
                    <option value="${cat.id}" ${product.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">商品价格</label>
        <div class="col-sm-4"><input type="number" name="price" step="0.01" class="form-control"
                                     value="${product.price}" required></div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">商品库存</label>
        <div class="col-sm-4"><input type="number" name="stock" class="form-control"
                                     value="${product.stock}" required></div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">商品图片</label>
        <div class="col-sm-4">
            <c:if test="${not empty product.image}">
                <img src="${pageContext.request.contextPath}/${product.image}" width="150" style="margin-bottom:10px; display:block;">
            </c:if>
            <input type="file" name="imageFile" class="form-control">
            <span class="help-block">不选择文件则不更换图片</span>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">是否热门</label>
        <div class="col-sm-4">
            <label class="radio-inline"><input type="radio" name="isHot" value="1" ${product.isHot == 1 ? 'checked' : ''}> 是</label>
            <label class="radio-inline"><input type="radio" name="isHot" value="0" ${product.isHot == 0 ? 'checked' : ''}> 否</label>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">是否新品</label>
        <div class="col-sm-4">
            <label class="radio-inline"><input type="radio" name="isNew" value="1" ${product.isNew == 1 ? 'checked' : ''}> 是</label>
            <label class="radio-inline"><input type="radio" name="isNew" value="0" ${product.isNew == 0 ? 'checked' : ''}> 否</label>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">商品描述</label>
        <div class="col-sm-8">
            <textarea name="description" class="form-control" rows="5">${product.description}</textarea>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-6 col-sm-offset-2">
            <button type="submit" class="btn btn-primary">保存修改</button>
            <a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-default">返回列表</a>
        </div>
    </div>
</form>
<div id="resultMsg" style="margin-left:180px;"></div>

<script>
$(function() {
    $('#productForm').submit(function(e) {
        e.preventDefault();
        var formData = new FormData(this);
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/product/update',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            dataType: 'json',
            success: function(res) {
                if (res.code === 200) {
                    alert('保存成功');
                    window.location.href = '${pageContext.request.contextPath}/admin/product/list';
                } else {
                    $('#resultMsg').css('color', 'red').text(res.msg);
                }
            },
            error: function(xhr) {
                alert('请求失败: ' + xhr.status + ' - 请检查控制台日志');
                $('#resultMsg').css('color', 'red').text('保存失败，服务器错误');
            }
        });
    });
});
</script>

<jsp:include page="footer.jsp"/>
