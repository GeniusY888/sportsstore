<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp"/>

<h3><i class="fa fa-cubes"></i> 商品管理</h3>
<hr>

<div class="row" style="margin-bottom:15px;">
    <div class="col-md-8">
        <form class="form-inline" action="${pageContext.request.contextPath}/admin/product/list" method="get">
            <input type="text" name="name" class="form-control" placeholder="商品名称" value="${name}">
            <select name="categoryId" class="form-control">
                <option value="">全部分类</option>
                <c:forEach items="${categories}" var="cat">
                    <option value="${cat.id}" ${categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                </c:forEach>
            </select>
            <select name="status" class="form-control">
                <option value="">全部状态</option>
                <option value="1" ${status == 1 ? 'selected' : ''}>上架</option>
                <option value="0" ${status == 0 ? 'selected' : ''}>下架</option>
            </select>
            <button type="submit" class="btn btn-default"><i class="fa fa-search"></i> 查询</button>
        </form>
    </div>
    <div class="col-md-4 text-right">
        <a href="${pageContext.request.contextPath}/admin/product/addPage" class="btn btn-primary">
            <i class="fa fa-plus"></i> 新增商品</a>
    </div>
</div>

<table class="table table-hover table-striped">
    <thead>
        <tr><th>ID</th><th>图片</th><th>名称</th><th>分类</th><th>价格</th><th>库存</th>
            <th>状态</th><th>操作</th></tr>
    </thead>
    <tbody>
        <c:forEach items="${pageInfo.list}" var="p">
            <tr>
                <td>${p.id}</td>
                <td>
                    <c:if test="${not empty p.image}">
                        <img src="${pageContext.request.contextPath}/${p.image}" width="50" height="50"
                             style="object-fit:cover; border-radius:4px;">
                    </c:if>
                </td>
                <td>${p.name}</td>
                <td>${p.category.name}</td>
                <td>¥<fmt:formatNumber value="${p.price}" pattern="#,##0.00"/></td>
                <td>${p.stock}</td>
                <td>
                    <c:choose>
                        <c:when test="${p.status == 1}"><span class="label label-success">上架</span></c:when>
                        <c:otherwise><span class="label label-default">下架</span></c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/product/editPage?id=${p.id}"
                       class="btn btn-xs btn-info">编辑</a>
                    <button class="btn btn-xs btn-warning" onclick="toggleStatus(${p.id}, ${p.status})">
                        ${p.status == 1 ? '下架' : '上架'}</button>
                    <button class="btn btn-xs btn-danger" onclick="deleteProduct(${p.id}, '${p.name}')">删除</button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<c:if test="${pageInfo.pages > 1}">
    <nav class="text-center"><ul class="pagination">
        <li><a href="?pageNum=${pageInfo.prePage}&name=${name}&categoryId=${categoryId}&status=${status}">&laquo;</a></li>
        <c:forEach begin="1" end="${pageInfo.pages}" var="i">
            <li class="${pageInfo.pageNum == i ? 'active' : ''}">
                <a href="?pageNum=${i}&name=${name}&categoryId=${categoryId}&status=${status}">${i}</a></li>
        </c:forEach>
        <li><a href="?pageNum=${pageInfo.nextPage}&name=${name}&categoryId=${categoryId}&status=${status}">&raquo;</a></li>
    </ul></nav>
</c:if>

<script>
function toggleStatus(id, curStatus) {
    var newStatus = curStatus == 1 ? 0 : 1;
    var action = newStatus == 1 ? '上架' : '下架';
    if (!confirm('确定要' + action + '该商品吗？')) return;
    $.post('${pageContext.request.contextPath}/admin/product/updateStatus',
        { id: id, status: newStatus }, function(res) {
        alert(res.msg);
        if (res.code === 200) location.reload();
    }, 'json');
}

function deleteProduct(id, name) {
    if (!confirm('确定删除商品 "' + name + '" 吗？此操作不可恢复。')) return;
    $.post('${pageContext.request.contextPath}/admin/product/delete', { id: id }, function(res) {
        alert(res.msg);
        if (res.code === 200) location.reload();
    }, 'json');
}
</script>

<jsp:include page="footer.jsp"/>
