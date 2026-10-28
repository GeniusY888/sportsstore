package com.sportsstore.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sportsstore.dto.Result;
import com.sportsstore.mapper.CartMapper;
import com.sportsstore.mapper.OrderMapper;
import com.sportsstore.mapper.ProductMapper;
import com.sportsstore.pojo.*;
import com.sportsstore.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * 订单服务实现
 */
@Service("orderService")
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private CartMapper cartMapper;

    @Autowired
    private ProductMapper productMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Result<Order> createOrder(Integer userId, String receiverName, String receiverPhone,
                                     String receiverAddress, String remark) {
        // 查询用户购物车
        List<Cart> cartList = cartMapper.findByUserId(userId);
        if (cartList == null || cartList.isEmpty()) {
            return Result.error("购物车为空，无法下单");
        }

        // 生成订单项 & 计算总价 & 校验库存
        List<OrderItem> orderItems = new ArrayList<>();
        BigDecimal totalAmount = BigDecimal.ZERO;

        for (Cart cart : cartList) {
            Product product = cart.getProduct();
            if (product == null || product.getStatus() == 0) {
                return Result.error("商品 [" + cart.getProductId() + "] 已下架，请从购物车移除后再下单");
            }

            // 校验库存
            if (product.getStock() < cart.getQuantity()) {
                return Result.error("商品 [" + product.getName() + "] 库存不足，当前库存: " + product.getStock());
            }

            // 扣减库存
            productMapper.updateStock(product.getId(), -cart.getQuantity());

            // 创建订单明细
            OrderItem item = new OrderItem();
            item.setProductId(product.getId());
            item.setProductName(product.getName());
            item.setProductImage(product.getImage());
            item.setProductPrice(product.getPrice());
            item.setSpec(cart.getSpec());
            item.setQuantity(cart.getQuantity());
            item.setSubtotal(product.getPrice().multiply(BigDecimal.valueOf(cart.getQuantity())));
            orderItems.add(item);

            totalAmount = totalAmount.add(item.getSubtotal());
        }

        // 创建订单
        Order order = new Order();
        order.setOrderNo(generateOrderNo());
        order.setUserId(userId);
        order.setTotalAmount(totalAmount);
        order.setStatus(Order.STATUS_UNPAID);
        order.setReceiverName(receiverName);
        order.setReceiverPhone(receiverPhone);
        order.setReceiverAddress(receiverAddress);
        order.setRemark(remark);

        orderMapper.insertOrder(order);

        // 批量插入订单明细
        for (OrderItem item : orderItems) {
            item.setOrderId(order.getId());
        }
        orderMapper.insertOrderItems(orderItems);

        // 清空购物车
        cartMapper.deleteByUserId(userId);

        return Result.success("下单成功", order);
    }

    @Override
    public Order findById(Integer id) {
        return orderMapper.findById(id);
    }

    @Override
    public PageInfo<Order> listByUser(int userId, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Order> list = orderMapper.findByUserId(userId);
        return new PageInfo<>(list);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Result<?> cancel(Integer orderId, Integer userId) {
        Order order = orderMapper.findById(orderId);
        if (order == null) {
            return Result.error("订单不存在");
        }
        if (!order.getUserId().equals(userId)) {
            return Result.error("无权操作此订单");
        }
        if (order.getStatus() != Order.STATUS_UNPAID) {
            return Result.error("只能取消未付款的订单");
        }

        // 取消订单
        orderMapper.cancelOrder(orderId, new Date());

        // 返还库存
        List<OrderItem> items = orderMapper.findItemsByOrderId(orderId);
        for (OrderItem item : items) {
            productMapper.updateStock(item.getProductId(), item.getQuantity());
        }

        return Result.success("订单已取消");
    }

    @Override
    public Result<?> confirmReceived(Integer orderId, Integer userId) {
        Order order = orderMapper.findById(orderId);
        if (order == null) {
            return Result.error("订单不存在");
        }
        if (!order.getUserId().equals(userId)) {
            return Result.error("无权操作此订单");
        }
        if (order.getStatus() != Order.STATUS_SHIPPED) {
            return Result.error("只能确认已发货的订单");
        }

        orderMapper.completeOrder(orderId, new Date());
        return Result.success("已确认收货");
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Result<?> pay(Integer orderId, Integer userId) {
        Order order = orderMapper.findById(orderId);
        if (order == null) {
            return Result.error("订单不存在");
        }
        if (!order.getUserId().equals(userId)) {
            return Result.error("无权操作此订单");
        }
        if (order.getStatus() != Order.STATUS_UNPAID) {
            return Result.error("订单状态异常");
        }

        orderMapper.payOrder(orderId, new Date());

        List<OrderItem> items = orderMapper.findItemsByOrderId(orderId);
        for (OrderItem item : items) {
            productMapper.updateSalesVolume(item.getProductId(), item.getQuantity());
        }

        return Result.success("支付成功");
    }

    // ==================== 管理员 ====================

    @Override
    public PageInfo<Order> listAll(Integer status, String orderNo, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Order> list = orderMapper.findAll(status, orderNo);
        return new PageInfo<>(list);
    }

    @Override
    public Result<?> ship(Integer orderId) {
        Order order = orderMapper.findById(orderId);
        if (order == null) {
            return Result.error("订单不存在");
        }
        if (order.getStatus() != Order.STATUS_PAID) {
            return Result.error("只能发货已付款的订单");
        }

        orderMapper.shipOrder(orderId, new Date());
        return Result.success("发货成功");
    }

    @Override
    public Result<?> complete(Integer orderId) {
        Order order = orderMapper.findById(orderId);
        if (order == null) {
            return Result.error("订单不存在");
        }
        orderMapper.completeOrder(orderId, new Date());
        return Result.success("订单已完成");
    }

    /**
     * 生成订单编号
     */
    private String generateOrderNo() {
        return UUID.randomUUID().toString().replaceAll("-", "").substring(0, 20).toUpperCase();
    }
}
