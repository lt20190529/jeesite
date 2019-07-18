package com.thinkgem.jeesite.modules.crm.system.flex.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.thinkgem.jeesite.modules.crm.system.flex.dao.FlexDao;
import com.thinkgem.jeesite.modules.crm.system.flex.entity.FlexSet;
import com.thinkgem.jeesite.modules.crm.system.flex.entity.FlexValue;

@Service
@Transactional(readOnly = false)
public class FlexService {

	@Autowired
	private FlexDao flexDao;
	
	public List<FlexSet> getFlexSetList(FlexSet flexSet,PageBounds pageBounds) {
		pageBounds.setAsyncTotalCount(true);
		return flexDao.getFlexSetList(flexSet,pageBounds);
	}
	
	public List<FlexSet> insertFlexSet(FlexSet flexSet) {
		flexSet.setReserved("Y");
		flexSet.setUuid(UUID.randomUUID().toString().replace("-", ""));
		flexDao.insertFlexSet(flexSet);
		return getFlexSetList(flexSet);
	}
	
	public FlexSet getFlexSetById(int flexSetId) {
        return flexDao.getFlexSetById(flexSetId);
    }
	
	public List<FlexSet> updateFlexSet(FlexSet flexSet) {
        flexDao.updateFlexSet(flexSet);
        return getFlexSetList(flexSet);
    }
	
    public List<FlexSet> getFlexSetList(FlexSet flexSet) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", flexSet.getCode());
        map.put("name", flexSet.getName());
        map.put("istree", flexSet.getIstree());
        map.put("reserved", flexSet.getReserved());
        map.put("tenantName", flexSet.getTenantName());
        return flexDao.getFlexSetList(map);
    }
    
    //查询字典明细
    public List<FlexValue> getFlexValueByFlexSetId(int flexSetId,PageBounds pageBounds){
    	return flexDao.getFlexValueByFlexSetId(flexSetId, pageBounds);
    }
    
    public List<FlexValue> getFlexValueByFlexSetId(int flexSetId){
    	return flexDao.getFlexValueByFlexSetId(flexSetId);
    }

    //新增字典明细
	public void flexSetDetailInsert(FlexValue flexValue) {
		flexDao.flexSetDetailInsert(flexValue);
	}
	
	//修改字典明细
	public void flexSetDetailUpdate(FlexValue flexValue) {
		flexDao.flexSetDetailUpdate(flexValue);
	}
	
	//根据字典明细ID查询字典明细
	public FlexValue findFlexDetailById(int id) {
	        return flexDao.findFlexDetailById(id);
	}

	//修改字典明细状态
	public void flextoggleStatus(int flexSetId) {
		FlexSet flexSet=flexDao.getFlexSetById(flexSetId);
		String enableFlag="";
		if("Y".equals(flexSet.getEnableFlag())){
			enableFlag="N";
		}else{
			enableFlag="Y";
		}
		flexDao.flextoggleStatus(flexSetId,enableFlag);
	}
	
	//删除字典分类
	public void deleteFlexSet(int flexSetId){
		flexDao.deleteFlexSet(flexSetId);
	}
	
    //删除字典分类同时删除字典分类对应的明细信息
	public void deleteFlexValue(int flexSetId) {
		flexDao.deleteFlexValue(flexSetId);
		
	}
    
    
	
}
