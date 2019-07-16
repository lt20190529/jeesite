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
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.erpdepartments.entity.ErpDepartments;
import com.thinkgem.jeesite.modules.erpuom.entity.ErpUom;
import com.thinkgem.jeesite.modules.rec.entity.ErpRec;
import com.thinkgem.jeesite.modules.rec.entity.ErpRecNew;
import com.thinkgem.jeesite.modules.rec.entity.ErpRecdetailNew;
import com.thinkgem.jeesite.modules.rec.dao.ErpRecDao;
import com.thinkgem.jeesite.modules.rec.dao.ErpRecNewDao;
import com.thinkgem.jeesite.modules.rec.dao.ErpRecdetailNewDao;
import com.thinkgem.jeesite.modules.rec.entity.ErpRecdetail;
import com.thinkgem.jeesite.modules.rec.dao.ErpRecdetailDao;

/**
 * 入库Service
 * @author lxt
 * @version 2018-07-26
 */
@Service
@Transactional(readOnly = true)
public class ErpRecNewService extends CrudService<ErpRecNewDao, ErpRecNew> {

	//将Spring 中的DAO  bean 注入进来
	@Autowired
	private ErpRecdetailDao erpRecdetailDao;
	
	@Autowired
	private ErpRecDao erpRecDao;
	
	@Autowired
	private ErpRecNewDao erpRecNewDao;
	
	@Autowired
	private ErpRecdetailNewDao erpRecdetailNewDao;
	
	public ErpRecNew get(String id) {
		ErpRecNew erpRecNew = erpRecNewDao.findErpRecById(id);
		erpRecNew.setErpRecdetailNewList(erpRecdetailNewDao.findErpRecdetailListByRecIdnew(id));

		return erpRecNew;
	}
	
	public Page<ErpRecNew> findPage(Page<ErpRecNew> page, ErpRecNew erpRecNew) {
		erpRecNew.setPage(page);
		page.setList(erpRecNewDao.findList(erpRecNew));
		return page;
	}
	
	//获取入库最大编码
	@Transactional(readOnly = false)
	public String GetMaxNo(Map<String,Object> map) {
			return erpRecNewDao.GetMaxNo(map);
	}
	
	//EasyUI版保存入库信息
	@Transactional(readOnly = false)
	public void save(ErpRecNew erpRecNew) {
		
		erpRecNew.setAuditFlag("N"); //审核标志
		super.save(erpRecNew);                                                     //保存主表信息，根据是entity.getIsNewRecord()否是新纪录执行insert 或者  update
		for (ErpRecdetailNew erpRecdetailNew : erpRecNew.getErpRecdetailNewList()){         //循环处理子表信息  
			if (erpRecdetailNew.getId() == null){
				continue;
			}
			if (erpRecdetailNew.DEL_FLAG_NORMAL.equals(erpRecdetailNew.getDelFlag())){   //子表getDelFlag=0 表示不删除
				if (StringUtils.isBlank(erpRecdetailNew.getId())){                    //子表ID为空时为新增记录            判断某字符串是否为空或长度为0或由空白符(whitespace) 构成 如果为空返回true
					erpRecdetailNew.setRecid(erpRecNew.getId());;                        //新增记录  则设置子表对应的主表指向属性
					erpRecdetailNew.preInsert();                                      //调用基类中记录创建人createruser 创建日期createrdata等字段
					erpRecdetailNewDao.insertE(erpRecdetailNew);                          //如果是新增记录则执行插入
				}else{                                                             //子表ID不为空，表示此记录为原有记录，执行update()
					erpRecdetailNew.preUpdate();                                      //调用基类中记录更新人updateUser 更新日期updateDate等字段信息
					erpRecdetailNewDao.updateE(erpRecdetailNew);                          //执行update，如果该条明细记录值不变也执行update,但是会执行更新人更新日期等属性更新
				}
			}else{
				//erpRecdetailDao.delete(erpRecdetailNew);                              //如果是前台标识改条明细记录删除则删除此条记录
			}
		}
	}
	
	public List<ErpRecdetailNew> findErpRecdetailListByRecIdnew(String id) {
		return erpRecdetailNewDao.findErpRecdetailListByRecIdnew(id);
	}
	
	@Transactional(readOnly = false)
	public void deleteE(String detailid) {
		erpRecdetailNewDao.deleteE(detailid);
	}
	
	@Transactional(readOnly = false)
	public void delete(ErpRecNew erpRecNew) {
		super.delete(erpRecNew);
		erpRecdetailNewDao.delete(new ErpRecdetail());
	}
	//入库审核过程
	@Transactional(readOnly = false)
	public String AuditRecById(Map<String,Object> map) {
			return erpRecNewDao.AuditRecById(map);
	}
	
	
	
}