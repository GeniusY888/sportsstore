package com.sportsstore.service.impl;

import com.sportsstore.dto.Result;
import com.sportsstore.mapper.CategoryMapper;
import com.sportsstore.pojo.Category;
import com.sportsstore.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 商品分类服务实现
 */
@Service("categoryService")
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryMapper categoryMapper;

    @Override
    public List<Category> findAll() {
        return categoryMapper.findAll();
    }

    @Override
    public Category findById(Integer id) {
        return categoryMapper.findById(id);
    }

    @Override
    public Result<?> add(String name) {
        if (name == null || name.trim().isEmpty()) {
            return Result.error("分类名称不能为空");
        }
        Category category = new Category(name.trim());
        int rows = categoryMapper.insert(category);
        if (rows > 0) {
            return Result.success("分类添加成功");
        }
        return Result.error("分类添加失败");
    }

    @Override
    public Result<?> update(Category category) {
        if (category == null || category.getId() == null) {
            return Result.error("参数错误");
        }
        if (category.getName() == null || category.getName().trim().isEmpty()) {
            return Result.error("分类名称不能为空");
        }
        int rows = categoryMapper.update(category);
        if (rows > 0) {
            return Result.success("分类修改成功");
        }
        return Result.error("分类修改失败");
    }

    @Override
    public Result<?> delete(Integer id) {
        // 检查分类下是否有商品
        int productCount = categoryMapper.countProductsByCategory(id);
        if (productCount > 0) {
            return Result.error("该分类下还有 " + productCount + " 件商品，无法删除");
        }

        int rows = categoryMapper.delete(id);
        if (rows > 0) {
            return Result.success("分类删除成功");
        }
        return Result.error("分类删除失败");
    }
}
