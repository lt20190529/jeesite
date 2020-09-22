package com.thinkgem.jeesite.modules.note.mybatis;

import java.lang.annotation.*;


/*模拟mybatis-spring中的自定义注解，用于使用在方法层面*/
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface Select {

    String value() default "";
}
