package com.github.zjzcn.test.common;

public enum ErrorCode {

    OK(0, "SUCCESS"),
    UnknownError(500, "服务器未知错误"),
    Unauthorized(401, "没有登录"),
    Forbidden(403, "没有权限访问"),
    InvalidArgs(400, "非法的参数"),
    UserNotFound(400, "没有找到用户");

    private int code;
    private String msg;

    ErrorCode(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public int code() {
        return code;
    }

    public String msg() {
        return msg;
    }


}
