package ${packageName}.common;


public class ServiceException extends RuntimeException {

    private int code;
    private String message;

    private ServiceException(int code, String message) {
        super(message);
        this.code = code;
        this.message = message;
    }

    public static ServiceException of(int code, String message) {
        return new ServiceException(code, message);
    }

    public int code() {
        return code;
    }

    public String message() {
        return message;
    }
}
