package com.sportsstore.service;

import com.sportsstore.dto.Result;
import com.sportsstore.pojo.Category;

import java.util.List;

/**
 * 商品分类服务接口
 */
public interface CategoryService {

    /** 查询所有分类 */
    List<Category> findAll();

    /** 根据ID查询 */
    Category findById(Integer id);

    /** 新增分类 */
    Result<?> add(String name);

    /** 编辑分类 */
    Result<?> update(Category category);

    /** 删除分类(校验是否有商品) */
    Result<?> delete(Integer id);
}
