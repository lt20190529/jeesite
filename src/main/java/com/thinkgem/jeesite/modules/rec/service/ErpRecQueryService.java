package com.thinkgem.jeesite.modules.rec.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.thinkgem.jeesite.modules.rec.dao.ErpRecQueryDao;
import com.thinkgem.jeesite.modules.rec.entity.ErpRec;
import com.thinkgem.jeesite.modules.rec.entity.ErpRecDetail;


@Service
@Transactional
public class ErpRecQueryService {

	@Autowired
	private ErpRecQueryDao erpRecQueryDao;

	//分页
	public List<ErpRec> findErpMainByfilter(Map<String,Object> map) {
		return erpRecQueryDao.findErpMainByfilter(map);
	}
	//项目入库记录总条数
	public  Integer findErpMainByfilterCount(Map<String,Object> map){
		return erpRecQueryDao.findErpMainByfilterCount(map);
	};

	
	//查询入库子信息(根据主表id)
	public List<ErpRecDetail> finderpRecDetail(String id) {
		return erpRecQueryDao.QueryErpRecdetailListByRecId(id);
	}
	
	//存储过程
	public String getrecMainCount(Map<String,Object> map) {
		return erpRecQueryDao.getRecCount(map);
	}
	
}
