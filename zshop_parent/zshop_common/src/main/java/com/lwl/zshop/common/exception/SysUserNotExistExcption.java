package com.lwl.zshop.common.exception;

/**
 * created by luweiliang on 2019/6/6
 */
public class SysUserNotExistExcption extends Exception{
    public SysUserNotExistExcption() {
        super();
    }

    public SysUserNotExistExcption(String message) {
        super(message);
    }

    public SysUserNotExistExcption(String message, Throwable cause) {
        super(message, cause);
    }

    public SysUserNotExistExcption(Throwable cause) {
        super(cause);
    }
}
