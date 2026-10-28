package com.sportsstore.mapper;

import com.sportsstore.pojo.Review;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ReviewMapper {

    int insert(Review review);

    List<Review> findByProductId(Integer productId);

    List<Review> findAll();

    int countByProductId(Integer productId);

    Double avgRatingByProductId(Integer productId);

    Review findById(Integer id);

    int delete(Integer id);

    Integer countByUserIdAndProductId(@Param("userId") Integer userId, @Param("productId") Integer productId);
}