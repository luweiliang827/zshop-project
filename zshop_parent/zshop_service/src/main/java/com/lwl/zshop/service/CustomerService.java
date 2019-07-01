package com.lwl.zshop.service;

import com.lwl.zshop.common.exception.CustomerLoginErrorException;
import com.lwl.zshop.common.exception.PhoneNotRegistException;
import com.lwl.zshop.pojo.Customer;

import java.util.List;

/**
 * created by luweiliang on 2019/6/8
 */
public interface CustomerService {

    //登录
    public Customer login(String loginName,String password) throws CustomerLoginErrorException;

    /**
     * 短信验证登录时根据手机号查询
     * @param phone
     * @return
     * @throws PhoneNotRegistException
     */
    public Customer findCustomerByPhone(String phone) throws PhoneNotRegistException;

    /**
     * 添加客户信息
     * @param customer
     */
    public void addCustomer(Customer customer);

    /**
     * 查询所有的客户信息
     * @param customer
     * @return
     */
    public List<Customer> findAllCustomer(Customer customer);

    /**
     * 根据ID查询客户信息
     */
    public Customer findCustomerById(int id);

    /**
     * 修改客户信息
     * @param customer
     */
    public void modifyCustomer(Customer customer);

    /**
     * 修改客户状态
     */
    public void modifyCustomerStatus(int id);
}
