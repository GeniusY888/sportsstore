package com.sportsstore.service.impl;

import com.sportsstore.dto.Result;
import com.sportsstore.mapper.UserMapper;
import com.sportsstore.pojo.User;
import com.sportsstore.service.UserService;
import com.sportsstore.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 用户服务实现
 */
@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public Result<?> register(String username, String password, String phone) {
        // 参数校验
        if (username == null || username.trim().isEmpty()) {
            return Result.error("用户名不能为空");
        }
        if (password == null || password.trim().isEmpty()) {
            return Result.error("密码不能为空");
        }
        if (password.length() < 6) {
            return Result.error("密码长度不能少于6位");
        }

        // 检查用户名是否已存在
        if (userMapper.countByUsername(username) > 0) {
            return Result.error("该用户名已被注册");
        }

        // 创建用户
        User user = new User();
        user.setUsername(username.trim());
        user.setPassword(MD5Util.encode(password));
        user.setPhone(phone);

        int rows = userMapper.insert(user);
        if (rows > 0) {
            return Result.success("注册成功");
        }
        return Result.error("注册失败，请稍后重试");
    }

    @Override
    public Result<User> login(String username, String password) {
        if (username == null || username.trim().isEmpty()) {
            return Result.error("用户名不能为空");
        }
        if (password == null || password.trim().isEmpty()) {
            return Result.error("密码不能为空");
        }

        User user = userMapper.findByUsername(username.trim());
        if (user == null) {
            return Result.error("用户名或密码错误");
        }

        // 检查账号是否启用
        if (user.getStatus() == 0) {
            return Result.error("该账号已被禁用，请联系管理员");
        }

        // 校验密码
        if (!MD5Util.encode(password).equals(user.getPassword())) {
            return Result.error("用户名或密码错误");
        }

        // 不返回密码
        user.setPassword(null);
        return Result.success("登录成功", user);
    }

    @Override
    public User findById(Integer id) {
        return userMapper.findById(id);
    }

    @Override
    public Result<?> updateInfo(User user) {
        if (user == null || user.getId() == null) {
            return Result.error("参数错误");
        }
        int rows = userMapper.update(user);
        if (rows > 0) {
            return Result.success("修改成功");
        }
        return Result.error("修改失败");
    }

    @Override
    public Result<?> updatePassword(Integer userId, String oldPassword, String newPassword) {
        if (newPassword == null || newPassword.length() < 6) {
            return Result.error("新密码长度不能少于6位");
        }

        User user = userMapper.findById(userId);
        if (user == null) {
            return Result.error("用户不存在");
        }

        if (!MD5Util.encode(oldPassword).equals(user.getPassword())) {
            return Result.error("原密码错误");
        }

        int rows = userMapper.updatePassword(userId, MD5Util.encode(newPassword));
        if (rows > 0) {
            return Result.success("密码修改成功");
        }
        return Result.error("密码修改失败");
    }
}
