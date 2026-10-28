package com.sportsstore.service;

import com.sportsstore.dto.Result;
import com.sportsstore.pojo.Review;

import java.util.List;

public interface ReviewService {

    Result<?> addReview(Integer userId, Integer productId, Integer rating, String content);

    List<Review> findByProductId(Integer productId);

    List<Review> findAll();

    int countByProductId(Integer productId);

    Double avgRatingByProductId(Integer productId);

    Result<?> delete(Integer id, Integer userId);

    Result<?> adminDelete(Integer id);

    boolean canReview(Integer userId, Integer productId);
}