/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.rec.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.rec.entity.ErpRecDetail;

import java.util.List;

/**
 * 入库DAO接口
 * @author lxt
 * @version 2018-07-26
 */
@MyBatisDao
public interface ErpRecDetailDao extends CrudDao<ErpRecDetail> {

	List<ErpRecDetail> findErpRecdetailListByRecId(String recid);

    int insertD(ErpRecDetail erpRecDetail);

	int updateD(ErpRecDetail erpRecDetail);

	void deleteD(String id);
}