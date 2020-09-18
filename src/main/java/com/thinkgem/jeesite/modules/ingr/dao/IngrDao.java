package com.thinkgem.jeesite.modules.ingr.dao;

import com.thinkgem.jeesite.modules.ingr.entity.Ingr;
import com.thinkgem.jeesite.modules.ingr.entity.VendorIngrInfo;

import java.util.List;

public interface IngrDao {

    List<Ingr> findIngrInfo();

    List<Ingr> findIngrAndDetailInfo();

    List<Ingr> findIngrAndDetailInfoByExtends();  //采用ResultMap继承的方式

    List<VendorIngrInfo> VendorIngrAndDetailInfo();   //多对多查询
}
