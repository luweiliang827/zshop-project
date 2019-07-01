package com.lwl.zshop.common.exception;

/**
 * created by luweiliang on 2019/6/9
 */
public class PhoneNotRegistException extends Exception {
    public PhoneNotRegistException() {
        super();
    }

    public PhoneNotRegistException(String message) {
        super(message);
    }

    public PhoneNotRegistException(String message, Throwable cause) {
        super(message, cause);
    }

    public PhoneNotRegistException(Throwable cause) {
        super(cause);
    }
}
