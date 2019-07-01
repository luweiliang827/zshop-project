package com.lwl.zshop.front.controller;

import com.lwl.zshop.common.until.HttpClientUtils;
import com.lwl.zshop.common.until.RedisUtils;
import com.lwl.zshop.common.until.ResponseResult;
import org.apache.http.impl.client.HttpClients;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

/**
 * created by luweiliang on 2019/6/9
 */
@Controller
@RequestMapping("/sms")
public class SmsController {
    @Value("${sms.url}")
    private String url;
    @Value("${sms.key}")
    private String key;
    @Value("${sms.tplId}")
    private String tplId;
    @Value("${sms.tplValue}")
    private String tplValue;

    @RequestMapping("/sendValidCode")
    @ResponseBody
    public ResponseResult sendValidCode(String phone, HttpSession session){
        try {
            //生成六位随机数
            Random random = new Random();
            int randomCode = random.nextInt(999999);
            session.setAttribute("randomCode",randomCode);

            //将验证码存放到Redis
            RedisUtils.set(session.getId(),randomCode+"",2*60);  //验证码有效期为两分钟

            //发送短信
            Map<String,String> params = new HashMap<>();
            params.put("mobile",phone);
            params.put("key",key);
            params.put("tpl_id",tplId);
            params.put("tpl_value",tplValue+randomCode);
            String result = HttpClientUtils.doPost(url,params);
            System.out.println(result);
            return ResponseResult.success("验证码发送成功");
        }catch (Exception e){
            e.printStackTrace();
            return ResponseResult.fail("验证码发送失败");
        }
    }
}
