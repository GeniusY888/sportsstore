package com.sportsstore.controller.admin;

import com.github.pagehelper.PageInfo;
import com.sportsstore.dto.Result;
import com.sportsstore.pojo.Order;
import com.sportsstore.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

/**
 * 后台订单管理控制器
 */
@Controller("adminOrderController")
@RequestMapping("/admin/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    /**
     * 订单列表页
     */
    @GetMapping("/list")
    public String list(@RequestParam(required = false) Integer status,
                       @RequestParam(required = false) String orderNo,
                       @RequestParam(defaultValue = "1") int pageNum,
                       @RequestParam(defaultValue = "10") int pageSize,
                       Model model) {
        PageInfo<Order> pageInfo = orderService.listAll(status, orderNo, pageNum, pageSize);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("status", status);
        model.addAttribute("orderNo", orderNo);
        return "admin/orderList";
    }

    /**
     * 订单详情
     */
    @GetMapping("/detail")
    public String detail(@RequestParam Integer id, Model model) {
        Order order = orderService.findById(id);
        if (order == null) {
            return "error/404";
        }
        model.addAttribute("order", order);
        return "admin/orderDetail";
    }

    /**
     * 发货
     */
    @PostMapping("/ship")
    @ResponseBody
    public Result<?> ship(@RequestParam Integer id) {
        return orderService.ship(id);
    }

    /**
     * 完成订单
     */
    @PostMapping("/complete")
    @ResponseBody
    public Result<?> complete(@RequestParam Integer id) {
        return orderService.complete(id);
    }
}
