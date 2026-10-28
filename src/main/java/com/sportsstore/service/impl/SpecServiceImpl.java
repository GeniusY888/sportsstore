package com.sportsstore.service.impl;

import com.sportsstore.mapper.SpecGroupMapper;
import com.sportsstore.pojo.SpecGroup;
import com.sportsstore.service.SpecService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("specService")
public class SpecServiceImpl implements SpecService {

    @Autowired
    private SpecGroupMapper specGroupMapper;

    @Override
    public List<SpecGroup> findByCategoryId(Integer categoryId) {
        return specGroupMapper.findByCategoryId(categoryId);
    }
}