package com.thinkgem.jeesite.modules.Drug.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.Drug.entity.Drug;
import com.thinkgem.jeesite.modules.Drug.entity.DrugVo;

@MyBatisDao
public interface DrugDao extends CrudDao<Drug> {
	
	public int checkDrugByCode(String drug_Code)throws Exception;

	public int checkDrugByDesc(String drug_Desc)throws Exception;
	
	public List<Drug> findList(Drug drug);
	
	public int insert(Drug drug);
	
	public int update(Drug drug);

    Drug getDrugInfoByID(String drugID);

}
