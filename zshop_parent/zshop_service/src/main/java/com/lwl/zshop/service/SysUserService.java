package com.lwl.zshop.service;

import com.lwl.zshop.common.exception.SysUserNotExistExcption;
import com.lwl.zshop.params.SysUserParam;
import com.lwl.zshop.pojo.SysUser;
import com.lwl.zshop.vo.SysUserVo;

import java.util.List;

/**
 * created by luweiliang on 2019/6/3
 */
public interface SysUserService {

    public List<SysUser> findAll();

    public SysUser findSysUserById(int id);

    public void addSysUser(SysUserVo sysUserVo);

    public void modifySysUser(SysUserVo sysUserVo);

    public void modifyStatus(int id);

    public List<SysUser> findSysUserByParams(SysUserParam sysUserParam);

    public SysUser login(String login_name,String password) throws SysUserNotExistExcption;
}
