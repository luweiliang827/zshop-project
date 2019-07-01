package com.lwl.zshop.pojo;

import java.io.Serializable;

/**
 * created by luweiliang on 2019/6/3
 */
public class Role implements Serializable {

    private Integer id;
    private String roleName;

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}
