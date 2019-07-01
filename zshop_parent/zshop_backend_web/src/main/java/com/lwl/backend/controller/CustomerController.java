package com.lwl.backend.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lwl.zshop.common.constant.CustomerConstant;
import com.lwl.zshop.common.constant.PaginationConstant;
import com.lwl.zshop.common.until.ResponseResult;
import com.lwl.zshop.pojo.Customer;
import com.lwl.zshop.pojo.Role;
import com.lwl.zshop.service.CustomerService;
import com.lwl.zshop.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;

/**
 * created by luweiliang on 2019/6/6
 */
@Controller
@RequestMapping("/backend/customer")
public class CustomerController {

    @Autowired
    CustomerService customerService;

    @RequestMapping("/findAll")
    public String findAll(Integer pageNum, Model model,Customer customer){
        if(ObjectUtils.isEmpty(pageNum)){
            pageNum = PaginationConstant.PAGE_NUM;
        }
        PageHelper.startPage(pageNum,PaginationConstant.FRONT_PAGE_SIZE);
        List<Customer> customers = customerService.findAllCustomer(customer);
        PageInfo<Customer> pageInfo = new PageInfo<Customer>(customers);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("customer",customer);
        return "customerManager";
    }

    @RequestMapping("/addCustomer")
    @ResponseBody
    public ResponseResult addCustomer(Customer customer){
        customer.setIsValid(CustomerConstant.CUSTOMER_VALID);
        customer.setRegistDate(new Date());
        customerService.addCustomer(customer);
        return ResponseResult.success();
    }

    @RequestMapping("/findCustomerById")
    @ResponseBody
    public ResponseResult findCustomerById(int id){
        Customer customer = customerService.findCustomerById(id);
        return ResponseResult.success(customer);
    }

    @RequestMapping("/modifyCustomer")
    @ResponseBody
    public ResponseResult modifyCustomer(Customer customer){
        customerService.modifyCustomer(customer);
        return ResponseResult.success();
    }

    @RequestMapping("/modifyStatus")
    @ResponseBody
    public ResponseResult modifyStatus(int id){
        customerService.modifyCustomerStatus(id);
        return ResponseResult.success();
    }
}
