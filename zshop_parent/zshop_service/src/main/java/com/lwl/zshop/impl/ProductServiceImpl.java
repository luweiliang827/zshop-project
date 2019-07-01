package com.lwl.zshop.impl;

import com.lwl.zshop.common.until.StringUtils;
import com.lwl.zshop.dao.ProductDao;
import com.lwl.zshop.dto.ProductDto;
import com.lwl.zshop.params.ProductParam;
import com.lwl.zshop.pojo.Product;
import com.lwl.zshop.pojo.ProductType;
import com.lwl.zshop.service.ProductService;
import org.apache.commons.fileupload.FileUploadException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StreamUtils;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * created by luweiliang on 2019/6/1
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
public class ProductServiceImpl implements ProductService {

    //@Value是spring提供的标签，用于快捷获取properties属性值
    @Value("${ftp.hostname}")
    String hostname;
    @Value("${ftp.username}")
    String username;
    @Value("${ftp.password}")
    String password;
    @Value("${ftp.basePath}")
    String basePath;

    @Autowired
    private ProductDao productDao;

    @Override
    public void addProduct(ProductDto productDto) throws FileUploadException, IOException {

        //从公共方法中获取处理后的product对象
        Product product = getProductInfo(productDto);
        productDao.insertProduct(product);
    }

    @Override
    public Boolean checkProductName(String name) {
        Product product = productDao.selectProductByName(name);
        if(null != product){
            return false;
        }
        return true;
    }

    @Override
    public List<Product> findAllProduct() {
        List<Product> list = productDao.selectProduct();
        return list;
    }

    @Override
    public Product findProductById(int id) {
        Product product = productDao.selectProductById(id);
        return product;
    }

    @Override
    public void modifyProduct(ProductDto productDto) throws FileUploadException, IOException {

        //从公共类中获取到product信息
        Product product = getProductInfo(productDto);
        productDao.updateProduct(product);
    }

    @Override
    public void removeProduct(int id) {
        productDao.deleteProductById(id);
    }

    /**
     * 获取图片，写到输出流中
     * @param path
     * @param outputStream
     */
    @Override
    public void getImage(String path, OutputStream outputStream) {
        try {
            StreamUtils.copy(new FileInputStream(path),outputStream);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public Product getProductInfo(ProductDto productDto) throws FileUploadException, IOException {
        //1、文件上传
        String fileName = StringUtils.renameFileName(productDto.getFileName());  //获取文件名
        //String filePath = productDto.getUploadPath()+"/"+fileName; //获取文件路径
        String targetPath = new SimpleDateFormat("/yyyy/MM/dd").format(new Date());
        String filePath = StringUtils.FtpUpload(hostname,username,password,basePath,targetPath,fileName,productDto.getInputStream());
        /*try {
            StreamUtils.copy(productDto.getInputStream(),new FileOutputStream(filePath));
        }catch ( IOException e){
            //throw new FileUploadException("文件上传失败"+e.getMessage());
            e.printStackTrace();
        }*/

        //2、保存到数据库
        Product product = new Product();
        if(null != productDto.getId()){
            product.setId(productDto.getId());
        }
        product.setName(productDto.getName());
        product.setImage(filePath);
        product.setInfo(productDto.getInfo());
        product.setPrice(productDto.getPrice());
        //获取产品类型ID
        ProductType productType = new ProductType();
        productType.setId(productDto.getProductTypeId());
        product.setProductType(productType);

        return product;
    }

    @Override
    public List<Product> findByParams(ProductParam productParam) {
        List<Product> products = productDao.selectByParams(productParam);
        return products;
    }
}
