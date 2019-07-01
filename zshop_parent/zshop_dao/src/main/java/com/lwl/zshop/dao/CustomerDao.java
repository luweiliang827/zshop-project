package com.lwl.zshop.dao;

import com.lwl.zshop.pojo.Customer;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * created by luweiliang on 2019/6/8
 */
public interface CustomerDao {

    public Customer selectByLoginNameAndPassword(@Param("loginName") String loginName,@Param("password") String password,@Param("isValid") Integer isValid);

    public Customer selectCustomerByPhone(@Param("phone") String phone);

    public void insertCustomer(Customer customer);

    public List<Customer> selectAllCustomer(Customer customer);

    public Customer selectCustomerById(@Param("id") int id);

    public void updateCustomer(Customer customer);

    public void updateCustomerStatus(@Param("id") int id,@Param("isValid") int isValid);
}
