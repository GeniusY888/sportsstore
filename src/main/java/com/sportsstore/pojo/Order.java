package com.sportsstore.pojo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 订单实体类
 */
public class Order implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer id;
    private String orderNo;
    private Integer userId;
    private BigDecimal totalAmount;
    private Integer status;          // 0=未付款, 1=已付款, 2=已发货, 3=已完成, 4=已取消
    private String receiverName;
    private String receiverPhone;
    private String receiverAddress;
    private String remark;
    private Date payTime;
    private Date shipTime;
    private Date completeTime;
    private Date cancelTime;
    private Date createTime;

    // ====== 关联属性 ======
    private List<OrderItem> orderItems;
    private User user;

    // ====== 状态常量 ======
    public static final int STATUS_UNPAID    = 0;
    public static final int STATUS_PAID      = 1;
    public static final int STATUS_SHIPPED   = 2;
    public static final int STATUS_COMPLETED = 3;
    public static final int STATUS_CANCELLED = 4;

    public Order() {}

    // ====== Getter & Setter ======
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getOrderNo() { return orderNo; }
    public void setOrderNo(String orderNo) { this.orderNo = orderNo; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }

    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }

    public String getReceiverName() { return receiverName; }
    public void setReceiverName(String receiverName) { this.receiverName = receiverName; }

    public String getReceiverPhone() { return receiverPhone; }
    public void setReceiverPhone(String receiverPhone) { this.receiverPhone = receiverPhone; }

    public String getReceiverAddress() { return receiverAddress; }
    public void setReceiverAddress(String receiverAddress) { this.receiverAddress = receiverAddress; }

    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }

    public Date getPayTime() { return payTime; }
    public void setPayTime(Date payTime) { this.payTime = payTime; }

    public Date getShipTime() { return shipTime; }
    public void setShipTime(Date shipTime) { this.shipTime = shipTime; }

    public Date getCompleteTime() { return completeTime; }
    public void setCompleteTime(Date completeTime) { this.completeTime = completeTime; }

    public Date getCancelTime() { return cancelTime; }
    public void setCancelTime(Date cancelTime) { this.cancelTime = cancelTime; }

    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }

    // 关联属性
    public List<OrderItem> getOrderItems() { return orderItems; }
    public void setOrderItems(List<OrderItem> orderItems) { this.orderItems = orderItems; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    /**
     * 获取状态中文描述
     */
    public String getStatusDesc() {
        switch (status) {
            case STATUS_UNPAID:    return "未付款";
            case STATUS_PAID:      return "已付款";
            case STATUS_SHIPPED:   return "已发货";
            case STATUS_COMPLETED: return "已完成";
            case STATUS_CANCELLED: return "已取消";
            default:               return "未知";
        }
    }
}
