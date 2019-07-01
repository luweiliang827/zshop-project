package com.lwl.zshop.impl;

import com.lwl.zshop.common.constant.SysUserConstant;
import com.lwl.zshop.common.exception.SysUserNotExistExcption;
import com.lwl.zshop.dao.SysUserDao;
import com.lwl.zshop.params.SysUserParam;
import com.lwl.zshop.pojo.Role;
import com.lwl.zshop.pojo.SysUser;
import com.lwl.zshop.service.SysUserService;
import com.lwl.zshop.vo.SysUserVo;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.List;

/**
 * created by luweiliang on 2019/6/3
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
public class SysUserServiceImpl implements SysUserService {

    @Autowired
    private SysUserDao sysUserDao;

    @Override
    //配置事物，配置为只读
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public List<SysUser> findAll() {

        return sysUserDao.selectAll();
    }

    @Override
    public SysUser findSysUserById(int id) {

        return sysUserDao.selectSysUserById(id);
    }

    @Override
    public void addSysUser(SysUserVo sysUserVo) {
        SysUser sysUser = new SysUser();

        try {
            PropertyUtils.copyProperties(sysUser,sysUserVo);
            sysUser.setIsvalid(SysUserConstant.SYSUSER_VALID_ENABLE); //默认有效
            sysUser.setCreateDate(new Date());
            //角色ID
            Role role = new Role();
            role.setId(sysUserVo.getRoleId());
            sysUser.setRole(role);
            sysUserDao.insert(sysUser);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void modifySysUser(SysUserVo sysUserVo) {
        SysUser user = new SysUser();
        try {
            PropertyUtils.copyProperties(user,sysUserVo);
            //获取角色Id
            Role role = new Role();
            role.setId(sysUserVo.getRoleId());
            user.setRole(role);
            sysUserDao.update(user);
        } catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public void modifyStatus(int id) {

        SysUser sysUser = sysUserDao.selectSysUserById(id);
        int isValid = sysUser.getIsvalid();
        if(isValid == SysUserConstant.SYSUSER_VALID_DISABLE){
            isValid = SysUserConstant.SYSUSER_VALID_ENABLE;
        }else{
            isValid = SysUserConstant.SYSUSER_VALID_DISABLE;
        }
        sysUserDao.updateStatus(id,isValid);
    }

    @Override
    public List<SysUser> findSysUserByParams(SysUserParam sysUserParam) {

        return sysUserDao.selectSysUserByParams(sysUserParam);
    }

    @Override
    public SysUser login(String login_name, String password) throws SysUserNotExistExcption {
        SysUser sysUser=sysUserDao.selectLoginNameAndPassword(login_name,password,SysUserConstant.SYSUSER_VALID_ENABLE);
        if(sysUser != null){
            return sysUser;
        }
        throw new SysUserNotExistExcption("用户名或密码错误");
    }
}

