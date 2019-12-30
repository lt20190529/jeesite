/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.rec.entity;

import org.hibernate.validator.constraints.Length;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.erpdepartments.entity.ErpDepartments;
import com.thinkgem.jeesite.modules.erpvendor.entity.ErpVendor;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 入库Entity
 * @author lxt
 * @version 2018-07-26
 */
public class ErpRec extends DataEntity<ErpRec> {
	
	private static final long serialVersionUID = 1L;
	private String no;		// 单据编号
	private ErpDepartments dep;		// dep
	private ErpVendor vendor;		// 供货商
	
	private BigDecimal  amtrp;	//进价金额
	private BigDecimal  amtsp;	//售价金额
	private User auditBy;  	// 审核人
	private Date auditDate;	// 更新日期
	private String auditFlag; 	// 审核标志（已审:Y  未审：N）
	
	private List<ErpRecdetail> erpRecdetailList = Lists.newArrayList();		// 子表列表
	
	public ErpRec() {
		super();
	}

	public ErpRec(String id){
		super(id);
	}

	@Length(min=0, max=50, message="单据编号长度必须介于 0 和 50 之间")
	@ExcelField(title="单据编号", align=0, sort=1)
	
	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}
	
	@ExcelField(value="dep.departmentDesc",title="部门",type=2, align=0, sort=2)
	public ErpDepartments getDep() {
		return dep;
	}

	public void setDep(ErpDepartments dep) {
		this.dep = dep;
	}
  
	
	@ExcelField(value="vendor.vendorDesc",title="供货商", align=0, sort=3)
	public ErpVendor getVendor() {
		return vendor;
	}

	public void setVendor(ErpVendor vendor) {
		this.vendor = vendor;
	}
	
	
	@ExcelField(title="进价金额", align=1, sort=4)
	public BigDecimal getAmtrp() {
		return amtrp;
	}

	public void setAmtrp(BigDecimal amtrp) {
		this.amtrp = amtrp;
	}
    
	@ExcelField(title="售价金额", align=1, sort=5)
	public BigDecimal getAmtsp() {
		return amtsp;
	}

	public void setAmtsp(BigDecimal amtsp) {
		this.amtsp = amtsp;
	}
	@ExcelField(value="auditBy.name",title="审核人", align=2, sort=6)
	public User getAuditBy() {
		return auditBy;
	}

	public void setAuditBy(User auditBy) {
		this.auditBy = auditBy;
	}

	public Date getAuditDate() {
		return auditDate;
	}

	public void setAuditDate(Date auditDate) {
		this.auditDate = auditDate;
	}

	public String getAuditFlag() {
		return auditFlag;
	}

	public void setAuditFlag(String auditFlag) {
		this.auditFlag = auditFlag;
	}

	public List<ErpRecdetail> getErpRecdetailList() {
		return erpRecdetailList;
	}

	public void setErpRecdetailList(List<ErpRecdetail> erpRecdetailList) {
		this.erpRecdetailList = erpRecdetailList;
	}

	@Override
	public String toString() {
		return "ErpRec [no=" + no + ", dep=" + dep + ", vendor=" + vendor
				+ ", amtrp=" + amtrp + ", amtsp=" + amtsp + ", auditBy="
				+ auditBy + ", auditDate=" + auditDate + ", auditFlag="
				+ auditFlag + ", erpRecdetailList=" + erpRecdetailList + "]";
	}

	
	
}