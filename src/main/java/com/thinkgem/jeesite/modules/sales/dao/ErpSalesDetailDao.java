package com.thinkgem.jeesite.modules.sales.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sales.entity.ErpSalesDetail;

/**
 * 销售DAO接口
 * @author lxt
 * @version 2018-07-26
 */
@MyBatisDao
public interface ErpSalesDetailDao extends CrudDao<ErpSalesDetail>{

	//insert子表
    public int insertE(ErpSalesDetail erpSalesDetail);
		
		
    //update子表
	public int updateE(ErpSalesDetail erpSalesDetail);
		
	//delete子表
	public void deleteE(String detailid);
	
	//根据销售主表主键查询销售明细
	public List<ErpSalesDetail> findErpSalesDetailListBySalesId(String Salesid);
	
	
}
