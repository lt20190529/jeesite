/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erpvendor.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.erpvendor.entity.ErpVendor;

/**
 * 供应商维护DAO接口
 * @author lt
 * @version 2018-09-20
 */
@MyBatisDao
public interface ErpVendorDao extends CrudDao<ErpVendor> {
	
}