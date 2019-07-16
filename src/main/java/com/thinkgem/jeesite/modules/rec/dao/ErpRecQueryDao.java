package com.thinkgem.jeesite.modules.rec.dao;

import java.util.List;
import java.util.Map;

import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.rec.entity.ErpRecNew;
import com.thinkgem.jeesite.modules.rec.entity.ErpRecdetailNew;


/**
 * 入库查询DAO接口
 * @author lxt
 * @version 2018-07-26
 */
@MyBatisDao
public interface ErpRecQueryDao {

		//查询
		List<ErpRecNew> findErpMainByfilter(Map<String,Object> map);
		
		//入库总条数
		Integer findErpMainByfilterCount(Map<String,Object> map);
		
		//查询入库子表
		List<ErpRecdetailNew> QueryErpRecdetailListByRecId(String ids);
		
		//存储过程
		String getRecCount(Map<String,Object> map);

}
