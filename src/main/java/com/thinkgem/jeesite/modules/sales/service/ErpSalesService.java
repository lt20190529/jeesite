package com.thinkgem.jeesite.modules.sales.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sales.dao.ErpSalesDao;
import com.thinkgem.jeesite.modules.sales.dao.ErpSalesDetailDao;
import com.thinkgem.jeesite.modules.sales.dao.ErpSalesQueryDao;
import com.thinkgem.jeesite.modules.sales.entity.ErpSales;
import com.thinkgem.jeesite.modules.sales.entity.ErpSalesDetail;


/**
 * 销售Service
 * @author lxt
 * @version 2018-07-26
 */
@Service
@Transactional(readOnly = true)
public class ErpSalesService extends CrudService<ErpSalesDao, ErpSales>{

	    @Autowired
	    private ErpSalesDao erpSalesDao;
	    
	    
	    @Autowired
	    private ErpSalesDetailDao erpSalesDetailDao;
	    
	    @Autowired
	    private ErpSalesQueryDao erpSalesQueryDao;
	    
	    
	    public ErpSales get(String id) {
	    	ErpSales erpSales = erpSalesDao.findErpSalesById(id);
	    	erpSales.setErpSalesDetailList(erpSalesDetailDao.findErpSalesDetailListBySalesId(id));
			return erpSales;
		}
		
		public Page<ErpSales> findPage(Page<ErpSales> page, ErpSales erpSales) {
			erpSales.setPage(page);
			page.setList(erpSalesDao.findList(erpSales));
			return page;
		}
		
		//审核界面跳转至编辑界面加载项目明细
		public List<ErpSalesDetail> findErpSalesDetailListBySalesId(String id) {
			return erpSalesDetailDao.findErpSalesDetailListBySalesId(id);
		}
	    
	    //获取出库最大编码
		@Transactional(readOnly = false)
		public String GetMaxNo(Map<String,Object> map) {
			
				return erpSalesDao.GetMaxNoSales(map);
		}
		
		//销售单保存
		@Transactional(readOnly = false)
		public void save(ErpSales erpSales) {
			
			erpSales.setAuditFlag("N"); //审核标志
			super.save(erpSales);                                                     //保存主表信息，根据是entity.getIsNewRecord()否是新纪录执行insert 或者  update
			for (ErpSalesDetail erpSalesDetail : erpSales.getErpSalesDetailList()){         //循环处理子表信息  
				if (erpSalesDetail.getId() == null){
					continue;
				}
				if (erpSalesDetail.DEL_FLAG_NORMAL.equals(erpSalesDetail.getDelFlag())){   //子表getDelFlag=0 表示不删除
					if (StringUtils.isBlank(erpSalesDetail.getId())){                    //子表ID为空时为新增记录            判断某字符串是否为空或长度为0或由空白符(whitespace) 构成 如果为空返回true
						erpSalesDetail.setSalesid(erpSales.getId());;                        //新增记录  则设置子表对应的主表指向属性
						erpSalesDetail.preInsert();                                      //调用基类中记录创建人createruser 创建日期createrdata等字段
						erpSalesDetailDao.insertE(erpSalesDetail);                          //如果是新增记录则执行插入
					}else{                                                             //子表ID不为空，表示此记录为原有记录，执行update()
						erpSalesDetail.preUpdate();                                      //调用基类中记录更新人updateUser 更新日期updateDate等字段信息
						erpSalesDetailDao.updateE(erpSalesDetail);                          //执行update，如果该条明细记录值不变也执行update,但是会执行更新人更新日期等属性更新
					}
				}else{
					//erpSalesDetailDao.deleteE(erpSalesDetail);                              //(目前改为Ajax删除已经保存的明细)如果是前台标识改条明细记录删除则删除此条记录
				}
			}
		}
		
		//已存明细删除
		@Transactional(readOnly = false)
		public void deleteE(String detailid) {
			erpSalesDetailDao.deleteE(detailid);
		}
		
		//****************************************************销售查询部分******************************************************
		//分页
		public List<ErpSales> findErpSalesByfilter(Map<String,Object> map) {
			return erpSalesQueryDao.findErpSalesByfilter(map);
		}
		//项目入库记录总条数
		public  Integer findErpSalesByfilterCount(Map<String,Object> map){
			return erpSalesQueryDao.findErpSalesByfilterCount(map);
		};

		
		//查询入库子信息(根据主表id)
		public List<ErpSalesDetail> findErpSalesDetail(String id) {
			return erpSalesQueryDao.QueryErpSalesdetailListBySalesId(id);
		}
		
		//销售审核过程
		@Transactional(readOnly = false)
		public String AuditSalesById(Map<String,Object> map) {
				return erpSalesDao.AuditSalesById(map);
		}
}
