package ${packageName}.common;

import lombok.Data;

@Data
public class Result<T> {

    private int code;
    private String msg;
    private T data;

    private Result(int code, String msg, T data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

   public static <T> Result<T> success(T data) {
        return new Result<>(ErrorCode.Success.code(), ErrorCode.Success.msg(), data);
    }

    public static <T> Result<T> success() {
        return new Result<>(ErrorCode.Success.code(), ErrorCode.Success.msg(), null);
    }

    public static <T> Result<T> error(int code, String msg) {
        return new Result<>(code, msg, null);
    }

    public static <T> Result<T> error(ErrorCode error) {
        return new Result<>(error.code(), error.msg(), null);
    }
}
