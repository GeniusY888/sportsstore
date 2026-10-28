package com.sportsstore.mapper;

import com.sportsstore.pojo.Address;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 收货地址Mapper接口
 */
public interface AddressMapper {

    /** 查询用户所有地址 */
    List<Address> findByUserId(Integer userId);

    /** 根据ID查询 */
    Address findById(Integer id);

    /** 查询用户默认地址 */
    Address findDefaultByUserId(Integer userId);

    /** 新增地址 */
    int insert(Address address);

    /** 更新地址 */
    int update(Address address);

    /** 删除地址 */
    int delete(Integer id);

    /** 取消用户所有默认地址 */
    int clearDefault(Integer userId);

    /** 设置默认地址 */
    int setDefault(@Param("id") Integer id, @Param("isDefault") Integer isDefault);

    /** 统计用户地址数量 */
    int countByUserId(Integer userId);
}
