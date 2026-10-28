package com.sportsstore.controller.fore;

import com.github.pagehelper.PageInfo;
import com.sportsstore.dto.Result;
import com.sportsstore.pojo.Order;
import com.sportsstore.pojo.User;
import com.sportsstore.service.CartService;
import com.sportsstore.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

/**
 * 前台订单控制器
 */
@Controller("foreOrderController")
@RequestMapping("/fore/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private CartService cartService;

    /**
     * 结算页面
     */
    @GetMapping("/checkout")
    public String checkout(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        model.addAttribute("cartList", cartService.findByUserId(user.getId()));
        model.addAttribute("total", cartService.calcTotal(user.getId()));
        return "fore/checkout";
    }

    /**
     * 下单
     */
    @PostMapping("/create")
    @ResponseBody
    public Result<Order> create(@RequestParam String receiverName,
                                @RequestParam String receiverPhone,
                                @RequestParam String receiverAddress,
                                @RequestParam(required = false) String remark,
                                HttpSession session) {
        User user = (User) session.getAttribute("user");
        return orderService.createOrder(user.getId(), receiverName, receiverPhone,
                receiverAddress, remark);
    }

    /**
     * 支付页面
     */
    @GetMapping("/payPage")
    public String payPage(@RequestParam Integer id, Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        Order order = orderService.findById(id);
        if (order == null || !order.getUserId().equals(user.getId())) {
            return "error/404";
        }
        model.addAttribute("order", order);
        return "fore/pay";
    }

    /**
     * 支付
     */
    @PostMapping("/pay")
    @ResponseBody
    public Result<?> pay(@RequestParam Integer orderId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        return orderService.pay(orderId, user.getId());
    }

    /**
     * 取消订单
     */
    @PostMapping("/cancel")
    @ResponseBody
    public Result<?> cancel(@RequestParam Integer orderId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        return orderService.cancel(orderId, user.getId());
    }

    /**
     * 确认收货
     */
    @PostMapping("/confirmReceived")
    @ResponseBody
    public Result<?> confirmReceived(@RequestParam Integer orderId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        return orderService.confirmReceived(orderId, user.getId());
    }

    /**
     * 我的订单列表
     */
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int pageNum,
                       @RequestParam(defaultValue = "10") int pageSize,
                       Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        PageInfo<Order> pageInfo = orderService.listByUser(user.getId(), pageNum, pageSize);
        model.addAttribute("pageInfo", pageInfo);
        return "fore/orderList";
    }

    /**
     * 订单详情
     */
    @GetMapping("/detail")
    public String detail(@RequestParam Integer id, Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        Order order = orderService.findById(id);
        if (order == null || !order.getUserId().equals(user.getId())) {
            return "error/404";
        }
        model.addAttribute("order", order);
        return "fore/orderDetail";
    }
}
