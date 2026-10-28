package com.sportsstore.service;

import com.sportsstore.pojo.SpecGroup;

import java.util.List;

public interface SpecService {
    List<SpecGroup> findByCategoryId(Integer categoryId);
}