package ${packageName}.common;

/**
 * *****************************************************
 * 外部接口定义：
 * 0为请求成功
 * 1-99为平台错误
 * 100以上为业务错误
 *
 * 例子：
 * 代码	描述信息	                     建议处理方式
 * 0	成功
 * 1	系统错误	                     三次重试，每次间隔10S
 * 2	缺少系统参数
 * 3	缺少参数，数据不完整
 * 4	参数格式错误
 * 5	app_key不存在或合作方不合作
 * 6	签名验证错误
 * 7	没有权限操作这条数据	         检查是否正式账号操作测试账号数据或测试账号操作正式账号数据
 * 8	api版本号不支持
 * 9	请求时间超出最大时限	         检查入参的timestamp
 * 10	接口流控	                     三次重试，每次间隔10S
 *
 * *****************************************************
 * 业务系统接口定义：
 * 200   为请求成功
 * 401   没有登录
 * 403   没有权限
 * 400   业务异常
 * 500   系统错误
 */

public enum ErrorCode {

    SUCCESS(200, "成功"),
    UNAUTHORIZED(401, "没有登录"),
    FORBIDDEN(403, "没有权限"),
    BUSINESS_ERROR(400, "业务异常"),
    SYSTEM_ERROR(500, "系统错误");

    private int code;
    private String message;

    ErrorCode(int code, String message) {
        this.code = code;
        this.message = message;
    }

    public int code() {
        return code;
    }

    public String message() {
        return message;
    }

}