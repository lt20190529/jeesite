package com.thinkgem.jeesite.modules.crm.system.flex.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.crm.system.flex.entity.FlexSet;
import com.thinkgem.jeesite.modules.crm.system.flex.entity.FlexValue;


@MyBatisDao
public interface FlexDao {
	
	//获取字典分类
	List<FlexSet> getFlexSetList(FlexSet flexSet,PageBounds pageBounds);
	
	//查询字典分类
    List<FlexSet> getFlexSetList(Map<String, Object> map);
	 
	void insertFlexSet(FlexSet flexSet);
	 
	//查询相应的字典分类
	FlexSet getFlexSetById(@Param(value = "flexSetId") int flexSetId);
	
	//修改字典分类
    void updateFlexSet(FlexSet flexSet);
    
    //查询字典明细
    List<FlexValue> getFlexValueByFlexSetId(int flexSetId,PageBounds pageBounds);
    
    List<FlexValue> getFlexValueByFlexSetId(int flexSetId);

    //新增字典明细
	void flexSetDetailInsert(FlexValue flexValue);

	//修改字典明细
	void flexSetDetailUpdate(FlexValue flexValue);

	FlexValue findFlexDetailById(int id);

	//修改字典分类状态
	void flextoggleStatus(@Param(value = "flexSetId") int flexSetId,@Param(value = "enableFlag")String enableFlag);
	
	//删除字典分类
	void deleteFlexSet(@Param(value="flexSetId") int flexSetId);

	//删除字典分类时同时删除字典分类对应的明细信息
	void deleteFlexValue(@Param(value="flexSetId") int flexSetId);
    
}
