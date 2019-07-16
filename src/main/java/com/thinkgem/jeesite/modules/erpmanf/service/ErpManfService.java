/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erpmanf.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.erpmanf.entity.ErpManf;
import com.thinkgem.jeesite.modules.erpmanf.dao.ErpManfDao;

/**
 * 厂家维护Service
 * @author lt
 * @version 2018-10-30
 */
@Service
@Transactional(readOnly = true)
public class ErpManfService extends CrudService<ErpManfDao, ErpManf> {

	public ErpManf get(String id) {
		return super.get(id);
	}
	
	public List<ErpManf> findList(ErpManf erpManf) {
		return super.findList(erpManf);
	}
	
	public Page<ErpManf> findPage(Page<ErpManf> page, ErpManf erpManf) {
		return super.findPage(page, erpManf);
	}
	
	@Transactional(readOnly = false)
	public void save(ErpManf erpManf) {
		super.save(erpManf);
	}
	
	@Transactional(readOnly = false)
	public void delete(ErpManf erpManf) {
		super.delete(erpManf);
	}
	
}