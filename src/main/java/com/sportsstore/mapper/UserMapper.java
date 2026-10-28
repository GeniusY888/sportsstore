package com.sportsstore.mapper;

import com.sportsstore.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 用户Mapper接口
 */
public interface UserMapper {

    /** 根据用户名查询用户 */
    User findByUsername(String username);

    /** 根据ID查询用户 */
    User findById(Integer id);

    /** 用户注册 */
    int insert(User user);

    /** 更新用户信息 */
    int update(User user);

    /** 更新用户密码 */
    int updatePassword(@Param("id") Integer id, @Param("password") String password);

    /** 分页查询用户列表 (管理员) */
    List<User> findAll();

    /** 更新用户状态 (启用/禁用) */
    int updateStatus(@Param("id") Integer id, @Param("status") Integer status);

    /** 检查用户名是否已存在 */
    int countByUsername(String username);
}
