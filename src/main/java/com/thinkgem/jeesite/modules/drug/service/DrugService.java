package com.thinkgem.jeesite.modules.drug.service;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.modules.drug.dao.DrugDao;
import com.thinkgem.jeesite.modules.drug.entity.Drug;

@Service
@Transactional(readOnly = true)
public class DrugService extends CrudService<DrugDao, Drug> {

	@Autowired
	private DrugDao drugDao;
	
	public int checkDrugByCode(String drug_Code) throws Exception{
		return drugDao.checkDrugByCode(drug_Code);
	}
	
	public int checkDrugByDesc(String drug_Desc) throws Exception{
		return drugDao.checkDrugByDesc(drug_Desc);
	}
	
	//获取所有字典(字典列表使用)
	
	/*public List<drug> findDrugList(DrugVo drugVo)throws Exception {
		return drugDao.findDrugList(drugVo);
	}*/

	public Page<Drug> findDrugList(Page<Drug> page, Drug drug)  {
		drug.setPage(page);
		page.setList(drugDao.findList(drug));
		return page;
	}


	@Transactional(readOnly = false)
	public void Save(Drug drug){
		if(StringUtils.isBlank(drug.getDrug_id())){
			drug.setIsNewRecord(false);
			drug.preInsert();
			drug.setDrug_id(IdGen.uuid());
			drugDao.insert(drug);
		}
		else{
			drug.setIsNewRecord(false);
			drug.preInsert();
			drugDao.update(drug);
		}
	}

    //Desc:根据ID查询对应信息
	public Drug getDrugInfoByID(String drugID) {
		return drugDao.getDrugInfoByID(drugID);
	}


}
