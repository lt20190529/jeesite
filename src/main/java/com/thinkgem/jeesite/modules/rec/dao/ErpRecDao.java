package com.thinkgem.jeesite.modules.rec.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.rec.entity.ErpRec;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 入库DAO接口
 * @author lxt
 * @version 2018-07-26
 */
@MyBatisDao
public interface ErpRecDao extends CrudDao<ErpRec> {

	ErpRec findErpRecById(@Param("id") String id);

	List<ErpRec> findList(ErpRec erpRec);

	String GetMaxNo(Map<String,Object> map);

	String AuditRecById(Map<String,Object> map);

}