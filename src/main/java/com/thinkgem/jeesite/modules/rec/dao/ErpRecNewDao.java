/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.rec.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.rec.entity.ErpRec;
import com.thinkgem.jeesite.modules.rec.entity.ErpRecNew;

/**
 * 入库DAO接口
 * @author lxt
 * @version 2018-07-26
 */
@MyBatisDao
public interface ErpRecNewDao extends CrudDao<ErpRecNew> {
	/**
	 * 根据入库ID查询入库主表信息;
	 * @param RecID
	 * @return
	 */
	public ErpRecNew findErpRecById(@Param("id") String id);
	
	/**
	 * 查询数据列表，如果需要分页，请设置分页对象，如：entity.setPage(new Page<T>());
	 * @param entity
	 * @return
	 */
	public List<ErpRecNew> findList(ErpRecNew erpRecNew);

	
	//获取入库单号
	String GetMaxNo(Map<String,Object> map);
	
	//入库审核(存储过程)
	String AuditRecById(Map<String,Object> map);
	
	//主表insert
	public int insert(ErpRecNew erpRecNew);
	
	//主表update
	public int update(ErpRecNew erpRecNew);
}