package com.thinkgem.jeesite.modules.sales.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 销售Entity
 * @author lxt
 * @version 2018-11-28
 */
public class ErpSales extends DataEntity<ErpSales>{

	private static final long serialVersionUID = 1L;
	private String no;		// 单据编号
	private String depid;		// 仓位(那个仓位卖出)
	private String depdesc;
	private String buyerid;		// 买方(预留可维护)
	private String buyername;   //买方
	
	private BigDecimal  amtrp;	//进价金额
	private BigDecimal  amtsp;	//售价金额
	private User auditBy;  	// 审核人
	private Date auditDate;	// 更新日期
	private String auditFlag; 	// 审核标志（已审:Y  未审：N）
	
	private List<ErpSalesDetail> erpSalesDetailList = Lists.newArrayList();

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public String getDepid() {
		return depid;
	}

	public void setDepid(String depid) {
		this.depid = depid;
	}

	public String getDepdesc() {
		return depdesc;
	}

	public void setDepdesc(String depdesc) {
		this.depdesc = depdesc;
	}

	public String getBuyerid() {
		return buyerid;
	}

	public void setBuyerid(String buyerid) {
		this.buyerid = buyerid;
	}

	public String getBuyername() {
		return buyername;
	}

	public void setBuyername(String buyername) {
		this.buyername = buyername;
	}

	public BigDecimal getAmtrp() {
		return amtrp;
	}

	public void setAmtrp(BigDecimal amtrp) {
		this.amtrp = amtrp;
	}

	public BigDecimal getAmtsp() {
		return amtsp;
	}

	public void setAmtsp(BigDecimal amtsp) {
		this.amtsp = amtsp;
	}

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

	public List<ErpSalesDetail> getErpSalesDetailList() {
		return erpSalesDetailList;
	}

	public void setErpSalesDetailList(List<ErpSalesDetail> erpSalesDetailList) {
		this.erpSalesDetailList = erpSalesDetailList;
	}

	@Override
	public String toString() {
		return "ErpSales [no=" + no + ", depid=" + depid + ", depdesc="
				+ depdesc + ", buyerid=" + buyerid + ", buyername=" + buyername
				+ ", amtrp=" + amtrp + ", amtsp=" + amtsp + ", auditBy="
				+ auditBy + ", auditDate=" + auditDate + ", auditFlag="
				+ auditFlag + ", erpSalesDetailList=" + erpSalesDetailList
				+ "]";
	}

	
	
	
	
	
}
