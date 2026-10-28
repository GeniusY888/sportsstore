package com.sportsstore.service.impl;

import com.sportsstore.dto.Result;
import com.sportsstore.mapper.ReviewMapper;
import com.sportsstore.mapper.OrderMapper;
import com.sportsstore.pojo.Review;
import com.sportsstore.pojo.Order;
import com.sportsstore.pojo.OrderItem;
import com.sportsstore.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private ReviewMapper reviewMapper;

    @Autowired
    private OrderMapper orderMapper;

    @Override
    @Transactional
    public Result<?> addReview(Integer userId, Integer productId, Integer rating, String content) {
        if (rating == null || rating < 1 || rating > 5) {
            return Result.error(400, "评分必须在1-5之间");
        }
        if (content == null || content.trim().isEmpty()) {
            return Result.error(400, "评价内容不能为空");
        }

        if (!canReview(userId, productId)) {
            return Result.error(403, "只有购买并确认收货后才能评价");
        }

        Review review = new Review();
        review.setUserId(userId);
        review.setProductId(productId);
        review.setRating(rating);
        review.setContent(content.trim());

        reviewMapper.insert(review);
        return Result.success("评价成功");
    }

    @Override
    public List<Review> findByProductId(Integer productId) {
        return reviewMapper.findByProductId(productId);
    }

    @Override
    public List<Review> findAll() {
        return reviewMapper.findAll();
    }

    @Override
    public int countByProductId(Integer productId) {
        return reviewMapper.countByProductId(productId);
    }

    @Override
    public Double avgRatingByProductId(Integer productId) {
        return reviewMapper.avgRatingByProductId(productId);
    }

    @Override
    @Transactional
    public Result<?> delete(Integer id, Integer userId) {
        Review review = reviewMapper.findById(id);
        if (review == null) {
            return Result.error(404, "评价不存在");
        }
        if (!review.getUserId().equals(userId)) {
            return Result.error(403, "无权删除此评价");
        }
        reviewMapper.delete(id);
        return Result.success("删除成功");
    }

    @Override
    @Transactional
    public Result<?> adminDelete(Integer id) {
        Review review = reviewMapper.findById(id);
        if (review == null) {
            return Result.error(404, "评价不存在");
        }
        reviewMapper.delete(id);
        return Result.success("删除成功");
    }

    @Override
    public boolean canReview(Integer userId, Integer productId) {
        Integer existingCount = reviewMapper.countByUserIdAndProductId(userId, productId);
        if (existingCount != null && existingCount > 0) {
            return false;
        }
        return hasCompletedOrder(userId, productId);
    }

    private boolean hasCompletedOrder(Integer userId, Integer productId) {
        List<Order> orders = orderMapper.findByUserId(userId);
        if (orders == null || orders.isEmpty()) {
            return false;
        }
        for (Order order : orders) {
            if (order.getStatus() == Order.STATUS_COMPLETED) {
                List<OrderItem> items = orderMapper.findItemsByOrderId(order.getId());
                if (items != null) {
                    for (OrderItem item : items) {
                        if (item.getProductId().equals(productId)) {
                            return true;
                        }
                    }
                }
            }
        }
        return false;
    }
}