package ${packageName}.common;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ResponseBody;

@Slf4j
@ControllerAdvice
public class ExceptionHandler {

    @org.springframework.web.bind.annotation.ExceptionHandler(ServiceException.class)
    @ResponseBody
    public Result<?> handle(ServiceException e){
        log.error("[业务异常] code={}, message={}: ", e.code(), e.message(), e);
        return Result.error(e.code(), e.message());
    }

    @org.springframework.web.bind.annotation.ExceptionHandler(Exception.class)
    @ResponseBody
    public Result<?> handle(Exception e){
        log.error("[系统异常]", e);
        return Result.error(ErrorCode.SYSTEM_ERROR);
    }
}