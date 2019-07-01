package com.lwl.zshop.dao;

import com.lwl.zshop.params.ProductParam;
import com.lwl.zshop.pojo.Product;

import java.util.List;

/**
 * created by luweiliang on 2019/6/1
 */
public interface ProductDao {

    /**
     * 添加商品
     */
    public void insertProduct(Product product);

    /**
     * 根据商品名称查询商品是否存在
     */
    public Product selectProductByName(String name);

    /**
     * 查询所有的商品信息
     */
    public List<Product> selectProduct();

    /**
     * 根据商品ID查询商品信息
     */
    public Product selectProductById(int id);

    public void updateProduct(Product product);

    public void deleteProductById(int id);

    /**
     * 根据条件查询商品信息
     */
    public List<Product> selectByParams(ProductParam productParam);
}
