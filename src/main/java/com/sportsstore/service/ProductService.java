package com.sportsstore.service;

import com.github.pagehelper.PageInfo;
import com.sportsstore.dto.Result;
import com.sportsstore.pojo.Product;

import java.util.List;

/**
 * 商品服务接口
 */
public interface ProductService {

    /** 前台: 分页查询上架商品 */
    PageInfo<Product> listOnSale(int pageNum, int pageSize);

    /** 前台: 按分类分页查询商品 */
    PageInfo<Product> listByCategory(int categoryId, int pageNum, int pageSize);

    /** 前台: 模糊搜索商品 */
    PageInfo<Product> search(String keyword, int pageNum, int pageSize);

    /** 前台: 热门商品 */
    List<Product> findHot(int limit);

    /** 前台: 新品推荐 */
    List<Product> findNew(int limit);

    /** 根据ID查询 */
    Product findById(Integer id);

    /** 后台: 分页查询所有商品(含下架) */
    PageInfo<Product> listAll(int pageNum, int pageSize);

    /** 后台: 条件筛选商品 */
    PageInfo<Product> listByCondition(String name, Integer categoryId, Integer status,
                                      int pageNum, int pageSize);

    /** 后台: 新增商品 */
    Result<?> add(Product product);

    /** 后台: 更新商品 */
    Result<?> update(Product product);

    /** 后台: 上架/下架 */
    Result<?> updateStatus(Integer id, Integer status);

    /** 后台: 删除商品 */
    Result<?> delete(Integer id);

    /** 扣减库存(下单时调用, 事务管理) */
    void deductStock(Integer id, int quantity);
}
