package com.lwl.zshop.common.exception;

/**
 * created by luweiliang on 2019/5/30
 */
public class ProductTypeExistException extends Exception {
    public ProductTypeExistException() {
        super();
    }

    public ProductTypeExistException(String message) {
        super(message);
    }

    public ProductTypeExistException(String message, Throwable cause) {
        super(message, cause);
    }

    public ProductTypeExistException(Throwable cause) {
        super(cause);
    }
}
