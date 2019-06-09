
import lombok.Data;

@Data
public class Result<T> {

    private Integer code;
    private String message;
    private T data;

    private Result(Integer code, String message, T data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }

    public static <T> Result<T> of() {
        return new Result<>(200, "SUCCESS", null);
    }

    public static <T> Result<T> of(T data) {
        return new Result<>(200, "SUCCESS", data);
    }

    public static <T> Result<T> of(Integer code, String message) {
        return new Result<>(code, message, null);
    }

    public static <T> Result<T> of(ErrorCode error) {
        return new Result<>(error.getCode(), error.getMessage(), null);
    }
}
