package com.lwl.zshop.impl;

import com.lwl.zshop.common.constant.CustomerConstant;
import com.lwl.zshop.common.exception.CustomerLoginErrorException;
import com.lwl.zshop.common.exception.PhoneNotRegistException;
import com.lwl.zshop.dao.CustomerDao;
import com.lwl.zshop.pojo.Customer;
import com.lwl.zshop.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * created by luweiliang on 2019/6/8
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerDao customerDao;

    @Override
    public Customer login(String loginName, String password) throws CustomerLoginErrorException {
        Customer customer = customerDao.selectByLoginNameAndPassword(loginName,password,
                                                                     CustomerConstant.CUSTOMER_VALID);
        if(customer == null){
            throw new CustomerLoginErrorException("登录失败，请检查用户名或密码是否有误");
        }
        return customer;
    }

    @Override
    public Customer findCustomerByPhone(String phone) throws PhoneNotRegistException {
        Customer customer = customerDao.selectCustomerByPhone(phone);
        if(customer == null){
            throw  new PhoneNotRegistException("该手机号码尚未注册");
        }
        return customer;
    }

    @Override
    public void addCustomer(Customer customer) {
        customerDao.insertCustomer(customer);
    }

    @Override
    public List<Customer> findAllCustomer(Customer customer) {
        return customerDao.selectAllCustomer(customer);
    }

    @Override
    public Customer findCustomerById(int id) {
        Customer customer = customerDao.selectCustomerById(id);
        return customer;
    }

    @Override
    public void modifyCustomer(Customer customer) {
        customerDao.updateCustomer(customer);
    }

    @Override
    public void modifyCustomerStatus(int id) {
        Customer customer = customerDao.selectCustomerById(id);
        int isValid = 1;
        if(customer.getIsValid() == 1){
            isValid = 0;
        }
        customerDao.updateCustomerStatus(id,isValid);
    }
}
