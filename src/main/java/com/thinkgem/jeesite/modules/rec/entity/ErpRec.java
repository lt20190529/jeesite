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
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 入库Entity
 * @author lxt
 * @version 2018-07-26
 */
public class ErpRec extends DataEntity<ErpRec> {
	
	private static final long serialVersionUID = 1L;
	private String no;		// 单据编号
	private String depid;		// dep
	private String depdesc;
	private String vendorid;		// 供货商
	private String vendordesc;
	
	private BigDecimal  amtrp;	//进价金额
	private BigDecimal  amtsp;	//售价金额
	private User auditBy;  	// 审核人
	private Date auditDate;	// 更新日期
	private String auditFlag; 	// 审核标志（已审:Y  未审：N）
	
	private List<ErpRecDetail> erpRecDetailList = Lists.newArrayList();		// 子表列表
	
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

	public List<ErpRecDetail> getErpRecDetailList() {
		return erpRecDetailList;
	}

	public void setErpRecDetailList(List<ErpRecDetail> erpRecDetailList) {
		this.erpRecDetailList = erpRecDetailList;
	}

	public String getDepid() {
		return depid;
	}

	public void setDepid(String depid) {
		this.depid = depid;
	}

	//@ExcelField(value="dep.departmentDesc",title="部门", align=0, sort=2)
	@ExcelField(title="部门", align=0, sort=2)
	public String getDepdesc() {
		return depdesc;
	}

	public void setDepdesc(String depdesc) {
		this.depdesc = depdesc;
	}

	public String getVendorid() {
		return vendorid;
	}

	public void setVendorid(String vendorid) {
		this.vendorid = vendorid;
	}
 
	@ExcelField(title="供货商", align=0, sort=3)
	public String getVendordesc() {
		return vendordesc;
	}

	public void setVendordesc(String vendordesc) {
		this.vendordesc = vendordesc;
	}

	
	
}