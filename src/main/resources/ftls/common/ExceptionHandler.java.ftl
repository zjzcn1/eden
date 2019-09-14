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
        log.error("[业务异常] code={}, msg={}", e.code(), e.msg(), e);
        return Result.error(e.code(), e.msg());
    }

    @org.springframework.web.bind.annotation.ExceptionHandler(Exception.class)
    @ResponseBody
    public Result<?> handle(Exception e){
        log.error("[系统异常]", e);
        return Result.error(ErrorCode.SystemError);
    }
}