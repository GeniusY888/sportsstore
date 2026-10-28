package com.sportsstore.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sportsstore.dto.Result;
import com.sportsstore.mapper.ProductMapper;
import com.sportsstore.pojo.Product;
import com.sportsstore.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 商品服务实现
 */
@Service("productService")
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductMapper productMapper;

    @Override
    public PageInfo<Product> listOnSale(int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Product> list = productMapper.findAllOnSale();
        return new PageInfo<>(list);
    }

    @Override
    public PageInfo<Product> listByCategory(int categoryId, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Product> list = productMapper.findByCategoryId(categoryId);
        return new PageInfo<>(list);
    }

    @Override
    public PageInfo<Product> search(String keyword, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Product> list = productMapper.searchByName(keyword);
        return new PageInfo<>(list);
    }

    @Override
    public List<Product> findHot(int limit) {
        return productMapper.findHot(limit);
    }

    @Override
    public List<Product> findNew(int limit) {
        return productMapper.findNew(limit);
    }

    @Override
    public Product findById(Integer id) {
        return productMapper.findById(id);
    }

    // ==================== 后台管理 ====================

    @Override
    public PageInfo<Product> listAll(int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Product> list = productMapper.findAll();
        return new PageInfo<>(list);
    }

    @Override
    public PageInfo<Product> listByCondition(String name, Integer categoryId, Integer status,
                                             int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Product> list = productMapper.findByCondition(name, categoryId, status);
        return new PageInfo<>(list);
    }

    @Override
    public Result<?> add(Product product) {
        if (product.getName() == null || product.getName().trim().isEmpty()) {
            return Result.error("商品名称不能为空");
        }
        if (product.getPrice() == null) {
            return Result.error("商品价格不能为空");
        }
        if (product.getCategoryId() == null) {
            return Result.error("请选择商品分类");
        }

        int rows = productMapper.insert(product);
        if (rows > 0) {
            return Result.success("商品添加成功");
        }
        return Result.error("商品添加失败");
    }

    @Override
    public Result<?> update(Product product) {
        if (product == null || product.getId() == null) {
            return Result.error("参数错误");
        }
        int rows = productMapper.update(product);
        if (rows > 0) {
            return Result.success("商品修改成功");
        }
        return Result.error("商品修改失败");
    }

    @Override
    public Result<?> updateStatus(Integer id, Integer status) {
        if (id == null || status == null) {
            return Result.error("参数错误");
        }
        int rows = productMapper.updateStatus(id, status);
        if (rows > 0) {
            String msg = status == 1 ? "商品已上架" : "商品已下架";
            return Result.success(msg);
        }
        return Result.error("操作失败");
    }

    @Override
    public Result<?> delete(Integer id) {
        int rows = productMapper.delete(id);
        if (rows > 0) {
            return Result.success("商品删除成功");
        }
        return Result.error("商品删除失败");
    }

    @Override
    public void deductStock(Integer id, int quantity) {
        // 扣减库存（负数为减少）
        productMapper.updateStock(id, -quantity);
    }
}
