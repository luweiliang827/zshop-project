package com.lwl.zshop.front.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lwl.zshop.common.constant.PaginationConstant;
import com.lwl.zshop.params.ProductParam;
import com.lwl.zshop.pojo.Product;
import com.lwl.zshop.pojo.ProductType;
import com.lwl.zshop.service.ProductService;
import com.lwl.zshop.service.ProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * created by luweiliang on 2019/6/7
 */
@Controller
@RequestMapping("/front/product")
public class ProductController {

    @Autowired
    private ProductTypeService productTypeService;

    @Autowired
    private ProductService productService;

    @ModelAttribute("productTypes")
    public List<ProductType> loadProductTypes(){
        List<ProductType> productTypes = productTypeService.findEnableStatus();
        return productTypes;
    }

    @RequestMapping("/search")
    public String search(ProductParam productParam, Integer pageNum, Model model){

        if (ObjectUtils.isEmpty(pageNum)){
            pageNum = PaginationConstant.PAGE_NUM;
        }

        PageHelper.startPage(pageNum,PaginationConstant.FRONT_PAGE_SIZE);
        List<Product> products = productService.findByParams(productParam);
        PageInfo<Product> pageInfo = new PageInfo<Product>(products);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("productParam",productParam);
        return "main";
    }
}
