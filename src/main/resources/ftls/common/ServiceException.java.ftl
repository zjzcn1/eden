package com.github.springboot.demo.common;


public class ServiceException extends RuntimeException {

    private int code;

    private String msg;

    private ServiceException(int code, String msg) {
        super(msg);
        this.code = code;
        this.msg = msg;
    }

    public static ServiceException of(int code, String msg) {
        return new ServiceException(code, msg);
    }

    public int code() {
        return code;
    }

    public String msg() {
        return msg;
    }
}
