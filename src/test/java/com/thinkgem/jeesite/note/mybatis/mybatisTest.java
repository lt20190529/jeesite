package com.thinkgem.jeesite.note.mybatis;

import com.thinkgem.jeesite.modules.note.mybatis.ICustomerDao;
import org.junit.Test;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;

public class mybatisTest {

    @Test
    public void mybatisTest(){
        BeanFactory beanFactory=new ClassPathXmlApplicationContext("spring-config.xml");
        ICustomerDao iCustomerDao=  beanFactory.getBean("customerDao",ICustomerDao.class);
        String s=iCustomerDao.QueryCustomer("1");
        System.out.println(s.toString());
    }

    @Test
    public void test2(){
        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        Class<?>[] classes = {ICustomerDao.class};
        InvocationHandler handler = (proxy, method, args) -> "你被代理了 " + method.getName();
        ICustomerDao iCustomerDao = (ICustomerDao) Proxy.newProxyInstance(classLoader, classes, handler);
        String res = iCustomerDao.QueryCustomer("1");
        System.out.println("测试结果：{}"+res);
    }
}
