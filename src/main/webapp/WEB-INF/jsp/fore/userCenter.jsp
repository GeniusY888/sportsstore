<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp" />

<div class="container" style="margin-top:30px;">
    <div class="row">
        <div class="col-md-3">
            <div class="panel panel-default">
                <div class="panel-heading"><strong>个人中心</strong></div>
                <div class="list-group" style="margin-bottom:0;">
                    <a href="#infoTab" class="list-group-item active" data-toggle="tab">个人信息</a>
                    <a href="#passwordTab" class="list-group-item" data-toggle="tab">修改密码</a>
                </div>
            </div>
        </div>

        <div class="col-md-9">
            <div class="tab-content">
                <!-- 个人信息 -->
                <div class="tab-pane fade in active" id="infoTab">
                    <div class="panel panel-default">
                        <div class="panel-heading"><strong>个人信息</strong></div>
                        <div class="panel-body">
                            <form id="infoForm" class="form-horizontal">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">用户名</label>
                                    <div class="col-sm-6">
                                        <p class="form-control-static">${sessionScope.user.username}</p>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">手机号</label>
                                    <div class="col-sm-6">
                                        <input type="text" name="phone" class="form-control"
                                               value="${sessionScope.user.phone}">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">邮箱</label>
                                    <div class="col-sm-6">
                                        <input type="email" name="email" class="form-control"
                                               value="${sessionScope.user.email}">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-6 col-sm-offset-2">
                                        <button type="submit" class="btn btn-warning"
                                                style="background:#ff6b35; border-color:#ff6b35;">保存修改</button>
                                    </div>
                                </div>
                            </form>
                            <div id="infoMsg" style="margin-left:180px; color:red;"></div>
                        </div>
                    </div>
                </div>

                <!-- 修改密码 -->
                <div class="tab-pane fade" id="passwordTab">
                    <div class="panel panel-default">
                        <div class="panel-heading"><strong>修改密码</strong></div>
                        <div class="panel-body">
                            <form id="passwordForm" class="form-horizontal">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">原密码</label>
                                    <div class="col-sm-6">
                                        <input type="password" name="oldPassword" class="form-control" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">新密码</label>
                                    <div class="col-sm-6">
                                        <input type="password" name="newPassword" class="form-control" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-6 col-sm-offset-2">
                                        <button type="submit" class="btn btn-warning"
                                                style="background:#ff6b35; border-color:#ff6b35;">修改密码</button>
                                    </div>
                                </div>
                            </form>
                            <div id="pwdMsg" style="margin-left:180px; color:red;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
$('#infoForm').submit(function(e) {
    e.preventDefault();
    $.post('${pageContext.request.contextPath}/fore/user/updateInfo', $(this).serialize(), function(res) {
        if (res.code === 200) {
            $('#infoMsg').css('color', 'green').text(res.msg);
        } else {
            $('#infoMsg').css('color', 'red').text(res.msg);
        }
    }, 'json');
});

$('#passwordForm').submit(function(e) {
    e.preventDefault();
    $.post('${pageContext.request.contextPath}/fore/user/updatePassword', $(this).serialize(), function(res) {
        if (res.code === 200) {
            $('#pwdMsg').css('color', 'green').text(res.msg);
            $('#passwordForm')[0].reset();
        } else {
            $('#pwdMsg').css('color', 'red').text(res.msg);
        }
    }, 'json');
});
</script>

<jsp:include page="footer.jsp"/>
