/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.item.dao;

import java.util.List;
import java.util.Map;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.item.entity.ErpItem;

/**
 * 字典维护DAO接口
 * @author lxt
 * @version 2018-08-06
 */
@MyBatisDao
public interface ErpItemDao extends CrudDao<ErpItem> {
	
	//根据ID获取ErpItem
	public ErpItem getErpItemByid(String id);
	
	
	
	public List<ErpItem> findErpItemList(ErpItem erpItem);
	
	
	public List<ErpItem> getErpItemBybrevitycode(Map<String,Object> map);
	
	//<!-- 项目选择框检索总条数 -->
	public Integer getErpItemBybrevitycodeCount(Map<String,Object> map);
	
	
	//代码唯一性校验
	public ErpItem getErpItemByItemNo(String itemCode);
	
	
	//描述唯一性校验
	public ErpItem getErpItemByItemDesc(String itemDesc);
}