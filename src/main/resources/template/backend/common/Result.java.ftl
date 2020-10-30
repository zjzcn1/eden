package ${packageName}.common;

import lombok.Data;


@Data
public class Result<T> {

    private int code;
    private String message;
    private T data;

    private Result(int code, String message, T data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }

   public static <T> Result<T> success(T data) {
        return new Result<>(ErrorCode.SUCCESS.code(), ErrorCode.SUCCESS.message(), data);
    }

    public static <T> Result<T> success() {
        return new Result<>(ErrorCode.SUCCESS.code(), ErrorCode.SUCCESS.message(), null);
    }

    public static <T> Result<T> error(int code, String msg) {
        return new Result<>(code, msg, null);
    }

    public static <T> Result<T> error(ErrorCode error) {
        return new Result<>(error.code(), error.message(), null);
    }
}