package com.sportsstore.mapper;

import com.sportsstore.pojo.SpecValue;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SpecValueMapper {
    List<SpecValue> findByGroupId(@Param("groupId") Integer groupId);
    int insert(SpecValue specValue);
    int update(SpecValue specValue);
    int delete(Integer id);
}