package ${packageName}.common;


public class ServiceException extends RuntimeException {

    private int code;
    private String message;

    public ServiceException(int code, String message, Object... args) {
        super(message);
        this.code = code;
        this.message = MessageFormatter.format(message, args).getMessage();
    }

    public int code() {
        return code;
    }

    public String message() {
        return message;
    }
}
