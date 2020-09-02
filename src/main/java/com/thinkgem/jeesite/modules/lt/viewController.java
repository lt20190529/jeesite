package com.thinkgem.jeesite.modules.lt;

import org.springframework.web.bind.annotation.RequestMapping;

public class viewController {

    @RequestMapping("demo1")
    public String demo1(){
        System.out.println("执行Demo1");
        return "/index.jsp";

    }
}
