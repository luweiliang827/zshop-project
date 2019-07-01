package com.lwl.zshop.impl;

import com.lwl.zshop.common.constant.ProductTypeConstant;
import com.lwl.zshop.common.exception.ProductTypeExistException;
import com.lwl.zshop.dao.ProductTypeDao;
import com.lwl.zshop.pojo.ProductType;
import com.lwl.zshop.service.ProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * created by luweiliang on 2019/5/29
 */
@Service
//配置事物，遇到任何错误即回滚
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
public class ProductTypeServiceImpl implements ProductTypeService {

    @Autowired
    //自动注入Dao
    private ProductTypeDao productTypeDao;

    @Override
    //配置事物，配置为只读
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    //查询所有的产品类型
    public List<ProductType> findAll() {

        return productTypeDao.selectAll();
    }

    //添加产品类型
    public void addProductType(String name) throws ProductTypeExistException {

        ProductType productType = productTypeDao.selectProductTypeByName(name);
        if(null != productType){
            throw new ProductTypeExistException("该商品类型已存在");
        }
        productTypeDao.insert(name, ProductTypeConstant.Product_TYPE_ENABLE);
    }

    @Override
    public ProductType findById(int id) {
        return productTypeDao.selectProductTypeById(id);
    }

    @Override
    public void updateProductType(int id, String name) throws ProductTypeExistException{

        ProductType productType = productTypeDao.selectProductTypeByName(name);
        if(null != productType){
            throw new ProductTypeExistException("该商品类型名称已经存在");
        }else{
            productTypeDao.updateName(id,name);
        }
    }

    @Override
    public void deleteProductType(int id) {
        productTypeDao.deleteById(id);
    }

    @Override
    public void modifyStatus(int id) {
        ProductType productType = productTypeDao.selectProductTypeById(id);
        if(null != productType){
           int status = productType.getStatus();
           if((status == ProductTypeConstant.Product_TYPE_ENABLE)){
               status = ProductTypeConstant.product_TYPE_DISABLE;
           }else{
               status = ProductTypeConstant.Product_TYPE_ENABLE;
           }
            productTypeDao.updateStatus(id,status);
        }
    }

    @Override
    public List<ProductType> findEnableStatus() {
        List<ProductType> productTypes = productTypeDao.selectEnableStatus(ProductTypeConstant.Product_TYPE_ENABLE);
        return productTypes;
    }

}
