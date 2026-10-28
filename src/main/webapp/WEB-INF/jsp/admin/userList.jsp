<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp"/>

<h3><i class="fa fa-users"></i> 用户管理</h3>
<hr>

<table class="table table-hover table-striped">
    <thead>
        <tr><th>ID</th><th>用户名</th><th>手机号</th><th>邮箱</th><th>状态</th><th>注册时间</th><th>操作</th></tr>
    </thead>
    <tbody>
        <c:forEach items="${pageInfo.list}" var="u">
            <tr>
                <td>${u.id}</td>
                <td>
                    ${u.username}
                    <c:if test="${u.username == 'admin'}">
                        <span class="label label-danger">管理员</span>
                    </c:if>
                </td>
                <td>${not empty u.phone ? u.phone : '-'}</td>
                <td>${not empty u.email ? u.email : '-'}</td>
                <td>
                    <c:choose>
                        <c:when test="${u.status == 1}"><span class="label label-success">启用</span></c:when>
                        <c:otherwise><span class="label label-default">禁用</span></c:otherwise>
                    </c:choose>
                </td>
                <td><fmt:formatDate value="${u.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                <td>
                    <c:if test="${u.username != 'admin'}">
                        <button class="btn btn-xs ${u.status == 1 ? 'btn-warning' : 'btn-success'}"
                                onclick="toggleUser(${u.id}, ${u.status}, '${u.username}')">
                            ${u.status == 1 ? '禁用' : '启用'}
                        </button>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<c:if test="${pageInfo.pages > 1}">
    <nav class="text-center"><ul class="pagination">
        <li><a href="?pageNum=${pageInfo.prePage}">&laquo;</a></li>
        <c:forEach begin="1" end="${pageInfo.pages}" var="i">
            <li class="${pageInfo.pageNum == i ? 'active' : ''}"><a href="?pageNum=${i}">${i}</a></li>
        </c:forEach>
        <li><a href="?pageNum=${pageInfo.nextPage}">&raquo;</a></li>
    </ul></nav>
</c:if>

<script>
function toggleUser(id, curStatus, name) {
    var newStatus = curStatus == 1 ? 0 : 1;
    var action = newStatus == 1 ? '启用' : '禁用';
    if (!confirm('确定' + action + '用户 "' + name + '" 吗？')) return;
    $.post('${pageContext.request.contextPath}/admin/user/updateStatus',
        { id: id, status: newStatus }, function(res) {
        alert(res.msg);
        if (res.code === 200) location.reload();
    }, 'json');
}
</script>

<jsp:include page="footer.jsp"/>
