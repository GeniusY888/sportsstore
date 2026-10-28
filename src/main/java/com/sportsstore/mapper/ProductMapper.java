package com.sportsstore.mapper;

import com.sportsstore.pojo.Product;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 商品Mapper接口
 */
public interface ProductMapper {

    /** 分页查询所有上架商品 */
    List<Product> findAllOnSale();

    /** 根据ID查询商品 */
    Product findById(Integer id);

    /** 按分类ID查询上架商品 */
    List<Product> findByCategoryId(Integer categoryId);

    /** 模糊搜索商品名称 */
    List<Product> searchByName(String keyword);

    /** 查询热门商品 (limit) */
    List<Product> findHot(@Param("limit") int limit);

    /** 查询新品 */
    List<Product> findNew(@Param("limit") int limit);

    /** 管理员: 查询所有商品(含下架) */
    List<Product> findAll();

    /** 管理员: 按条件筛选商品 */
    List<Product> findByCondition(@Param("name") String name,
                                  @Param("categoryId") Integer categoryId,
                                  @Param("status") Integer status);

    /** 新增商品 */
    int insert(Product product);

    /** 更新商品 */
    int update(Product product);

    /** 更新商品状态 (上架/下架) */
    int updateStatus(@Param("id") Integer id, @Param("status") Integer status);

    /** 更新商品库存 */
    int updateStock(@Param("id") Integer id, @Param("stock") Integer stock);

    /** 更新商品销量 */
    int updateSalesVolume(@Param("id") Integer id, @Param("amount") Integer amount);

    /** 删除商品 */
    int delete(Integer id);
}
