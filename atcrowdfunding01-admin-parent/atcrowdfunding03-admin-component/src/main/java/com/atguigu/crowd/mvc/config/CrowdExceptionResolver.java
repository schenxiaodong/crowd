package com.atguigu.crowd.mvc.config;

import com.atguigu.crowd.constant.CrowdConstant;
import com.atguigu.crowd.exception.AccessForbiddenException;
import com.atguigu.crowd.exception.LoginAccountAlreadyInUseException;
import com.atguigu.crowd.exception.LoginAccountAlreadyInUseForUpdateException;
import com.atguigu.crowd.exception.LoginFailedException;
import com.atguigu.crowd.util.CrowdUtil;
import com.atguigu.crowd.util.ResultEntity;
import com.google.gson.Gson;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


// ControllerAdvice 表示当前类是一个具体的异常类型和一个方法关联起来
@ControllerAdvice
public class CrowdExceptionResolver {


    @ExceptionHandler(value = AccessForbiddenException.class)
    public ModelAndView resolveAccessForbiddenException(AccessForbiddenException exception, HttpServletRequest request, HttpServletResponse response) throws IOException {

        String viewName = "admin-login";
        // 返回ModelAndView对象
        return commonResolve(viewName,exception,request,response);
    }

    @ExceptionHandler(value = LoginAccountAlreadyInUseForUpdateException.class)
    public ModelAndView resolveLoginAccountAlreadyInUseForUpdateException(LoginAccountAlreadyInUseForUpdateException exception, HttpServletRequest request, HttpServletResponse response) throws IOException {

        String viewName = "system-error";
        // 返回ModelAndView对象
        return commonResolve(viewName,exception,request,response);
    }

    // 违反唯一约束
    @ExceptionHandler(value = LoginAccountAlreadyInUseException.class)
    public ModelAndView resolveLoginAccountAlreadyInUseException(LoginAccountAlreadyInUseException exception, HttpServletRequest request, HttpServletResponse response) throws IOException {

        String viewName = "admin-add";
        // 返回ModelAndView对象
        return commonResolve(viewName,exception,request,response);
    }


    /** ExceptionHandler 将一个具体的异常类型和一个方法关联起来
     * @param exception 实际捕获到的异常类型
     * @param request   当前请求对象
     * @return
     */
    @ExceptionHandler(value = NullPointerException.class)
    public ModelAndView resolveNullPointException(NullPointerException exception, HttpServletRequest request, HttpServletResponse response) throws IOException {

        String viewName = "system-error";
        // 返回ModelAndView对象
        return commonResolve(viewName,exception,request,response);
    }


    /** ExceptionHandler 将一个具体的异常类型和一个方法关联起来
     * @param exception 实际捕获到的异常类型
     * @param request   当前请求对象
     * @return
     */
    @ExceptionHandler(value = LoginFailedException.class)
    public ModelAndView resolveLoginFailedException(LoginFailedException exception, HttpServletRequest request, HttpServletResponse response) throws IOException {

        String viewName = "admin-login";
        // 返回ModelAndView对象
        return commonResolve(viewName,exception,request,response);
    }



    private ModelAndView commonResolve(String viewName, Exception exception, HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 判断当前请求类型
        boolean judgeResult = CrowdUtil.judgeRequestType(request);

        // 如果是Ajax请求
        if(judgeResult) {
            // 创建ResultEntity对象
            ResultEntity<Object> resultEntity = ResultEntity.failed(exception.getMessage());

            // 创建Gson对象
            Gson gson = new Gson();

            // 将ResultEntity对象转换为JSON字符串
            String json = gson.toJson(resultEntity);

            // 将JSON字符串作为响应体返回给浏览器
            response.getWriter().write(json);

            // 由于上面已经通过原生的response对象返回了响应，所以不提供ModelAndView对象
            return null;
        }

        // 如果不是Ajax请求，则先创建ModelAndView对象
        ModelAndView modelAndView = new ModelAndView();

        // 将Exception对象存入模型
        modelAndView.addObject(CrowdConstant.ATTR_NAME_EXCEPTION,exception);

        // 设置对应的视图
        modelAndView.setViewName(viewName);

        // 返回ModelAndView对象
        return modelAndView;
    }

}
