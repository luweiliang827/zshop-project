package com.lwl.backend.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lwl.zshop.common.constant.PaginationConstant;
import com.lwl.zshop.common.constant.ResponseStatusConstant;
import com.lwl.zshop.common.exception.ProductTypeExistException;
import com.lwl.zshop.common.until.ResponseResult;
import com.lwl.zshop.pojo.ProductType;
import com.lwl.zshop.service.ProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * created by luweiliang on 2019/5/28
 */
@Controller
@RequestMapping("/backend/productType")
public class ProductTypeController {

    @Autowired
    private ProductTypeService productTypeService;

    @RequestMapping("/findAll")
    public String findAll(Model model,Integer pageNum){

        if(ObjectUtils.isEmpty(pageNum)){
            pageNum = PaginationConstant.PAGE_NUM;  //当前页默认为1
        }
        //设置分页(PageHelper MyBatis中的分页插件)
        PageHelper.startPage(pageNum,PaginationConstant.PAGE_SIZE);

        //查询所有的产品类型
        List<ProductType> priductTypes = productTypeService.findAll();

        //将查询的结果封装到PageInfo对象中
        PageInfo<ProductType> pageInfo = new PageInfo<>(priductTypes);
        /**
         * pageInfo.getPageNum();//获取当前页
         * pageInfo.getPages();//获取总共多少页
         * pageInfo.getNextPage();//获取下一页
         * pageInfo.getPrePage();//获取上一页
         * pageInfo.getList();
         */

        model.addAttribute("pageInfo",pageInfo);

        return "productTypeManager";
    }

    @RequestMapping("/addProductType")
    //响应JSON，需要配置在Spring-mvc.xml中配置fastjson
    //@ResponseBody这个注解就是将返回的对象转换为json格式的字符串，并通过response响应给客户端的
    @ResponseBody
    public ResponseResult addProductType(String name){
        ResponseResult result = new ResponseResult();
        try {
            productTypeService.addProductType(name);
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);
            result.setMessage("添加成功");
        } catch (ProductTypeExistException e) {
            //e.printStackTrace();
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_FAIL);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/findById")
    @ResponseBody
    public ResponseResult findById(int id){
        ProductType productType = productTypeService.findById(id);
        return ResponseResult.success(productType);
    }

    @RequestMapping("/updateProductType")
    @ResponseBody
    public ResponseResult updateProductType(int id,String name){
        ResponseResult result = new ResponseResult();
        try {
            productTypeService.updateProductType(id,name);
            return ResponseResult.success("修改商品类型成功");
//            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);
//            result.setMessage("修改成功");
        } catch (ProductTypeExistException e) {
            //e.printStackTrace();
//            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_FAIL);
//            result.setMessage(e.getMessage());
            return ResponseResult.fail(e.getMessage());
        }
    }

    @RequestMapping("/deleteProductType")
    @ResponseBody
    public ResponseResult deleteProductType(int id){
        productTypeService.deleteProductType(id);
        return ResponseResult.success("删除商品类型成功");
    }

    @RequestMapping("/modifyStatus")
    @ResponseBody
    public ResponseResult modifyStatus(int id){
        productTypeService.modifyStatus(id);
        return ResponseResult.success();
    }
}
