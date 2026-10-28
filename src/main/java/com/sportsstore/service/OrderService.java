package com.sportsstore.service;

import com.github.pagehelper.PageInfo;
import com.sportsstore.dto.Result;
import com.sportsstore.pojo.Order;

/**
 * 订单服务接口
 */
public interface OrderService {

    /** 用户下单(购物车结算, 含扣库存事务) */
    Result<Order> createOrder(Integer userId, String receiverName, String receiverPhone,
                              String receiverAddress, String remark);

    /** 查询订单详情 */
    Order findById(Integer id);

    /** 用户订单分页 */
    PageInfo<Order> listByUser(int userId, int pageNum, int pageSize);

    /** 取消订单(返还库存) */
    Result<?> cancel(Integer orderId, Integer userId);

    /** 确认收货 */
    Result<?> confirmReceived(Integer orderId, Integer userId);

    /** 支付订单 */
    Result<?> pay(Integer orderId, Integer userId);

    // ==================== 管理员 ====================

    /** 管理员: 全站订单分页 */
    PageInfo<Order> listAll(Integer status, String orderNo, int pageNum, int pageSize);

    /** 管理员: 发货 */
    Result<?> ship(Integer orderId);

    /** 管理员: 完成订单 */
    Result<?> complete(Integer orderId);
}
