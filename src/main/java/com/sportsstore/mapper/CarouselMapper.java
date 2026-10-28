package com.sportsstore.mapper;

import com.sportsstore.pojo.Carousel;

import java.util.List;

/**
 * 轮播图Mapper接口
 */
public interface CarouselMapper {

    /** 查询所有启用的轮播图(按排序) */
    List<Carousel> findAllEnabled();

    /** 管理员: 查询所有轮播图 */
    List<Carousel> findAll();

    /** 根据ID查询 */
    Carousel findById(Integer id);

    /** 新增 */
    int insert(Carousel carousel);

    /** 更新 */
    int update(Carousel carousel);

    /** 删除 */
    int delete(Integer id);
}
