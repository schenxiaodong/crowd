package com.atguigu.crowd.mvc.handler;


import com.atguigu.crowd.entity.Role;
import com.atguigu.crowd.service.api.RoleService;
import com.atguigu.crowd.util.ResultEntity;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class RoleHandler {

    @Autowired
    private RoleService roleService;

    @ResponseBody
    @RequestMapping("/role/get/page/info.json")
    public ResultEntity<PageInfo<Role>> getPageInfo(
            @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
            @RequestParam(value = "pageSize",defaultValue = "5") Integer pageSize,
            @RequestParam(value = "keyword", defaultValue = "") String keyword
        ) {

        // 调用Service方法获取分页数据
        PageInfo<Role> pageInfo = pageInfo = roleService.getPageInfo(pageNum, pageSize, keyword);;

        // 封装到ResultEntity对象中返回（如果上面的代码抛出异常，交给异常映射机制来处理） SpringMVC自带了异常映射
        return ResultEntity.successWithData(pageInfo);
    }




}