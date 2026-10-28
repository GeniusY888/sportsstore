<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
</div><!-- /主内容区 -->

<script>
// 侧边栏菜单高亮
var path = window.location.pathname;
$('.nav-pills li').removeClass('active');
if (path.indexOf('/dashboard') > -1) $('#menuDashboard').addClass('active');
else if (path.indexOf('/category') > -1) $('#menuCategory').addClass('active');
else if (path.indexOf('/product') > -1) $('#menuProduct').addClass('active');
else if (path.indexOf('/user') > -1) $('#menuUser').addClass('active');
else if (path.indexOf('/order') > -1) $('#menuOrder').addClass('active');
</script>
</body>
</html>
