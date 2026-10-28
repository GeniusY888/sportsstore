<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- ==================== 页脚 ==================== -->
<footer style="background:#1a1a2e; color:#aaa; padding:30px 0; margin-top:50px;">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <h4 style="color:#ff6b35;"><i class="fa fa-futbol-o"></i> SportsStore</h4>
                <p>专业体育用品线上商城，品质保障，正品低价。</p>
            </div>
            <div class="col-md-4">
                <h5>服务支持</h5>
                <ul class="list-unstyled">
                    <li>7天无理由退换</li>
                    <li>正品保障</li>
                    <li>全国包邮</li>
                </ul>
            </div>
            <div class="col-md-4">
                <h5>联系我们</h5>
                <ul class="list-unstyled">
                    <li><i class="fa fa-phone"></i> 400-888-6666</li>
                    <li><i class="fa fa-envelope"></i> service@sportsstore.com</li>
                </ul>
            </div>
        </div>
        <hr style="border-color:#333;">
        <p class="text-center">© 2024 SportsStore 体育用品商城 | JavaEE 课程设计项目</p>
    </div>
</footer>

<script>
// 更新购物车数量
$(function() {
    $.get('${pageContext.request.contextPath}/fore/cart/count', function(res) {
        if (res.code === 200 && res.data > 0) {
            $('#cartCount').text(res.data).show();
        }
    });
});
</script>
</body>
</html>
