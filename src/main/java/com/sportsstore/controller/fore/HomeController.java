package com.sportsstore.controller.fore;

import com.sportsstore.service.CarouselService;
import com.sportsstore.service.CategoryService;
import com.sportsstore.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 前台首页控制器
 */
@Controller
@RequestMapping("/fore")
public class HomeController {

    @Autowired
    private CarouselService carouselService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ProductService productService;

    @GetMapping({"/", "/home", "/index"})
    public String home(Model model) {
        // 轮播图
        model.addAttribute("carousels", carouselService.findEnabled());
        // 全部分类
        model.addAttribute("categories", categoryService.findAll());
        // 热门商品 (Top 8)
        model.addAttribute("hotProducts", productService.findHot(8));
        // 新品推荐 (Top 8)
        model.addAttribute("newProducts", productService.findNew(8));
        return "fore/home";
    }
}
