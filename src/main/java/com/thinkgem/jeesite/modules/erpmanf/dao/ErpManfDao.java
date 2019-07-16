/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erpmanf.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.erpmanf.entity.ErpManf;

/**
 * 厂家维护DAO接口
 * @author lt
 * @version 2018-10-30
 */
@MyBatisDao
public interface ErpManfDao extends CrudDao<ErpManf> {
	
}