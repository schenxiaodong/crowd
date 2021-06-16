package com.atguigu.crowd.exception;

/**
 * 新增或更新Admin时如果检测到登录账号重复，抛出这个异常
 */
public class LoginAccountAlreadyInUseException extends RuntimeException{
    private static final long serialVersionUID = 1;
    public LoginAccountAlreadyInUseException() {
    }

    public LoginAccountAlreadyInUseException(String message) {
        super(message);
    }

    public LoginAccountAlreadyInUseException(String message, Throwable cause) {
        super(message, cause);
    }

    public LoginAccountAlreadyInUseException(Throwable cause) {
        super(cause);
    }

    public LoginAccountAlreadyInUseException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
