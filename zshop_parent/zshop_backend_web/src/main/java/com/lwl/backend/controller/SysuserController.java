package com.lwl.backend.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lwl.zshop.common.constant.PaginationConstant;
import com.lwl.zshop.common.exception.SysUserNotExistExcption;
import com.lwl.zshop.common.until.ResponseResult;
import com.lwl.zshop.params.SysUserParam;
import com.lwl.zshop.pojo.Role;
import com.lwl.zshop.pojo.SysUser;
import com.lwl.zshop.service.RoleService;
import com.lwl.zshop.service.SysUserService;
import com.lwl.zshop.vo.SysUserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * created by luweiliang on 2019/5/28
 */
@Controller
@RequestMapping("/backend/sysuser")
public class SysuserController {

    @Autowired
    private SysUserService sysUserService;

    @Autowired
    private RoleService roleService;

    @ModelAttribute("roles")
    public List<Role> loadAllRole(){
        List<Role> roles = roleService.findAll();
        return roles;
    }

    @RequestMapping("/login")
    public String login(String login_name, String password, HttpSession session,Model model){
        //实现登录功能
        try {
            SysUser sysUser = sysUserService.login(login_name,password);
            session.setAttribute("sysUser",sysUser);
            model.addAttribute("sysUser",sysUser);
            return "main";
        }catch (SysUserNotExistExcption e){
            model.addAttribute("errorMsg",e.getMessage());
            return "login";
        }
    }

    @RequestMapping("/findAll")
    public String findAll(Integer pageNum, Model model){
        //判断当前页码，如果为空默认设置为第一页
        if(ObjectUtils.isEmpty(pageNum)){
            pageNum = PaginationConstant.PAGE_NUM;
        }
        //使用MyBatis的分页插件PageHelper
        PageHelper.startPage(pageNum,PaginationConstant.PAGE_SIZE);
        List<SysUser> sysUsers = sysUserService.findAll();
        PageInfo<SysUser> pageInfo = new PageInfo<>(sysUsers);
        model.addAttribute("pageInfo",pageInfo);
        return "sysuserManager";
    }

    //根据查询条件查询
    @RequestMapping("/findSysUserByParams")
    public String findSysUserByParams(SysUserParam sysUserParam,Integer pageNum,Model model){
        if(ObjectUtils.isEmpty(pageNum)){
            pageNum = PaginationConstant.PAGE_NUM;
        }

        PageHelper.startPage(pageNum,PaginationConstant.PAGE_SIZE);

        List<SysUser> sysUsers = sysUserService.findSysUserByParams(sysUserParam);
        PageInfo<SysUser> pageInfo = new PageInfo<SysUser>(sysUsers);
        model.addAttribute("pageInfo",pageInfo);
        //实现数据回显，查询条件处显示已查询的条件信息
        model.addAttribute("sysUserParam",sysUserParam);
        return "sysuserManager";
    }

    @RequestMapping("/findSysUserById")
    @ResponseBody
    public ResponseResult findSysUserById(int id){
        SysUser sysUser = sysUserService.findSysUserById(id);
        return ResponseResult.success(sysUser);
    }

    @RequestMapping("addSysUser")
    @ResponseBody
    public ResponseResult addSysUser(SysUserVo sysUserVo){
        sysUserService.addSysUser(sysUserVo);
        return ResponseResult.success("添加成功");
    }

    @RequestMapping("/modifySysUser")
    @ResponseBody
    public ResponseResult modifySysUser(SysUserVo sysUserVo){

        sysUserService.modifySysUser(sysUserVo);
        return ResponseResult.success();
    }

    @RequestMapping("/modifyStatus")
    @ResponseBody
    public ResponseResult modifyStatus(int id){
        sysUserService.modifyStatus(id);
        return ResponseResult.success();
    }

    @RequestMapping("/exit")
    public String exit(HttpSession session,Model model){
        session.invalidate();
        model.addAttribute("successMsg","当前用户已成功退出");
        return "login";
    }
}
