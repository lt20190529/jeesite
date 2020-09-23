/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.rec.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.rec.entity.ErpRecDetail;

/**
 * 入库DAO接口
 * @author lxt
 * @version 2018-07-26
 */
@MyBatisDao
public interface ErpRecDetailDao extends CrudDao<ErpRecDetail> {
	
	
	public List<ErpRecDetail> findListNew(String recid);
	
	
	//扩展实体(不带子属性对象)
	public List<ErpRecDetail> findErpRecdetailListByRecIdnew(String recid);
	
	
	//insert子表
	public int insert(ErpRecDetail erpRecdetail);
	
	
	//update子表
	public int update(ErpRecDetail erpRecdetail);
	
	
	//********************************EasyUI版本业务处理***************************************
	
	//insert子表
    public int insertE(ErpRecDetail erpRecDetail);
		
		
    //update子表
	public int updateE(ErpRecDetail erpRecDetail);
		
	//delete子表
	public void deleteE(String detailid);
}