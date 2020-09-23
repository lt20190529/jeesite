package com.thinkgem.jeesite.modules.erpdepartments.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.erpdepartments.entity.ErpDepartments;


/**
 * 供应商维护DAO接口
 * @author lt
 * @version 2018-09-20
 */
@MyBatisDao
public interface ErpDepartmentDao extends CrudDao<ErpDepartments> {

	/**
	 * 获取单条数据
	 * @param id
	 * @return
	 */
	public ErpDepartments get(String id);
	
	/**
	 * 获取单条数据
	 * @param entity
	 * @return
	 */
	public ErpDepartments get(ErpDepartments erpDepartments);
	
	/**
	 * 查询数据列表，如果需要分页，请设置分页对象，如：entity.setPage(new Page<T>());
	 * @param entity
	 * @return
	 */
	public List<ErpDepartments> findList(ErpDepartments erpDepartments);
	
	/**
	 * 数据插入
	 * @param entity
	 */
	public int insert(ErpDepartments erpDepartments);
	
	/**
	 * 数据更新
	 * @param entity
	 */
	public int update(ErpDepartments erpDepartments);
	
	/**
	 * 删除数据（一般为逻辑删除，更新del_flag字段为1）
	 * @param entity
	 * @return
	 */
	public int delete(ErpDepartments erpDepartments);
}
