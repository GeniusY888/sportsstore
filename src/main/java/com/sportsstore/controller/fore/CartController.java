package com.sportsstore.controller.fore;

import com.sportsstore.dto.Result;
import com.sportsstore.pojo.Cart;
import com.sportsstore.pojo.User;
import com.sportsstore.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 前台购物车控制器
 */
@Controller
@RequestMapping("/fore/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    /**
     * 购物车页面
     */
    @GetMapping("/list")
    public String list(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        List<Cart> cartList = cartService.findByUserId(user.getId());
        model.addAttribute("cartList", cartList);
        model.addAttribute("total", cartService.calcTotal(user.getId()));
        return "fore/cart";
    }

    /**
     * 添加到购物车 (AJAX)
     */
    @PostMapping("/add")
    @ResponseBody
    public Result<?> add(@RequestParam Integer productId,
                         @RequestParam(defaultValue = "1") Integer quantity,
                         @RequestParam(required = false) String spec,
                         HttpSession session) {
        User user = (User) session.getAttribute("user");
        return cartService.add(user.getId(), productId, spec, quantity);
    }

    /**
     * 更新数量 (AJAX)
     */
    @PostMapping("/updateQuantity")
    @ResponseBody
    public Result<?> updateQuantity(@RequestParam Integer id,
                                    @RequestParam Integer quantity) {
        return cartService.updateQuantity(id, quantity);
    }

    /**
     * 删除购物车项 (AJAX)
     */
    @PostMapping("/delete")
    @ResponseBody
    public Result<?> delete(@RequestParam Integer id) {
        return cartService.delete(id);
    }

    /**
     * 清空购物车 (AJAX)
     */
    @PostMapping("/clear")
    @ResponseBody
    public Result<?> clear(HttpSession session) {
        User user = (User) session.getAttribute("user");
        return cartService.clear(user.getId());
    }

    /**
     * 获取购物车数量 (AJAX)
     */
    @GetMapping("/count")
    @ResponseBody
    public Result<Integer> count(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return Result.success(0);
        }
        return Result.success(cartService.countByUserId(user.getId()));
    }
}
