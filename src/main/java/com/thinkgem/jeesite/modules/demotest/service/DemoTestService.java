/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.demotest.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.demotest.entity.DemoTest;
import com.thinkgem.jeesite.modules.demotest.dao.DemoTestDao;

/**
 * 测试用户Service
 * @author lxt
 * @version 2018-07-25
 */
@Service
@Transactional(readOnly = true)
public class DemoTestService extends CrudService<DemoTestDao, DemoTest> {

	public DemoTest get(String id) {
		return super.get(id);
	}
	
	public List<DemoTest> findList(DemoTest demoTest) {
		return super.findList(demoTest);
	}
	
	public Page<DemoTest> findPage(Page<DemoTest> page, DemoTest demoTest) {
		return super.findPage(page, demoTest);
	}
	
	@Transactional(readOnly = false)
	public void save(DemoTest demoTest) {
		super.save(demoTest);
	}
	
	@Transactional(readOnly = false)
	public void delete(DemoTest demoTest) {
		super.delete(demoTest);
	}
	
}