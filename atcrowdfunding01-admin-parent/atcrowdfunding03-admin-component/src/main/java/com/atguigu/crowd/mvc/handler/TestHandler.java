package com.atguigu.crowd.mvc.handler;


import com.atguigu.crowd.entity.Admin;
import com.atguigu.crowd.entity.ParamData;
import com.atguigu.crowd.entity.Student;
import com.atguigu.crowd.service.api.AdminService;
import com.atguigu.crowd.util.ResultEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Arrays;
import java.util.List;

@Controller
public class TestHandler {

    @Autowired
    private AdminService adminService;

    private Logger logger = LoggerFactory.getLogger(TestHandler.class);

    @ResponseBody
    @RequestMapping("/test/ajax/async.html")
    public String testAsync() throws InterruptedException {

        Thread.sleep(2000);
        return "success";
    }


    @RequestMapping("/test/ssm.html")
    public String testSSM(ModelMap modelMap) {
        List<Admin> adminList = adminService.getAll();
        modelMap.addAttribute("adminList",adminList);
//        System.out.println(1/0);
        String a = null;
        System.out.println(a.length());
        return "target";
    }

    @RequestMapping("/send/array/one.html")
    @ResponseBody
    public String testReceiveArrayOne(@RequestParam("array[]") List<Integer> array) {
        for(Integer integer: array) {
            System.out.println("integer=" + integer);
        }
        return "success";
    }

    @RequestMapping("/send/array/two.html")
    @ResponseBody
    public String testReceiveArrayTwo(ParamData paramData) {

        List<Integer> array = paramData.getArray();

        for(Integer integer: array) {
            System.out.println("integer=" + integer);
        }
        return "success";
    }

    @RequestMapping("/send/array/three.html")
    @ResponseBody
    public String testReceiveArrayThree(@RequestBody List<Integer> array) {

        for(Integer integer: array) {
            logger.info("integer=" + integer);
        }
        return "success";
    }

    @RequestMapping("/send/complex/object.json")
    @ResponseBody
    public ResultEntity<Student> sendComplexObject(@RequestBody Student student) {
        logger.info(student.toString());
        return ResultEntity.successWithData(student);
    }



}
