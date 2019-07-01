package com.lwl.zshop.service;

import com.lwl.zshop.common.exception.ProductTypeExistException;
import com.lwl.zshop.pojo.ProductType;

import java.util.List;

/**
 * created by luweiliang on 2019/5/29
 */
public interface ProductTypeService {
    //查询所有的产品类型
    public List<ProductType> findAll();

    /**
     *添加产品类型
     * 判断产品是否已经存在
     *      如果存在抛出异常
     *      如果不存在则添加
     * @param name
     */
    public void addProductType(String name)throws ProductTypeExistException;

    /**
     * 根据商品类型ID查询商品类型
     * @param id
     * @return
     */
    public ProductType findById(int id);

    /**
     * 修改商品类型信息
     */
    public void updateProductType(int id,String name)throws ProductTypeExistException;

    /**
     * 根据商品类型ID删除商品类型
     * 后面可以判断该商品类型下是否有具体的商品，如果有，需要抛出异常
     */
    public void deleteProductType(int id);

    /**
     * 根据商品类型ID修改商品类型状态
     */
    public void modifyStatus(int id);

    /**
     * 查询启用状态的商品类型
     * @return
     */
    public List<ProductType> findEnableStatus();

}
