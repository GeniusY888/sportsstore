package com.sportsstore.mapper;

import com.sportsstore.pojo.Category;

import java.util.List;

/**
 * 商品分类Mapper接口
 */
public interface CategoryMapper {

    /** 查询所有分类 */
    List<Category> findAll();

    /** 根据ID查询 */
    Category findById(Integer id);

    /** 新增分类 */
    int insert(Category category);

    /** 更新分类 */
    int update(Category category);

    /** 删除分类 */
    int delete(Integer id);

    /** 检查分类下是否有商品 */
    int countProductsByCategory(Integer categoryId);
}
