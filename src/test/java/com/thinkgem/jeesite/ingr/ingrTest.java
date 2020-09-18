package com.thinkgem.jeesite.ingr;

import com.thinkgem.jeesite.modules.ingr.dao.IngrDao;
import com.thinkgem.jeesite.modules.ingr.entity.Ingr;
import com.thinkgem.jeesite.modules.ingr.entity.IngrDetail;
import com.thinkgem.jeesite.modules.ingr.entity.VendorIngrInfo;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;


import java.io.IOException;
import java.io.InputStream;
import java.util.List;

public class ingrTest {

    SqlSessionFactory sqlSessionFactory =null;
    SqlSession SqlSession =null;

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

    /*
    一对一映射查询
    * */
    @Test
    public void test(){
        IngrDao ingrDao=SqlSession.getMapper(IngrDao.class);
        List<Ingr> ingrList=ingrDao.findIngrInfo();
        for(Ingr gg: ingrList){
            System.out.println(gg.toString());
        }

    }
    /*
    方式一：   一对多映射查询
     */
    @Test
    public void test1(){
        IngrDao ingrDao=SqlSession.getMapper(IngrDao.class);
        List<Ingr> ingrList=ingrDao.findIngrAndDetailInfo();
        for(Ingr tt: ingrList){
            System.out.println(tt.getNo()+"==="+tt.getIngrDetailList().size());
            for(IngrDetail a:tt.getIngrDetailList()){
                System.out.println(a.getItem().getItemDesc()+" "+a.getQty());
            }
        }
    }
    /*
    方式二：   一对多映射查询
     */
    @Test
    public void test2(){
        IngrDao ingrDao=SqlSession.getMapper(IngrDao.class);
        List<Ingr> ingrList=ingrDao.findIngrAndDetailInfoByExtends();
        for(Ingr tt: ingrList){
            System.out.println(tt.getNo()+"==="+tt.getIngrDetailList().size());
            for(IngrDetail a:tt.getIngrDetailList()){
                System.out.println(a.getItem().getItemDesc()+" "+a.getQty());
            }
        }
    }

    /*
    多对多查询：查询供货商下面的入库记录以及入库明细信息
     */
    @Test
    public void test3(){
        IngrDao ingrDao=SqlSession.getMapper(IngrDao.class);
        List<VendorIngrInfo> vendorList=ingrDao.VendorIngrAndDetailInfo();
        for(VendorIngrInfo vendor: vendorList){
            System.out.println(vendor.getVendorDesc()+"==="+vendor.getIngrList().size());
            for(Ingr ingr:vendor.getIngrList()){
                System.out.println(ingr.getNo()+" "+ingr.getAuditBy().getName()+" "+ ingr.getIngrDetailList().size());
                for(IngrDetail detail:ingr.getIngrDetailList()){
                    System.out.println(detail.getItem().getItemDesc()+" "+detail.getQty());
                }
            }
        }
    }

}