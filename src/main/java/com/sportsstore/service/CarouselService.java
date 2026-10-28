package com.sportsstore.service;

import com.sportsstore.pojo.Carousel;

import java.util.List;

/**
 * 轮播图服务接口
 */
public interface CarouselService {

    /** 前台: 查询启用轮播 */
    List<Carousel> findEnabled();

    /** 后台: 查询所有 */
    List<Carousel> findAll();

    /** 新增 */
    int add(Carousel carousel);

    /** 更新 */
    int update(Carousel carousel);

    /** 删除 */
    int delete(Integer id);
}
