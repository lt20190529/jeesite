package com.thinkgem.jeesite.test;

import com.thinkgem.jeesite.common.utils.Collections3;
import com.thinkgem.jeesite.modules.crm.system.role.entity.SysRole;
import org.junit.Test;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class test1 {

    @Test
    public void GetTest(){

        try {
            File file=new File("D:\\book\\15.Monring Winds晨风.mp3");
            FileInputStream stream=new FileInputStream(file);
            System.out.println("lenth:"+file.length());
            int size=(int)file.length();
            stream.skip(size-128);
            byte[] last128=new byte[128];
            stream.read(last128);
            String id3=new String(last128);
            String tag=id3.substring(0,3);
            System.out.println(tag.toString());
            if(tag.equals("TAG")){
                System.out.println("1:"+id3.substring(3,32));
                System.out.println("1:"+id3.substring(33,62));
                System.out.println("1:"+id3.substring(63,91));
                System.out.println("1:"+id3.substring(93,97));

            }else{
                System.out.println("不包含TAG INFO");
            }
            stream.close();
        }catch(IOException e){
                System.out.println(e.toString());
        }
    }

    @Test
    public void GetListdiff(){
        List<String> list = new ArrayList<String>();
        List<String> list1 = new ArrayList<String>();
        List<String> list2 = new ArrayList<String>();
        List<String> list3 = new ArrayList<String>();
        List<String> list4 = new ArrayList<String>();
        list.add("xxx");
        list.add("yyy");
        list.add("zzz");
        list1.add("xxx");
        list1.add("ppp");
        list1.add("gggg");

        //list有，list1没有的
        list2= Collections3.intersectiondif(list,list1);
        System.out.println(list2.toString());
        //list没有，list1有的
        list3= Collections3.intersectiondiff(list,list1);
        System.out.println(list3.toString());

        //list，list1合集
        list4= Collections3.union(list,list1);
        System.out.println(list4.toString());

        //获取最后一个元

        System.out.println(Collections3.getLast(list4).toString());

        System.out.println(Collections3.convertToString(list1,"前缀","后缀"));
    }

    @Test
    public void GetMaxNum(){
        int data[] = new int[5]; /*开辟了一个长度为3的数组*/
        data[0] = 15; // 第一个元素
        data[1] = 30; // 第二个元素
        data[2] = 20; // 第三
        data[3] = 40; // 第三
        data[4] = 10; // 第三
        for(int i=0;i<data.length;i++){
           for(int j=0;j<data.length-i-1;j++){
               if (data[j]>data[j+1]){
                   int tmp;
                   tmp=data[j+1];
                   data[j+1]=data[j];
                   data[j]=tmp;
               }
           }

        }

        for(int m=0;m<data.length;m++){
            System.out.println(data[m]);
        }
    }
}
