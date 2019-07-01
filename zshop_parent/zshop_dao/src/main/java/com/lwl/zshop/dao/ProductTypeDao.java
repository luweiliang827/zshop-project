package com.lwl.zshop.dao;

import com.lwl.zshop.pojo.ProductType;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * created by luweiliang on 2019/5/29
 */
public interface ProductTypeDao {

    /**
     * 查询所有的产品类型信息
     * @return
     */
    public List<ProductType> selectAll();

    /**
     * 根据产品类型ID查询产品类型信息
     * @param id
     * @return
     */
    public ProductType selectProductTypeById(int id);

    /**
     * 根据产品类型名称查询产品类型信息
     * @param name
     * @return
     */
    public ProductType selectProductTypeByName(String name);

    /**
     * 添加产品类型信息
     * @param name
     */
    public void insert(@Param("name") String name,@Param("status") int status);

    /**
     * 修改产品类型名称
     */
    public void updateName(@Param("id") int id, @Param("name") String name);

    /**
     * 修改产品类型状态
     */
    public void updateStatus(@Param("id") int id, @Param("status") int status);

    /**
     * 根据产品类型ID删除产品类型
     */
    public void deleteById(int id);

    /**
     * 查询所有启用状态的商品类型
     */
    public List<ProductType> selectEnableStatus(int status);
}
