package com.lwl.zshop.front.controller;

import com.lwl.zshop.common.constant.ResponseStatusConstant;
import com.lwl.zshop.common.exception.CustomerLoginErrorException;
import com.lwl.zshop.common.exception.PhoneNotRegistException;
import com.lwl.zshop.common.until.RedisUtils;
import com.lwl.zshop.common.until.ResponseResult;
import com.lwl.zshop.pojo.Customer;
import com.lwl.zshop.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * created by luweiliang on 2019/6/8
 */
@Controller
@RequestMapping("/front/customer")
public class CustomerController {

    @Autowired
    private CustomerService customerService;


    @RequestMapping("loginByLoginName")
    @ResponseBody
    //根据用户名密码登录
    public ResponseResult loginByLoginName(String loginName, String password, HttpSession session){
        ResponseResult result = new ResponseResult();
        try {
            Customer customer = customerService.login(loginName,password);
            session.setAttribute("customer",customer);
            result.setData(customer);
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);
        } catch (CustomerLoginErrorException e) {
            //e.printStackTrace();
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_FAIL);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/logout")
    @ResponseBody
    public ResponseResult logout(HttpSession session){
        session.invalidate();
        return ResponseResult.success();
    }

    @RequestMapping("/loginBySms")
    @ResponseBody
    public ResponseResult loginBySms(String phone,int smsValidCode,HttpSession session){
        ResponseResult result = ResponseResult.fail();
        try {
            //判断手机号是否注册
            Customer customer = customerService.findCustomerByPhone(phone);

            //判断验证码是否存在
           // Object o = session.getAttribute("randomCode");
            //从Redis中获取验证码
            String str = RedisUtils.get(session.getId());
            if(!ObjectUtils.isEmpty(str)){
                //判断验证码是否正确
                Integer smsRandCode = Integer.parseInt(str);
                if(smsRandCode == smsValidCode){
                    session.setAttribute("customer",customer);
                    result.setData(customer);
                    result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);
                }else{
                    result.setMessage("验证码不正确");
                }
            }else{
                result.setMessage("验证码不存在或已经过期，请重新输入");
            }
        } catch (PhoneNotRegistException e) {
            //e.printStackTrace();
            result.setMessage(e.getMessage());
        }
        return result;
    }
}
