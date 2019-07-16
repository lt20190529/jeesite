package com.thinkgem.jeesite.modules.erpStock.dao;

import java.util.List;
import java.util.Map;

import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.erpStock.entity.ErpStock;


@MyBatisDao
public interface StockMangerDao {

	//部门库存
	List<ErpStock> findDepStockByfilter(Map<String,Object> map);
	
	//部门库存总条数
	Integer findDepStockByfilterCount(Map<String,Object> map);
	
}
