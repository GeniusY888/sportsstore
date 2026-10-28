package com.sportsstore.controller.admin;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sportsstore.dto.Result;
import com.sportsstore.pojo.Category;
import com.sportsstore.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 后台商品分类管理控制器
 */
@Controller
@RequestMapping("/admin/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    /**
     * 分类列表页
     */
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int pageNum,
                       @RequestParam(defaultValue = "10") int pageSize,
                       Model model) {
        PageHelper.startPage(pageNum, pageSize);
        List<Category> list = categoryService.findAll();
        model.addAttribute("pageInfo", new PageInfo<>(list));
        return "admin/categoryList";
    }

    /**
     * 新增分类
     */
    @PostMapping("/add")
    @ResponseBody
    public Result<?> add(@RequestParam String name) {
        return categoryService.add(name);
    }

    /**
     * 编辑分类
     */
    @PostMapping("/update")
    @ResponseBody
    public Result<?> update(Category category) {
        return categoryService.update(category);
    }

    /**
     * 删除分类
     */
    @PostMapping("/delete")
    @ResponseBody
    public Result<?> delete(@RequestParam Integer id) {
        return categoryService.delete(id);
    }
}
