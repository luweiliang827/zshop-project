package com.lwl.zshop.common.until;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;

import java.io.IOException;
import java.io.InputStream;
import java.net.SocketException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.UUID;

/**
 * created by luweiliang on 2019/6/1
 */
public class StringUtils {

    //定义一个文件重命名的公共方法
    public static String renameFileName(String fileName){
        int dotIndex = fileName.lastIndexOf(".");  //获取最后一个点的位置
        //获取后缀
        String suffix = fileName.substring(dotIndex);
        //重命名
       return new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())+new Random().nextInt(1000)+suffix;
    }

    public static String FtpUpload(String hostname, String username, String password, String basePath, String targetPath,

                                   String suffix, InputStream inputStream)throws SocketException, IOException{
        //实例化FtpClient
        FTPClient ftpClient = new FTPClient();
        //连接FTP服务器
        ftpClient.connect(hostname);
        //设置用户名和密码
        ftpClient.login(username, password);
        //基本路径
        String[] pathArray = targetPath.split("/");
        for(String path:pathArray){
            basePath+="/"+path;
            //指定目录，返回Boolean类型，true标识目录存在
            Boolean dirExsists = ftpClient.changeWorkingDirectory(basePath);
            //如果目录不存在创建目录
            if(!dirExsists){
                //此方式每次只能创建一级目录
                ftpClient.makeDirectory(basePath);
            }
        }
        //重新指定文件上传的路径
        ftpClient.changeWorkingDirectory(basePath);
        //设置文件上传的方式
        ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
        //使用UUID保证文件名称的唯一性
        String uuid = UUID.randomUUID().toString();
        /**
         * 6.执行上传
         *  remote 上传服务后，文件的名称
         *  local 文件输入流
         *  上传文件时，如果已经存在同名文件，会被覆盖
         */
        ftpClient.storeFile(uuid+suffix,inputStream);
        //关闭资源
        ftpClient.logout();
        ftpClient.disconnect();

        StringBuilder builder = new StringBuilder();
        builder.append("ftp://");
        builder.append(hostname+"/");
        builder.append(targetPath+"/");
        builder.append(uuid+suffix);
        return builder.toString();

    }
}
