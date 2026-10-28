package com.sportsstore.controller.admin;

import com.github.pagehelper.PageInfo;
import com.sportsstore.dto.Result;
import com.sportsstore.pojo.Product;
import com.sportsstore.service.CategoryService;
import com.sportsstore.service.ProductService;
import com.sportsstore.util.FileUploadUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;

/**
 * 后台商品管理控制器
 */
@Controller("adminProductController")
@RequestMapping("/admin/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    /**
     * 商品列表页
     */
    @GetMapping("/list")
    public String list(@RequestParam(required = false) String name,
                       @RequestParam(required = false) Integer categoryId,
                       @RequestParam(required = false) Integer status,
                       @RequestParam(defaultValue = "1") int pageNum,
                       @RequestParam(defaultValue = "10") int pageSize,
                       Model model) {
        PageInfo<Product> pageInfo = productService.listByCondition(name, categoryId, status, pageNum, pageSize);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("categories", categoryService.findAll());
        // 回显筛选条件
        model.addAttribute("name", name);
        model.addAttribute("categoryId", categoryId);
        model.addAttribute("status", status);
        return "admin/productList";
    }

    /**
     * 新增商品页面
     */
    @GetMapping("/addPage")
    public String addPage(Model model) {
        model.addAttribute("categories", categoryService.findAll());
        return "admin/productAdd";
    }

    /**
     * 新增商品接口
     */
    @PostMapping("/add")
    @ResponseBody
    public Result<?> add(Product product,
                         @RequestParam(required = false) MultipartFile imageFile,
                         HttpServletRequest request) {
        // 上传图片
        if (imageFile != null && !imageFile.isEmpty()) {
            String basePath = request.getServletContext().getRealPath("/") + "static" + java.io.File.separator + "upload";
            String imagePath = FileUploadUtil.upload(imageFile, basePath, "product");
            product.setImage(imagePath);
        }
        return productService.add(product);
    }

    /**
     * 编辑商品页面
     */
    @GetMapping("/editPage")
    public String editPage(@RequestParam Integer id, Model model) {
        model.addAttribute("product", productService.findById(id));
        model.addAttribute("categories", categoryService.findAll());
        return "admin/productEdit";
    }

    /**
     * 编辑商品接口
     */
    @PostMapping("/update")
    @ResponseBody
    public Result<?> update(Product product,
                            @RequestParam(required = false) MultipartFile imageFile,
                            HttpServletRequest request) {
        if (imageFile != null && !imageFile.isEmpty()) {
            String basePath = request.getServletContext().getRealPath("/") + "static" + java.io.File.separator + "upload";
            String imagePath = FileUploadUtil.upload(imageFile, basePath, "product");
            product.setImage(imagePath);
        }
        return productService.update(product);
    }

    /**
     * 上架/下架
     */
    @PostMapping("/updateStatus")
    @ResponseBody
    public Result<?> updateStatus(@RequestParam Integer id, @RequestParam Integer status) {
        return productService.updateStatus(id, status);
    }

    /**
     * 删除商品
     */
    @PostMapping("/delete")
    @ResponseBody
    public Result<?> delete(@RequestParam Integer id) {
        return productService.delete(id);
    }
}
