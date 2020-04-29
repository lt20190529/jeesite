package com.thinkgem.jeesite.basicsJava.Serializable;

import java.io.Serializable;


public class Person implements Serializable {

    private  int age;
    private String name;

    /*
    * 非静态数据不想被序列化可以使用transien修饰
    * int 返回0  String Null
    * Transient 关键字的作用是控制变量的序列化，
    * 在变量声明前加上该关键字，可以阻止该变量被序列化到文件中，
    * 在被反序列化后，transient 变量的值被设为初始值，如 int 型的是 0，对象型的是 null。
    */
    private transient String sex;


    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }
}
