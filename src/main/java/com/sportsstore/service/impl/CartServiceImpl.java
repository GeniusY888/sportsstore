package com.sportsstore.service.impl;

import com.sportsstore.dto.Result;
import com.sportsstore.mapper.CartMapper;
import com.sportsstore.mapper.ProductMapper;
import com.sportsstore.pojo.Cart;
import com.sportsstore.pojo.Product;
import com.sportsstore.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

/**
 * 购物车服务实现
 */
@Service("cartService")
public class CartServiceImpl implements CartService {

    @Autowired
    private CartMapper cartMapper;

    @Autowired
    private ProductMapper productMapper;

    @Override
    public List<Cart> findByUserId(Integer userId) {
        return cartMapper.findByUserId(userId);
    }

    @Override
    public Result<?> add(Integer userId, Integer productId, String spec, Integer quantity) {
        if (productId == null) {
            return Result.error("商品参数错误");
        }
        if (quantity == null || quantity <= 0) {
            quantity = 1;
        }

        // 检查商品是否存在且已上架
        Product product = productMapper.findById(productId);
        if (product == null || product.getStatus() == 0) {
            return Result.error("商品不存在或已下架");
        }

        // 检查库存
        if (product.getStock() < quantity) {
            return Result.error("商品库存不足，当前库存: " + product.getStock());
        }

        // 检查购物车中是否已有该商品（同规格）
        Cart existCart = cartMapper.findByUserAndProductAndSpec(userId, productId, spec);
        if (existCart != null) {
            // 已有则增加数量
            int newQuantity = existCart.getQuantity() + quantity;
            if (newQuantity > product.getStock()) {
                return Result.error("超出商品库存上限");
            }
            cartMapper.updateQuantity(existCart.getId(), newQuantity);
            return Result.success("购物车数量已更新");
        }

        // 新建购物车项
        Cart cart = new Cart();
        cart.setUserId(userId);
        cart.setProductId(productId);
        cart.setSpec(spec);
        cart.setQuantity(quantity);
        cartMapper.insert(cart);
        return Result.success("已添加到购物车");
    }

    @Override
    public Result<?> updateQuantity(Integer id, Integer quantity) {
        if (quantity == null || quantity <= 0) {
            return Result.error("数量必须大于0");
        }
        int rows = cartMapper.updateQuantity(id, quantity);
        if (rows > 0) {
            return Result.success("数量已更新");
        }
        return Result.error("更新失败");
    }

    @Override
    public Result<?> delete(Integer id) {
        int rows = cartMapper.delete(id);
        if (rows > 0) {
            return Result.success("已从购物车移除");
        }
        return Result.error("删除失败");
    }

    @Override
    public Result<?> clear(Integer userId) {
        cartMapper.deleteByUserId(userId);
        return Result.success("购物车已清空");
    }

    @Override
    public BigDecimal calcTotal(Integer userId) {
        List<Cart> carts = findByUserId(userId);
        BigDecimal total = BigDecimal.ZERO;
        for (Cart cart : carts) {
            if (cart.getProduct() != null) {
                total = total.add(cart.getSubtotal());
            }
        }
        return total;
    }

    @Override
    public int countByUserId(Integer userId) {
        return cartMapper.countByUserId(userId);
    }
}
