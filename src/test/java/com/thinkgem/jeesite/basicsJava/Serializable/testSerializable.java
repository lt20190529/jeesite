package com.thinkgem.jeesite.basicsJava.Serializable;

import com.itextpdf.text.pdf.codec.Base64;
import org.junit.Test;

import java.io.*;
import java.text.MessageFormat;

         /*把对象转换为字节序列的过程称为对象的序列化。
        　　把字节序列恢复为对象的过程称为对象的反序列化。
        　　对象的序列化主要有两种用途：
        　　1） 把对象的字节序列永久地保存到硬盘上，通常存放在一个文件中；
        　　2） 在网络上传送对象的字节序列。

        　　在很多应用中，需要对某些对象进行序列化，让它们离开内存空间，入住物理硬盘，以便长期保存。比如最常见的是Web服务器中的Session对象，当有 10万用户并发访问，就有可能出现10万个Session对象，内存可能吃不消，于是Web容器就会把一些seesion先序列化到硬盘中，等要用了，再把保存在硬盘中的对象还原到内存中。

        　　当两个进程在进行远程通信时，彼此可以发送各种类型的数据。无论是何种类型的数据，都会以二进制序列的形式在网络上传送。发送方需要把这个Java对象转换为字节序列，才能在网络上传送；接收方则需要把字节序列再恢复为Java对象。

        二、JDK类库中的序列化API
        　　java.io.ObjectOutputStream代表对象输出流，它的writeObject(Object obj)方法可对参数指定的obj对象进行序列化，把得到的字节序列写到一个目标输出流中。
        　　java.io.ObjectInputStream代表对象输入流，它的readObject()方法从一个源输入流中读取字节序列，再把它们反序列化为一个对象，并将其返回。
        　　只有实现了Serializable和Externalizable接口的类的对象才能被序列化。Externalizable接口继承自 Serializable接口，实现Externalizable接口的类完全由自身来控制序列化的行为，而仅实现Serializable接口的类可以 采用默认的序列化方式 。
        　　对象序列化包括如下步骤：
        　　1） 创建一个对象输出流，它可以包装一个其他类型的目标输出流，如文件输出流；
        　　2） 通过对象输出流的writeObject()方法写对象。

        　　对象反序列化的步骤如下：
        　　1） 创建一个对象输入流，它可以包装一个其他类型的源输入流，如文件输入流；
        　　2） 通过对象输入流的readObject()方法读取对象。

        对象序列化和反序列范例：*/

public class testSerializable {

    @Test
    public void testSerializable() throws IOException, ClassNotFoundException {
        personSerializable();
        Person p=DeserializePerson();
        System.out.println(MessageFormat.format("age={0},name={1},sex={2})",p.getAge(),p.getName(),p.getSex()));
    }
    public static void personSerializable() throws IOException {
        Person p=new Person();
        p.setAge(14);
        p.setName("Boss");
        p.setSex("man");
        ObjectOutputStream oo=new ObjectOutputStream(new FileOutputStream(new File("D:/Person.txt")));
        oo.writeObject(p);
        System.out.println("Serializable sucess!");
        oo.close();
    }

    public static Person DeserializePerson() throws IOException, ClassNotFoundException {
        ObjectInputStream ois=new ObjectInputStream(new FileInputStream("D:/Person.txt"));
        Person p= (Person) ois.readObject();
        System.out.println("DeserializePerson sucess!");
        return p;
    }
}