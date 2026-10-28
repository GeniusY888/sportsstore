package com.sportsstore.controller.fore;

import com.github.pagehelper.PageInfo;
import com.sportsstore.pojo.Product;
import com.sportsstore.service.CategoryService;
import com.sportsstore.service.ProductService;
import com.sportsstore.service.SpecService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * 前台商品控制器
 */
@Controller("foreProductController")
@RequestMapping("/fore/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private SpecService specService;

    /**
     * 商品列表页 (支持分类筛选、搜索、分页)
     */
    @GetMapping("/list")
    public String list(@RequestParam(required = false) Integer categoryId,
                       @RequestParam(required = false) String keyword,
                       @RequestParam(defaultValue = "1") int pageNum,
                       @RequestParam(defaultValue = "12") int pageSize,
                       Model model) {

        PageInfo<Product> pageInfo;
        if (keyword != null && !keyword.trim().isEmpty()) {
            // 搜索模式
            pageInfo = productService.search(keyword.trim(), pageNum, pageSize);
            model.addAttribute("keyword", keyword.trim());
        } else if (categoryId != null) {
            // 分类筛选
            pageInfo = productService.listByCategory(categoryId, pageNum, pageSize);
            model.addAttribute("categoryId", categoryId);
        } else {
            // 全部分类
            pageInfo = productService.listOnSale(pageNum, pageSize);
        }

        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("categories", categoryService.findAll());
        return "fore/productList";
    }

    /**
     * 商品详情页
     */
    @GetMapping("/detail")
    public String detail(@RequestParam Integer id, Model model) {
        Product product = productService.findById(id);
        if (product == null || product.getStatus() == 0) {
            return "error/404";
        }
        model.addAttribute("product", product);
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("specGroups", specService.findByCategoryId(product.getCategoryId()));
        return "fore/productDetail";
    }
}
