package com.thinkgem.jeesite.modules.sales.dao;

import java.util.List;
import java.util.Map;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sales.entity.ErpSales;
import com.thinkgem.jeesite.modules.sales.entity.ErpSalesDetail;


/**
 * 销售DAO接口
 * @author lxt
 * @version 2018-07-26
 */
@MyBatisDao
public interface ErpSalesQueryDao extends CrudDao<ErpSales> {
	
	    //**********************************************************销售查询部分使用***************************************************************************
		//查询
		List<ErpSales> findErpSalesByfilter(Map<String,Object> map);
		
		//入库总条数
		Integer findErpSalesByfilterCount(Map<String,Object> map);
		
		//查询入库子表
		List<ErpSalesDetail> QueryErpSalesdetailListBySalesId(String ids);

	

}
