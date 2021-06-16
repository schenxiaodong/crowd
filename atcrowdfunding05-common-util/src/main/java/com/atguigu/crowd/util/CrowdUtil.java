package com.atguigu.crowd.util;

import com.atguigu.crowd.constant.CrowdConstant;

import javax.servlet.http.HttpServletRequest;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * 尚筹网项目通用的工具类
 */
public class CrowdUtil {


    /**
     * 判断当前请求是否为Ajax请求
     * @param request
     * @return
     *  true：当前请求是Ajax请求
     *  false：当前请求不是Ajax请求
     */
    public static boolean judgeRequestType(HttpServletRequest request) {

        // 1.获取请求消息头
        String acceptHeader = request.getHeader("Accept");
        String xRequestedWith = request.getHeader("X-Requested-With");

        return (
                (acceptHeader != null && acceptHeader.contains("application/json"))
                ||
                (xRequestedWith != null && xRequestedWith.equals("XMLHttpRequest")));
    }

    /**
     * 对明文字符串进行MD5加密
     * @param source 传入的明文
     * @return 加密结果
     */
    public static String md5(String source) {

        // 1.判断 source 是否是有效的字符串
        if (source == null || source.length() == 0) {
            // 2.如果不是有效字符串，抛出异常
            throw new RuntimeException(CrowdConstant.MESSAGE_STRING_INVALIDATE);
        }

        // 3.获取一个MessageDigest对象
        try {
            String algorithm = "md5";   // 算法为md5
            MessageDigest messageDigest = MessageDigest.getInstance(algorithm);

            // 4.获取明文字符串对应的字节数组
            byte[] input = source.getBytes();

            // 5.执行加密
            byte[] outbut = messageDigest.digest(input);

            // 6.创建BigInteger对象
            int signum = 1;
            BigInteger bigInteger = new BigInteger(signum, outbut);

            // 7.按照16进制将bigInteger的值转换为字符串
            int radix = 16;
            String encoded = bigInteger.toString(radix).toUpperCase();

            return encoded;

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }


        return null;
    }

}
