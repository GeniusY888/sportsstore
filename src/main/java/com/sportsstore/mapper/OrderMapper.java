package com.sportsstore.mapper;

import com.sportsstore.pojo.Order;
import com.sportsstore.pojo.OrderItem;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 订单Mapper接口
 */
public interface OrderMapper {

    // ==================== 订单主表 ====================

    /** 创建订单 */
    int insertOrder(Order order);

    /** 更新订单状态 */
    int updateStatus(@Param("id") Integer id, @Param("status") Integer status);

    /** 更新订单为已付款 */
    int payOrder(@Param("id") Integer id, @Param("payTime") Object payTime);

    /** 更新订单为已发货 */
    int shipOrder(@Param("id") Integer id, @Param("shipTime") Object shipTime);

    /** 更新订单为已完成 */
    int completeOrder(@Param("id") Integer id, @Param("completeTime") Object completeTime);

    /** 取消订单 */
    int cancelOrder(@Param("id") Integer id, @Param("cancelTime") Object cancelTime);

    /** 根据ID查询订单 */
    Order findById(Integer id);

    /** 根据订单号查询 */
    Order findByOrderNo(String orderNo);

    /** 查询用户所有订单 */
    List<Order> findByUserId(Integer userId);

    /** 管理员: 查询所有订单(含筛选) */
    List<Order> findAll(@Param("status") Integer status,
                        @Param("orderNo") String orderNo);

    // ==================== 订单明细 ====================

    /** 批量插入订单明细 */
    int insertOrderItems(@Param("items") List<OrderItem> items);

    /** 查询订单明细 */
    List<OrderItem> findItemsByOrderId(Integer orderId);
}
