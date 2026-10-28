<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp"/>

<h3><i class="fa fa-list"></i> 商品分类管理</h3>
<hr>

<button class="btn btn-primary" data-toggle="modal" data-target="#addModal">
    <i class="fa fa-plus"></i> 新增分类</button>

<table class="table table-hover" style="margin-top:15px;">
    <thead>
        <tr><th>ID</th><th>分类名称</th><th>排序</th><th>创建时间</th><th>操作</th></tr>
    </thead>
    <tbody>
        <c:forEach items="${pageInfo.list}" var="cat">
            <tr>
                <td>${cat.id}</td>
                <td>${cat.name}</td>
                <td>${cat.sortOrder}</td>
                <td>${cat.createTime}</td>
                <td>
                    <button class="btn btn-xs btn-info" onclick="editCat(${cat.id}, '${cat.name}', ${cat.sortOrder})">
                        编辑</button>
                    <button class="btn btn-xs btn-danger" onclick="deleteCat(${cat.id}, '${cat.name}')">删除</button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<!-- 分页 -->
<c:if test="${pageInfo.pages > 1}">
    <nav class="text-center"><ul class="pagination">
        <li><a href="?pageNum=${pageInfo.prePage}">&laquo;</a></li>
        <c:forEach begin="1" end="${pageInfo.pages}" var="i">
            <li class="${pageInfo.pageNum == i ? 'active' : ''}"><a href="?pageNum=${i}">${i}</a></li>
        </c:forEach>
        <li><a href="?pageNum=${pageInfo.nextPage}">&raquo;</a></li>
    </ul></nav>
</c:if>

<!-- 新增模态框 -->
<div class="modal fade" id="addModal">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4>新增分类</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label>分类名称</label>
                    <input type="text" id="addName" class="form-control" required>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" onclick="addCategory()">确认</button>
                <button class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<!-- 编辑模态框 -->
<div class="modal fade" id="editModal">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4>编辑分类</h4>
            </div>
            <div class="modal-body">
                <input type="hidden" id="editId">
                <div class="form-group">
                    <label>分类名称</label>
                    <input type="text" id="editName" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>排序序号</label>
                    <input type="number" id="editSort" class="form-control">
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" onclick="updateCategory()">保存</button>
                <button class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<script>
function addCategory() {
    var name = $('#addName').val().trim();
    if (!name) { alert('请输入分类名称'); return; }
    $.post('${pageContext.request.contextPath}/admin/category/add', { name: name }, function(res) {
        alert(res.msg);
        if (res.code === 200) location.reload();
    }, 'json');
}

function editCat(id, name, sort) {
    $('#editId').val(id);
    $('#editName').val(name);
    $('#editSort').val(sort);
    $('#editModal').modal('show');
}

function updateCategory() {
    $.post('${pageContext.request.contextPath}/admin/category/update', {
        id: $('#editId').val(),
        name: $('#editName').val(),
        sortOrder: $('#editSort').val()
    }, function(res) {
        alert(res.msg);
        if (res.code === 200) location.reload();
    }, 'json');
}

function deleteCat(id, name) {
    if (!confirm('确定删除分类 "' + name + '" ？\n如果分类下有商品则无法删除。')) return;
    $.post('${pageContext.request.contextPath}/admin/category/delete', { id: id }, function(res) {
        alert(res.msg);
        if (res.code === 200) location.reload();
    }, 'json');
}
</script>

<jsp:include page="footer.jsp"/>
