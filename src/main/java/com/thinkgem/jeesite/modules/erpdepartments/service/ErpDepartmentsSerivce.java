package com.thinkgem.jeesite.modules.erpdepartments.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.erpdepartments.dao.ErpDepartmentDao;
import com.thinkgem.jeesite.modules.erpdepartments.entity.ErpDepartments;
import com.thinkgem.jeesite.modules.erpvendor.entity.ErpVendor;





/**
 * 部門维护Service
 * @author lt
 * @version 2018-09-20
 */
@Service
@Transactional(readOnly = true)
public class ErpDepartmentsSerivce extends CrudService<ErpDepartmentDao, ErpDepartments>  {
	
	@Autowired
	private ErpDepartmentDao erpDepartmentDao;
	
	public ErpDepartments get(String id) {
		return erpDepartmentDao.get(id);
	}
	
	public List<ErpDepartments> findList(ErpDepartments erpDepartments) {
		return erpDepartmentDao.findList(erpDepartments);
	}
	
	public Page<ErpDepartments> findPage(Page<ErpDepartments> page, ErpDepartments erpDepartments) {
		erpDepartments.setPage(page);
		page.setList(erpDepartmentDao.findList(erpDepartments));
		return page;
	}
	
	
	@Transactional(readOnly = false)
	public void save(ErpDepartments erpDepartments) {
		
		if (erpDepartments.getIsNewRecord()){      //新增记录  insert
			erpDepartments.preInsert();                   
			erpDepartmentDao.insert(erpDepartments);
		}else{                                     //修改记录  update
			erpDepartments.preUpdate();
			erpDepartmentDao.update(erpDepartments);
		}
		
	}
	
	@Transactional(readOnly = false)
	public void delete(ErpDepartments erpDepartments) {
		erpDepartmentDao.delete(erpDepartments);
	}
	
	

}
