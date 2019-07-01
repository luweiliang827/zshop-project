package com.lwl.zshop.service;

import com.lwl.zshop.dto.ProductDto;
import com.lwl.zshop.params.ProductParam;
import com.lwl.zshop.pojo.Product;
import com.lwl.zshop.pojo.ProductType;
import org.apache.commons.fileupload.FileUploadException;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

/**
 * created by luweiliang on 2019/6/1
 */
public interface ProductService {

    /**
     * 添加商品
     */
    public void addProduct(ProductDto productDto) throws FileUploadException, IOException;

    /**
     * 根据商品名称查找对应的商品
     */
    public Boolean checkProductName(String name);

    /**
     * 查询所有的产品信息
     */
    public List<Product> findAllProduct();

    public Product findProductById(int id);

    public void modifyProduct(ProductDto productDto) throws FileUploadException, IOException;

    public void removeProduct(int id);

    /**
     * 获取图片，放入到outputStream 流中
     * @param path
     * @param outputStream
     */
    public void getImage(String path, OutputStream outputStream);

    /**
     * 添加和修改公共类
     * @param productDto
     * @return
     */
    public Product getProductInfo(ProductDto productDto) throws FileUploadException, IOException;

    /**
     * 根据条件查询产品信息
     */
    public List<Product> findByParams(ProductParam productParam);
}
