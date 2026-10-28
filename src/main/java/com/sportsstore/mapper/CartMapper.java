package com.sportsstore.mapper;

import com.sportsstore.pojo.Cart;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 购物车Mapper接口
 */
public interface CartMapper {

    /** 查询用户购物车 */
    List<Cart> findByUserId(Integer userId);

    /** 根据用户ID和商品ID查找购物车项 */
    Cart findByUserAndProduct(@Param("userId") Integer userId,
                              @Param("productId") Integer productId);

    /** 根据用户ID、商品ID和规格查找购物车项 */
    Cart findByUserAndProductAndSpec(@Param("userId") Integer userId,
                                     @Param("productId") Integer productId,
                                     @Param("spec") String spec);

    /** 添加商品到购物车 */
    int insert(Cart cart);

    /** 更新购物车商品数量 */
    int updateQuantity(@Param("id") Integer id, @Param("quantity") Integer quantity);

    /** 删除购物车单项 */
    int delete(Integer id);

    /** 清空用户购物车 */
    int deleteByUserId(Integer userId);

    /** 统计用户购物车商品种类数 */
    int countByUserId(Integer userId);
}
