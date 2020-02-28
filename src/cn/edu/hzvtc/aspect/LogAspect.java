package cn.edu.hzvtc.aspect;

import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;


@Aspect
@Component
public class LogAspect {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Pointcut("execution(* cn.edu.hzvtc.service.*.*(..))")
    public void log() {}


    @Before("log()")
    public void doBefore(JoinPoint joinPoint) {
        /*ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = attributes.getRequest();*/
    	HttpServletRequest request = ServletActionContext.getRequest();
        String url = request.getRequestURL().toString();
        String ip = request.getRemoteAddr();
        
        String classMethod = joinPoint.getSignature().getDeclaringTypeName() + "." + joinPoint.getSignature().getName();
        Object[] args = joinPoint.getArgs();
        RequestLog requestLog = new RequestLog(url, ip, classMethod, args);
        logger.info("Request : {}", requestLog);
    }

    @After("log()")
    public void doAfter() {
//        logger.info("--------doAfter--------");
    }

    @AfterReturning(returning = "result",pointcut = "log()")
    public void doAfterRuturn(Object result) {
        logger.info("Result : {}", result);
    }

    private class RequestLog {
        private String url;
        private String ip;
        private String classMethod;
        private Object[] args;

        public RequestLog(String url, String ip, String classMethod, Object[] args) {
            this.url = url;
            this.ip = ip;
            this.classMethod = classMethod;
            this.args = args;
        }

        @Override
        public String toString() {
            return "{" +
                    "url='" + url + '\'' +
                    ", ip='" + ip + '\'' +
                    ", classMethod='" + classMethod + '\'' +
                    ", args=" + Arrays.toString(args) +
                    '}';
        }
    }

}
