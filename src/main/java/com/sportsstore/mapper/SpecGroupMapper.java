package com.sportsstore.mapper;

import com.sportsstore.pojo.SpecGroup;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SpecGroupMapper {
    List<SpecGroup> findByCategoryId(@Param("categoryId") Integer categoryId);
    int insert(SpecGroup specGroup);
    int update(SpecGroup specGroup);
    int delete(Integer id);
}