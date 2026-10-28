package com.sportsstore.controller.fore;

import com.sportsstore.dto.Result;
import com.sportsstore.pojo.User;
import com.sportsstore.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

/**
 * 前台用户控制器
 */
@Controller("foreUserController")
@RequestMapping("/fore/user")
public class UserController {

    @Autowired
    private UserService userService;

    // ==================== 页面跳转 ====================

    @GetMapping("/loginPage")
    public String loginPage() {
        return "fore/login";
    }

    @GetMapping("/registerPage")
    public String registerPage() {
        return "fore/register";
    }

    @GetMapping("/center")
    public String center(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        model.addAttribute("user", userService.findById(user.getId()));
        return "fore/userCenter";
    }

    // ==================== 业务接口 ====================

    @PostMapping("/register")
    @ResponseBody
    public Result<?> register(@RequestParam String username,
                              @RequestParam String password,
                              @RequestParam(required = false) String phone) {
        return userService.register(username, password, phone);
    }

    @PostMapping("/login")
    @ResponseBody
    public Result<User> login(@RequestParam String username,
                              @RequestParam String password,
                              HttpSession session) {
        Result<User> result = userService.login(username, password);
        if (result.isSuccess()) {
            session.setAttribute("user", result.getData());
        }
        return result;
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("user");
        session.invalidate();
        return "redirect:/fore/home";
    }

    @PostMapping("/updateInfo")
    @ResponseBody
    public Result<?> updateInfo(User user, HttpSession session) {
        User sessionUser = (User) session.getAttribute("user");
        user.setId(sessionUser.getId());
        Result<?> result = userService.updateInfo(user);
        if (result.isSuccess()) {
            // 更新 session
            sessionUser.setPhone(user.getPhone());
            sessionUser.setEmail(user.getEmail());
            session.setAttribute("user", sessionUser);
        }
        return result;
    }

    @PostMapping("/updatePassword")
    @ResponseBody
    public Result<?> updatePassword(@RequestParam String oldPassword,
                                    @RequestParam String newPassword,
                                    HttpSession session) {
        User user = (User) session.getAttribute("user");
        return userService.updatePassword(user.getId(), oldPassword, newPassword);
    }

    @PostMapping("/checkLogin")
    @ResponseBody
    public Result<?> checkLogin(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            return Result.success(user);
        }
        return Result.error(401, "未登录");
    }
}
