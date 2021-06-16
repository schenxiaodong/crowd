package com.atguigu.crowd.exception;

/**
 * 新增或更新Admin时如果检测到登录账号重复，抛出这个异常
 */
public class LoginAccountAlreadyInUseForUpdateException extends RuntimeException{
    private static final long serialVersionUID = 1;
    public LoginAccountAlreadyInUseForUpdateException() {
    }

    public LoginAccountAlreadyInUseForUpdateException(String message) {
        super(message);
    }

    public LoginAccountAlreadyInUseForUpdateException(String message, Throwable cause) {
        super(message, cause);
    }

    public LoginAccountAlreadyInUseForUpdateException(Throwable cause) {
        super(cause);
    }

    public LoginAccountAlreadyInUseForUpdateException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
