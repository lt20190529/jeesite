package com.thinkgem.jeesite.modules.sales.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sales.entity.ErpSales;

/**
 * 销售DAO接口
 * @author lxt
 * @version 2018-07-26
 */
@MyBatisDao
public interface ErpSalesDao extends CrudDao<ErpSales>{
    //查询单个销售单
	public ErpSales findErpSalesById(@Param("id") String id);
	
	//查询数据列表，如果需要分页，请设置分页对象，如：entity.setPage(new Page<T>());
	public List<ErpSales> findList(ErpSales erpSales);
	
	//获取销售单号
	String GetMaxNoSales(Map<String,Object> map);
	
	//销售审核(存储过程)
	String AuditSalesById(Map<String,Object> map);
	
	//销售主表insert
	public int insert(ErpSales erpSales);
	
	//销售主表update
	public int update(ErpSales erpSales);

	
}
