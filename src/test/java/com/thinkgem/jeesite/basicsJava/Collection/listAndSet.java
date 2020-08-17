package com.thinkgem.jeesite.basicsJava.Collection;


import org.junit.Test;

import java.util.*;


/*

   1 : List集合是有序集合，集合中的元素可以重复，访问集合中的元素可以根据元素的索引来访问。
   2: Set集合是无序集合，集合中的元素不可以重复，访问集合中的元素只能根据元素本身来访问（也是集合里元素不允许重复的原因）。
 */
public class listAndSet {

    /*
    分析：由于String类中重写了hashcode和equals方法，用来比较指向的字符串对象所存储的字符串是否相等。
    所以这里的第二个Hello是加不进去的。
     */
    @Test
    public void test1(){
        Set<String> set=new HashSet<String> ();
        set.add("hello");
        set.add("Java");
        set.add("hello");
        System.out.println("集合的大小："+set.size());
        System.out.println("集合中的元素："+set.toString());
    }
    /*
    说明：程序中，book集合两次添加的字符串对象明显不是一个对象（程序通过new关键字来创建字符串对象），
    当使用==运算符判断返回false，使用equals方法比较返回true，所以不能添加到Set集合中，最后只能输出一个元素。
     */
    @Test
    public void test2(){
        Set<String> set=new HashSet<String>();
        set.add(new String("中文的jdk"));
        boolean bb=set.add(new String("中文的jdk"));
        System.out.println(bb);
        System.out.println(set);
        System.out.println(new String("中文的jdk").equals(new String("中文的jdk")));
    }

    /*
     a: Iterator只能单向移动。
     b: Iterator.remove()是唯一安全的方式来在迭代过程中修改集合；如果在迭代过程中以任何其它的方式修改了基本集合将会产生未知的行为。
     而且每调用一次next()方法，remove()方法只能被调用一次，如果违反这个规则将抛出一个异常。
     */
    @Test
    public void test3(){
       ArrayList<String> aa=new ArrayList<String>();
        aa.add("aaa");
        aa.add("bbb");
        aa.add("ccc");
        System.out.println("before:"+aa);
        Iterator<String> it=aa.iterator();
        while(it.hasNext()){
            String t=it.next();
            if("bbb".equals(t)){
                it.remove();
            }
        }
        System.out.println("after"+aa);
    }

    /*

     */

    @Test
    public void test4() {
        ArrayList<String> a = new ArrayList<String>();
        a.add("aaa");
        a.add("bbb");
        a.add("ccc");
        System.out.println("Before iterate : " + a);
        ListIterator<String> it = a.listIterator();
        while (it.hasNext()) {
            System.out.print(it.next() + ", " + it.previousIndex() + ", " + it.nextIndex()+"    ");
        }
        while (it.hasPrevious()) {
            System.out.print(it.previous() + " ");
        }
        System.out.println();
        it = a.listIterator(1);
        while (it.hasNext()) {
            String t = it.next();
            System.out.println(t);
            if ("ccc".equals(t)) {
                it.set("nnn");
            } else {
                it.add("kkk");
            }
        }
        System.out.println("After iterate : " + a);
    }
    /*
    HashMap   LinkedHashMap TreeMap
     */
    @Test
    public void test5(){
        HashMap<String,String> hashMap=new HashMap<String, String>();
        hashMap.put("4","d");
        hashMap.put("3","c");
        hashMap.put("2","b");
        hashMap.put("1","a");
        Iterator<String> ithashMap=hashMap.keySet().iterator();
        System.out.println("hashMap---->");
        while(ithashMap.hasNext()){
            Object key1=ithashMap.next();
            System.out.println(key1+"       "+hashMap.get(key1));
        }

        LinkedHashMap<String,String> linkedHashMap=new LinkedHashMap<String, String>();
        linkedHashMap.put("4","d");
        linkedHashMap.put("3","c");
        linkedHashMap.put("2","b");
        linkedHashMap.put("1","a");
        Iterator<String> itlinkedHashMap=linkedHashMap.keySet().iterator();
        System.out.println("LinkedHashMap----->");
        while (itlinkedHashMap.hasNext()){
            Object key1=itlinkedHashMap.next();
            System.out.println(key1+"      "+linkedHashMap.get(key1));
        }

        TreeMap treeMap=new TreeMap();
        treeMap.put("4","d");
        treeMap.put("3","c");
        treeMap.put("2","b");
        treeMap.put("1","a");
        Iterator<String> ittreemap=treeMap.keySet().iterator();
        System.out.println("ittreemap----->");
        while (ittreemap.hasNext()){
            Object key1=ittreemap.next();
            System.out.println(key1+"      "+treeMap.get(key1));
        }

    }

    @Test
    public void test6(){
        HashSet<String> hs = new HashSet<String>();
        hs.add("B");
        hs.add("A");
        hs.add("D");
        hs.add("E");
        hs.add("C");
        hs.add("F");
        System.out.println("HashSet 顺序:\n"+hs);

        LinkedHashSet<String> lhs = new LinkedHashSet<String>();
        lhs.add("B");
        lhs.add("A");
        lhs.add("D");
        lhs.add("E");
        lhs.add("C");
        lhs.add("F");
        System.out.println("LinkedHashSet 顺序:\n"+lhs);

        TreeSet<String> ts = new TreeSet<String>();
        ts.add("B");
        ts.add("A");
        ts.add("D");
        ts.add("E");
        ts.add("C");
        ts.add("F");
        System.out.println("TreeSet 顺序:\n"+ts);
    }
    @Test
    public void test7(){
        List list=new ArrayList();
        double array[]= { 112, 111, 23, 456, 231 };
        for(int i=0;i<array.length;i++){
            list.add(new Double(array[i]));
        }
        Collections.sort(list);
        for(int i=0;i<array.length;i++){
            System.out.print(list.get(i)+" ");
        }
    }
}

