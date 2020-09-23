/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.rec.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.rec.entity.ErpRec;
import com.thinkgem.jeesite.modules.rec.entity.ErpRecDetail;
import com.thinkgem.jeesite.modules.rec.dao.ErpRecDao;
import com.thinkgem.jeesite.modules.rec.dao.ErpRecDetailDao;

/**
 * 入库Service
 * @author lxt
 * @version 2018-07-26
 */
@Service
@Transactional(readOnly = true)
public class ErpRecService extends CrudService<ErpRecDao, ErpRec> {


	
	@Autowired
	private ErpRecDao erpRecDao;



	@Autowired
	private ErpRecDetailDao erpRecDetailDao;
	
	public ErpRec get(String id) {
		ErpRec erpRec = erpRecDao.findErpRecById(id);
		erpRec.setErpRecDetailList(erpRecDetailDao.findErpRecdetailListByRecIdnew(id));

		return erpRec;
	}
	
	public Page<ErpRec> findPage(Page<ErpRec> page, ErpRec erpRec) {
		erpRec.setPage(page);
		page.setList(erpRecDao.findList(erpRec));
		return page;
	}
	
	//获取入库最大编码
	@Transactional(readOnly = false)
	public String GetMaxNo(Map<String,Object> map) {
			return erpRecDao.GetMaxNo(map);
	}
	
	//EasyUI版保存入库信息
	@Transactional(readOnly = false)
	public void save(ErpRec erpRec) {
		
		erpRec.setAuditFlag("N"); //审核标志
		super.save(erpRec);                                                     //保存主表信息，根据是entity.getIsNewRecord()否是新纪录执行insert 或者  update
		for (ErpRecDetail erpRecDetail : erpRec.getErpRecDetailList()){         //循环处理子表信息
			if (erpRecDetail.getId() == null){
				continue;
			}
			if (erpRecDetail.DEL_FLAG_NORMAL.equals(erpRecDetail.getDelFlag())){   //子表getDelFlag=0 表示不删除
				//if (StringUtils.isBlank(erpRecdetailNew.getId())){                    //子表ID为空时为新增记录            判断某字符串是否为空或长度为0或由空白符(whitespace) 构成 如果为空返回true
					erpRecDetail.setRecid(erpRec.getId());                        //新增记录  则设置子表对应的主表指向属性
                    erpRecDetail.setSubid(Integer.parseInt(erpRecDetail.getId()));
                    erpRecDetail.preInsert();                                      //调用基类中记录创建人createruser 创建日期createrdata等字段
					erpRecDetailDao.insertE(erpRecDetail);                          //如果是新增记录则执行插入
				//}else{                                                             //子表ID不为空，表示此记录为原有记录，执行update()
				//	erpRecdetailNew.preUpdate();                                      //调用基类中记录更新人updateUser 更新日期updateDate等字段信息
				//	erpRecdetailNewDao.updateE(erpRecdetailNew);                          //执行update，如果该条明细记录值不变也执行update,但是会执行更新人更新日期等属性更新
				//}
			}else{
				//erpRecdetailDao.delete(erpRecdetailNew);                              //如果是前台标识改条明细记录删除则删除此条记录
			}
		}
	}
	
	public List<ErpRecDetail> findErpRecdetailListByRecIdnew(String id) {
		return erpRecDetailDao.findErpRecdetailListByRecIdnew(id);
	}
	
	@Transactional(readOnly = false)
	public void deleteE(String detailid) {
		erpRecDetailDao.deleteE(detailid);
	}
	
	@Transactional(readOnly = false)
	public void delete(ErpRec erpRec) {
		super.delete(erpRec);
		erpRecDetailDao.delete(new ErpRecDetail());
	}
	//入库审核过程
	@Transactional(readOnly = false)
	public String AuditRecById(Map<String,Object> map) {
			return erpRecDao.AuditRecById(map);
	}
	
	
	
}