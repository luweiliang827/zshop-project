package com.lwl.backend.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lwl.backend.vo.ProductVo;
import com.lwl.zshop.common.constant.PaginationConstant;
import com.lwl.zshop.common.until.ResponseResult;
import com.lwl.zshop.dto.ProductDto;
import com.lwl.zshop.pojo.Product;
import com.lwl.zshop.pojo.ProductType;
import com.lwl.zshop.service.ProductService;
import com.lwl.zshop.service.ProductTypeService;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * created by luweiliang on 2019/6/1
 */
@Controller
@RequestMapping("/backend/product")
public class ProductController {

    @Autowired //自动装配，不需要提供get,set方法
    private ProductTypeService productTypeService;

    @Autowired
    private ProductService productService;

    @ModelAttribute("productTypes")  //被 @ModelAttribute 注释的方法会在Controller每个方法执行之前都执行
    public List<ProductType> loadProductTypes(){
        List<ProductType> productTypes = productTypeService.findEnableStatus();
        return productTypes;
    }

    @RequestMapping("/findAll")
    public String findAll(Integer pageNum,Model model){
        if(ObjectUtils.isEmpty(pageNum)){
            pageNum = PaginationConstant.PAGE_NUM;
        }

        //设置分页（PageHelper MyBatis中的分页插件，设置页数及每页显示多少条信息）
        PageHelper.startPage(pageNum,PaginationConstant.PAGE_SIZE);

        List<Product> products = productService.findAllProduct();
        PageInfo<Product> pageInfo = new PageInfo<Product>(products);
        model.addAttribute("pageInfo",pageInfo);
        return "productManager";
    }

    @RequestMapping("/addProduct")
    public String addProduct(ProductVo productVo, Integer pageNum ,HttpSession session, Model model){
        //获取文件上传路径
        String uploadPath = session.getServletContext().getRealPath("/WEB-INF/upload");

        try {
            //将VO转换成DTO，
            ProductDto productDto = new ProductDto();
            PropertyUtils.copyProperties(productDto,productVo); //对象之间属性的拷贝
            productDto.setInputStream(productVo.getFile().getInputStream());
            productDto.setFileName(productVo.getFile().getOriginalFilename());
            productDto.setUploadPath(uploadPath);

            productService.addProduct(productDto);
            model.addAttribute("successMsg","添加成功");
        } catch (Exception e) {
            //e.printStackTrace();
            model.addAttribute("errorMsg",e.getMessage());
        }
        return "forward:findAll?pageNum="+pageNum;
    }

    @RequestMapping("/modifyProduct")
    public String modifyProduct(ProductVo productVo,Integer pageNum,HttpSession session,Model model){
        String uploadPath = session.getServletContext().getRealPath("/WEB-INF/upload");

        //将vo转换成DTO
        ProductDto productDto = new ProductDto();
        try {
            PropertyUtils.copyProperties(productDto,productVo); //将vo中和Dto相同的属性拷贝到Dto中
            productDto.setInputStream(productVo.getFile().getInputStream());
            productDto.setFileName(productVo.getFile().getOriginalFilename());
            productDto.setUploadPath(uploadPath);
            productService.modifyProduct(productDto);
            model.addAttribute("successMsg","修改成功");
        } catch (Exception e) {
           // e.printStackTrace();
            model.addAttribute("errorMsg",e.getMessage());
        }
        return "forward:findAll?pageNum="+pageNum;
    }

    @RequestMapping("/checkProductName")
    @ResponseBody
    //前端remote的请求返回结果参数valid ResponseResult类中并没有，所以只能定义一个Map集合来返回该valid参数
    public Map<String,Object> checkProductName(String name){
        Map<String,Object> map = new HashMap<>();
        boolean flag = productService.checkProductName(name);
        if(flag){
            map.put("valid",true);
        }else{
            map.put("valid",false);
            map.put("message","商品("+name+")已经存在");
        }
        return map;
    }

    @RequestMapping("/findProductById")
    @ResponseBody
    public ResponseResult findProductById(int id){
        Product product = productService.findProductById(id);
        return ResponseResult.success(product);
    }

    @RequestMapping("/getImage")
    public void getImage(String path, OutputStream outputStream){
        productService.getImage(path,outputStream);
    }

    @RequestMapping("/removeProductById")
    @ResponseBody
    public ResponseResult removeProductById(int id){
        productService.removeProduct(id);
        return ResponseResult.success("商品删除成功");
    }
}
