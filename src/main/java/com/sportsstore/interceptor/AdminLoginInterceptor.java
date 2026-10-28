package com.sportsstore.interceptor;

import com.sportsstore.pojo.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 后台管理员登录拦截器
 */
public class AdminLoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                             Object handler) throws Exception {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("admin");

        if (admin == null) {
            // 未登录管理员, 跳转到后台登录页
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return false;
        }

        return true;
    }
}
