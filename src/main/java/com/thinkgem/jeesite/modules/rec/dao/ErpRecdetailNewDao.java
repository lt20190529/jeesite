/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.rec.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.rec.entity.ErpRecdetail;
import com.thinkgem.jeesite.modules.rec.entity.ErpRecdetailNew;

/**
 * 入库DAO接口
 * @author lxt
 * @version 2018-07-26
 */
@MyBatisDao
public interface ErpRecdetailNewDao extends CrudDao<ErpRecdetail> {
	
	
	public List<ErpRecdetail> findListNew(String recid);
	
	
	//扩展实体(不带子属性对象)
	public List<ErpRecdetailNew> findErpRecdetailListByRecIdnew(String recid);
	
	
	//insert子表
	public int insert(ErpRecdetail erpRecdetail);
	
	
	//update子表
	public int update(ErpRecdetail erpRecdetail);
	
	
	//********************************EasyUI版本业务处理***************************************
	
	//insert子表
    public int insertE(ErpRecdetailNew erpRecdetailNew);
		
		
    //update子表
	public int updateE(ErpRecdetailNew erpRecdetailNew);
		
	//delete子表
	public void deleteE(String detailid);
}