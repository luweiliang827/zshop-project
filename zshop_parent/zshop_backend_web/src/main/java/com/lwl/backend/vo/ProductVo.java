package com.lwl.backend.vo;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * created by luweiliang on 2019/6/1
 * 因为Product 类中的属性和页面上传数据属性不一样，所以需要创建一个ProductVo类来接收
 * CommonsMultipartFile 这个类依赖于spring的jra包，所以为了解耦合不能把ProductVO类放到common中
 * 只能放在web项目中，service层调用ProductVo的时候再创建一个ProductDto的类来进行转换
 */
public class ProductVo {
    private Integer id;
    private String name;
    private Double price;
    private CommonsMultipartFile file;
    private Integer productTypeId;
    private String info;

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public CommonsMultipartFile getFile() {
        return file;
    }

    public void setFile(CommonsMultipartFile file) {
        this.file = file;
    }

    public Integer getProductTypeId() {
        return productTypeId;
    }

    public void setProductTypeId(Integer productTypeId) {
        this.productTypeId = productTypeId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}
