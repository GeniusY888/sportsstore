package com.sportsstore.service;

import com.sportsstore.dto.Result;
import com.sportsstore.pojo.User;

/**
 * 用户服务接口
 */
public interface UserService {

    /** 用户注册 */
    Result<?> register(String username, String password, String phone);

    /** 用户登录 */
    Result<User> login(String username, String password);

    /** 根据ID查询 */
    User findById(Integer id);

    /** 更新个人信息 */
    Result<?> updateInfo(User user);

    /** 修改密码 */
    Result<?> updatePassword(Integer userId, String oldPassword, String newPassword);
}
