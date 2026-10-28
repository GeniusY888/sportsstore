package com.sportsstore.service;

import com.sportsstore.dto.Result;
import com.sportsstore.pojo.Cart;

import java.math.BigDecimal;
import java.util.List;

/**
 * 购物车服务接口
 */
public interface CartService {

    /** 查询用户购物车 */
    List<Cart> findByUserId(Integer userId);

    /** 添加商品到购物车 */
    Result<?> add(Integer userId, Integer productId, String spec, Integer quantity);

    /** 更新购物车商品数量 */
    Result<?> updateQuantity(Integer id, Integer quantity);

    /** 删除购物车单项 */
    Result<?> delete(Integer id);

    /** 清空用户购物车 */
    Result<?> clear(Integer userId);

    /** 计算购物车总价 */
    BigDecimal calcTotal(Integer userId);

    /** 统计购物车数量 */
    int countByUserId(Integer userId);
}
