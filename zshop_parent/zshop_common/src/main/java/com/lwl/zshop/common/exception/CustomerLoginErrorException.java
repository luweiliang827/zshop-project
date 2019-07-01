package com.lwl.zshop.common.exception;

/**
 * created by luweiliang on 2019/6/8
 */
public class CustomerLoginErrorException extends Exception {
    public CustomerLoginErrorException() {
        super();
    }

    public CustomerLoginErrorException(String message) {
        super(message);
    }

    public CustomerLoginErrorException(String message, Throwable cause) {
        super(message, cause);
    }

    public CustomerLoginErrorException(Throwable cause) {
        super(cause);
    }
}
