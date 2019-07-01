package com.lwl.zshop.common.until;

import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * created by luweiliang on 2019/6/9
 * HttpClient工具类
 */
public class HttpClientUtils {
    /**
     * 执行post请求
     */
    public static String doPost(String url, Map<String,String> params){
        //创建httpClient
        CloseableHttpClient httpClient = HttpClients.createDefault();
        String result="";
        CloseableHttpResponse httpResponse = null;

        try {
            //构建请求
            HttpPost httpPost = new HttpPost(url);

            //构建参数
            if(params != null){
                List<NameValuePair> paramsList = new ArrayList<NameValuePair>();
                for(String key : params.keySet()){
                    paramsList.add(new BasicNameValuePair(key,params.get(key)));
                }
                //模拟form表单entity
                HttpEntity formeEntity = new UrlEncodedFormEntity(paramsList, Charset.defaultCharset()); //使用默认字符集
                httpPost.setEntity(formeEntity);
            }

            //执行
            httpResponse = httpClient.execute(httpPost);
            //获取服务器返回的结果
            result = EntityUtils.toString(httpResponse.getEntity(),Charset.defaultCharset());

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
