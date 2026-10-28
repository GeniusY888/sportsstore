package com.sportsstore.controller.admin;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sportsstore.dto.Result;
import com.sportsstore.mapper.UserMapper;
import com.sportsstore.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 后台用户管理控制器
 */
@Controller("adminUserController")
@RequestMapping("/admin/user")
public class UserController {

    @Autowired
    private UserMapper userMapper;

    /**
     * 用户列表页
     */
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int pageNum,
                       @RequestParam(defaultValue = "10") int pageSize,
                       Model model) {
        PageHelper.startPage(pageNum, pageSize);
        List<User> list = userMapper.findAll();
        model.addAttribute("pageInfo", new PageInfo<>(list));
        return "admin/userList";
    }

    /**
     * 启用/禁用用户
     */
    @PostMapping("/updateStatus")
    @ResponseBody
    public Result<?> updateStatus(@RequestParam Integer id, @RequestParam Integer status) {
        // 不允许禁用管理员自己
        User user = userMapper.findById(id);
        if ("admin".equals(user.getUsername())) {
            return Result.error("不能禁用管理员账号");
        }
        int rows = userMapper.updateStatus(id, status);
        if (rows > 0) {
            String msg = status == 1 ? "用户已启用" : "用户已禁用";
            return Result.success(msg);
        }
        return Result.error("操作失败");
    }
}
