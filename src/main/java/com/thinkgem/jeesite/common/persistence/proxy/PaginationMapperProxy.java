/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.common.persistence.proxy;

import org.apache.ibatis.binding.BindingException;
import org.apache.ibatis.binding.MapperMethod;
import org.apache.ibatis.session.SqlSession;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.Reflections;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.HashSet;
import java.util.Set;

/**
 * <p>
 * .
 * </p>
 *
 * @author poplar.yfyang
 * @version 1.0 2012-05-13 上午10:07
 * @since JDK 1.5
 */
/*
   现在要生成某一个对象的代理对象，这个代理对象通常也要编写一个类来生成，所以首先要编写用于生成代理对象的类。
   在java中如何用程序去生成一个对象的代理对象呢，java在JDK1.5之后提供了一个"java.lang.reflect.Proxy"类，
   通过"Proxy"类提供的一个newProxyInstance方法用来创建一个对象的代理对象，如下所示：

   1 static Object newProxyInstance(ClassLoader loader, Class<?>[] interfaces, InvocationHandler h)
　　newProxyInstance方法用来返回一个代理对象，
   这个方法总共有3个参数:
   ClassLoader loader用来指明生成代理对象使用哪个类装载器，
   Class<?>[] interfaces用来指明生成哪个对象的代理对象，通过接口指定，
   InvocationHandler h用来指明产生的这个代理对象要做什么事情。

   所以我们只需要调用newProxyInstance方法就可以得到某一个对象的代理对象了。

　　在java中规定，要想产生一个对象的代理对象，那么这个对象必须要有一个接口，所以我们第一步就是设计这个对象的接口，在接口中定义这个对象所具有的行为(方法)
 */
public class PaginationMapperProxy implements InvocationHandler {


    private static final Set<String> OBJECT_METHODS = new HashSet<String>() {
        private static final long serialVersionUID = -1782950882770203583L;
        {
            add("toString");
            add("getClass");
            add("hashCode");
            add("equals");
            add("wait");
            add("notify");
            add("notifyAll");
        }
    };

    private boolean isObjectMethod(Method method) {
        return OBJECT_METHODS.contains(method.getName());
    }

    private final SqlSession sqlSession;

    private PaginationMapperProxy(final SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args)
            throws Throwable {
        if (isObjectMethod(method)) {
            return null;
        }
        final Class<?> declaringInterface = findDeclaringInterface(proxy, method);
        if (Page.class.isAssignableFrom(method.getReturnType())) {
            // 分页处理
            return new PaginationMapperMethod(declaringInterface, method, sqlSession).execute(args);
        }
        // 原处理方式
        final MapperMethod mapperMethod = new MapperMethod(declaringInterface, method, sqlSession.getConfiguration());
        final Object result = mapperMethod.execute(sqlSession, args);
        if (result == null && method.getReturnType().isPrimitive()) {
            throw new BindingException(
                    "Mapper method '"
                            + method.getName()
                            + "' ("
                            + method.getDeclaringClass()
                            + ") attempted to return null from a method with a primitive return type ("
                            + method.getReturnType() + ").");
        }
        return result;
    }

    private Class<?> findDeclaringInterface(Object proxy, Method method) {
        Class<?> declaringInterface = null;
        for (Class<?> mapperFaces : proxy.getClass().getInterfaces()) {
            Method m = Reflections.getAccessibleMethod(mapperFaces,
                    method.getName(),
                    method.getParameterTypes());
            if (m != null) {
                declaringInterface = mapperFaces;
            }
        }
        if (declaringInterface == null) {
            throw new BindingException(
                    "Could not find interface with the given method " + method);
        }
        return declaringInterface;
    }

    @SuppressWarnings("unchecked")
    public static <T> T newMapperProxy(Class<T> mapperInterface, SqlSession sqlSession) {
        ClassLoader classLoader = mapperInterface.getClassLoader();
        Class<?>[] interfaces = new Class[]{mapperInterface};
        PaginationMapperProxy proxy = new PaginationMapperProxy(sqlSession);
        return (T) Proxy.newProxyInstance(classLoader, interfaces, proxy);
    }
}
