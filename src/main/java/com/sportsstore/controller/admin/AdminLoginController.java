package com.sportsstore.controller.admin;

import com.sportsstore.dto.Result;
import com.sportsstore.pojo.User;
import com.sportsstore.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

/**
 * 后台管理员登录控制器
 */
@Controller
@RequestMapping("/admin")
public class AdminLoginController {

    @Autowired
    private UserService userService;

    /**
     * 后台登录页面
     */
    @GetMapping("/login")
    public String loginPage() {
        return "admin/login";
    }

    /**
     * 后台登录接口
     */
    @PostMapping("/doLogin")
    @ResponseBody
    public Result<User> doLogin(@RequestParam String username,
                                @RequestParam String password,
                                HttpSession session) {
        Result<User> result = userService.login(username, password);
        if (result.isSuccess()) {
            User user = result.getData();
            // 检查是否为管理员 (username = admin)
            if (!"admin".equals(user.getUsername())) {
                return Result.error(403, "非管理员账号，无权访问后台");
            }
            session.setAttribute("admin", user);
        }
        return result;
    }

    /**
     * 退出登录
     */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("admin");
        session.invalidate();
        return "redirect:/admin/login";
    }

    /**
     * 后台首页/仪表盘
     */
    @GetMapping({"/", "/index", "/dashboard"})
    public String dashboard(Model model) {
        return "admin/dashboard";
    }
}
