package com.thinkgem.jeesite.test;

import com.thinkgem.jeesite.modules.customer.service.CustomerService;
import com.thinkgem.jeesite.modules.test.entity.Customer;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

public class SqlTest {
    SqlSessionFactory sqlSessionFactory =null;
    org.apache.ibatis.session.SqlSession SqlSession =null;

    @Before
    public void init() throws IOException {
        InputStream inputStream = Resources.getResourceAsStream("mybatis-confignew.xml");
        sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        SqlSession=sqlSessionFactory.openSession();
    }
    @After
    public void destory(){
        this.SqlSession.close();
    }

    @Test
    public void test1(){
        Customer customer=new Customer();
        customer.setUsername("il");
        List<Customer> customerList=SqlSession.selectList("com.thinkgem.jeesite.modules.test.dao.CustomerDaoa.findCustomer",customer);
        for(Customer c:customerList){
            System.out.println(c.toString());
        }
    }

    @Test
    public void test2() {
        Customer customer=new Customer();
        customer.setJobs("工人");
        List<Customer> customerList=SqlSession.selectList(
                "com.thinkgem.jeesite.modules.test.dao.CustomerDaoa.findCustomerByChoose",customer);
        for(Customer c:customerList){
            System.out.println(c.toString());
        }
    }
    /*使用where替代where1=1
     */
    @Test
    public void test3(){
        Customer customer=new Customer();
        customer.setUsername("i");
        List<Customer> customerList=SqlSession.selectList(
                "com.thinkgem.jeesite.modules.test.dao.CustomerDaoa.findCustomerByWhere",customer);
        for(Customer c:customerList){
            System.out.println(c.toString());
        }
    }
    /*
    使用trim
     */
    @Test
    public void test4(){
        Customer customer=new Customer();
        //customer.setUsername("li");
        List<Customer> customerList=SqlSession.selectList(
                "com.thinkgem.jeesite.modules.test.dao.CustomerDaoa.findCustomerByTrim",customer);
        for(Customer c:customerList){
            System.out.println(c.toString());
        }
    }

    /*set 更新字段使用
     */
    @Test
    public void test5(){
        Customer customer=new Customer();
        customer.setId(1);
        customer.setJobs("老师");
        customer.setUsername("liulei");
        customer.setPhone("123234");
        List<Customer> customerList=SqlSession.selectList(
                "com.thinkgem.jeesite.modules.test.dao.CustomerDaoa.updateCustomerById",customer);
        for(Customer c:customerList){
            System.out.println(c.toString());
        }
    }
    @Test
    public void test6(){
        for(int i=1;i<=100000;i++){
            Customer customer=new Customer();
            customer.setJobs("老师");
            customer.setUsername("liulei"+i);
            customer.setAddress("陕西");
            customer.setPhone("1"+i);
            List<Customer> customerList=SqlSession.selectList(
                    "com.thinkgem.jeesite.modules.test.dao.CustomerDaoa.insert",customer);
            for(Customer c:customerList){
                System.out.println(c.toString());
            }
        }

    }

    /*foreach使用*/
    @Test
    public void test7(){
        List<String> phones=new ArrayList<>();
        phones.add("11");
        phones.add("12");
        phones.add("13");
        phones.add("14");
        phones.add("15");
        List<Customer> customerList=SqlSession.selectList(
                "com.thinkgem.jeesite.modules.test.dao.CustomerDaoa.findCustomerByForeach",phones);
        for(Customer c:customerList){
            System.out.println(c.toString());
        }
    }

    @Test
    public void test8(){
        Customer cu=new Customer();
        cu.setUsername("liulei");
        List<Customer> customerList=SqlSession.selectList(
                "com.thinkgem.jeesite.modules.test.dao.CustomerDaoa.findCustomerByUsername",cu);
        for(Customer c:customerList){
            System.out.println(c.toString());
        }
    }

    /*事务测试*/
    @Test
    public void test9(){
        ApplicationContext applicationContext=new ClassPathXmlApplicationContext("spring-context.xml");
        CustomerService customerService=applicationContext.getBean(CustomerService.class);
        Customer cu=new Customer();
        cu.setUsername("Jack");
        cu.setAddress("陕西");
        cu.setJobs("技术员");
        cu.setPhone("3224334");
        customerService.insertCustomer(cu);

    }



}
