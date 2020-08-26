package com.thinkgem.jeesite.spring;

import org.apache.xmlbeans.impl.xb.xsdschema.Public;
import org.junit.Test;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;

public class springTest {

    @Test
    public void test(){
       /* ResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        Resource res = resolver.getResource("classpath:test.xml");
        BeanFactory factory = new XmlBeanFactory(res);
        Car car = factory.getBean("car1",Car.class);
        System.out.println("car对象已经初始化完成");
        System.out.println(car.getMaxSpeed());*/
    }
    @Test
    public void test1(){
       /* ApplicationContext ac=new ClassPathXmlApplicationContext("test.xml");
        Car car = ac.getBean("car1",Car.class);
        System.out.println("car对象已经初始化完成111");
        System.out.println(car.getMaxSpeed());*/

    }
}
