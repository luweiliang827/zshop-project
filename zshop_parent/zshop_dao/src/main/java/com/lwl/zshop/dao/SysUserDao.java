package com.lwl.zshop.dao;

import com.lwl.zshop.params.SysUserParam;
import com.lwl.zshop.pojo.SysUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * created by luweiliang on 2019/6/3
 */
public interface SysUserDao {

    public List<SysUser> selectAll();

    public SysUser selectSysUserById(int id);

    public void insert(SysUser sysUser);

    public void update(SysUser sysUser);

    public void updateStatus(@Param("id") int id, @Param("isValid") int isValid);

    public List<SysUser> selectSysUserByParams(SysUserParam sysUserParam);

    public SysUser selectLoginNameAndPassword(@Param("login_name") String login_name,@Param("password") String password,@Param("isValid") int isValid);
}
