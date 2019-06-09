
import lombok.AllArgsConstructor;

@AllArgsConstructor
public enum ErrorCode {

    // common
    UnknownError(500, "服务器未知错误"),
    Unauthorized(401, "没有登录"),
    Forbidden(403, "没有权限访问"),
    InvalidArgs(400, "非法的参数"),
    UserNotFound(400, "没有找到用户"),

    DBError(400, "数据库错误")

    private Integer code;
    private String message;

    public Integer getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }
}
