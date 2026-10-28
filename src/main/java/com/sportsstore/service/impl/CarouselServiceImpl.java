package com.sportsstore.service.impl;

import com.sportsstore.mapper.CarouselMapper;
import com.sportsstore.pojo.Carousel;
import com.sportsstore.service.CarouselService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 轮播图服务实现
 */
@Service("carouselService")
public class CarouselServiceImpl implements CarouselService {

    @Autowired
    private CarouselMapper carouselMapper;

    @Override
    public List<Carousel> findEnabled() {
        return carouselMapper.findAllEnabled();
    }

    @Override
    public List<Carousel> findAll() {
        return carouselMapper.findAll();
    }

    @Override
    public int add(Carousel carousel) {
        return carouselMapper.insert(carousel);
    }

    @Override
    public int update(Carousel carousel) {
        return carouselMapper.update(carousel);
    }

    @Override
    public int delete(Integer id) {
        return carouselMapper.delete(id);
    }
}
