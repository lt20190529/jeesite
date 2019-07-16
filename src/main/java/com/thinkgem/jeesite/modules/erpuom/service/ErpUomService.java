/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erpuom.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.erpuom.entity.ErpUom;
import com.thinkgem.jeesite.modules.erpuom.dao.ErpUomDao;

/**
 * 单位维护Service
 * @author 单位维护
 * @version 2018-09-20
 */
@Service
@Transactional(readOnly = true)
public class ErpUomService extends CrudService<ErpUomDao, ErpUom> {

	public ErpUom get(String id) {
		return super.get(id);
	}
	
	public List<ErpUom> findList(ErpUom erpUom) {
		return super.findList(erpUom);
	}
	
	public Page<ErpUom> findPage(Page<ErpUom> page, ErpUom erpUom) {
		return super.findPage(page, erpUom);
	}
	
	@Transactional(readOnly = false)
	public void save(ErpUom erpUom) {
		super.save(erpUom);
	}
	
	@Transactional(readOnly = false)
	public void delete(ErpUom erpUom) {
		super.delete(erpUom);
	}
	
}