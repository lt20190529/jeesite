package com.thinkgem.jeesite.modules.note.mybatis;

import org.springframework.beans.factory.FactoryBean;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;

public class MapperFactoryBean<T> implements FactoryBean<T> {


    public MapperFactoryBean(Class<T> mapperInterface) {
        this.mapperinterface = mapperInterface;
    }


    private Class<T> mapperinterface;

   /* 通过继承FactoryBean，提供bean对象，也就是方法；T getObject()*/
    @Override
    public T getObject() throws Exception {
        InvocationHandler handler=(proxy, method, args) -> {
            Select select=method.getAnnotation(Select.class);
            System.out.println("SQL:{}"+select.value().replace("#{uid}",args[0].toString()));
            return args[0]+"  查询SQL语句";
        };
        return (T) Proxy.newProxyInstance(this.getClass().getClassLoader(), new Class[]{mapperinterface}, handler);

    }

    @Override
    public Class<?> getObjectType() {
        return mapperinterface;
    }

    @Override
    public boolean isSingleton() {
        return true;
    }
}
