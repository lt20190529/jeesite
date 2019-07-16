/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.demotest.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.demotest.entity.DemoTest;

/**
 * 测试用户DAO接口
 * @author lxt
 * @version 2018-07-25
 */
@MyBatisDao
public interface DemoTestDao extends CrudDao<DemoTest> {
	
}