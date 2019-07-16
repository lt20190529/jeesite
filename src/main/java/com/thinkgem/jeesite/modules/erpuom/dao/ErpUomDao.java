/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erpuom.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.erpuom.entity.ErpUom;

/**
 * 单位维护DAO接口
 * @author 单位维护
 * @version 2018-09-20
 */
@MyBatisDao
public interface ErpUomDao extends CrudDao<ErpUom> {
	
}