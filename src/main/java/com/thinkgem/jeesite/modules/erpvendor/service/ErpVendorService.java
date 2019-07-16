/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erpvendor.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.erpvendor.entity.ErpVendor;
import com.thinkgem.jeesite.modules.erpvendor.dao.ErpVendorDao;

/**
 * 供应商维护Service
 * @author lt
 * @version 2018-09-20
 */
@Service
@Transactional(readOnly = true)
public class ErpVendorService extends CrudService<ErpVendorDao, ErpVendor> {

	public ErpVendor get(String id) {
		return super.get(id);
	}
	
	public List<ErpVendor> findList(ErpVendor erpVendor) {
		return super.findList(erpVendor);
	}
	
	public Page<ErpVendor> findPage(Page<ErpVendor> page, ErpVendor erpVendor) {
		return super.findPage(page, erpVendor);
	}
	
	@Transactional(readOnly = false)
	public void save(ErpVendor erpVendor) {
		super.save(erpVendor);
	}
	
	@Transactional(readOnly = false)
	public void delete(ErpVendor erpVendor) {
		super.delete(erpVendor);
	}
	
}