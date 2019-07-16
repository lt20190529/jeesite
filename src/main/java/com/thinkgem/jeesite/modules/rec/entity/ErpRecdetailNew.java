/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.rec.entity;

import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 入库Entity
 * @author lxt
 * @version 2018-07-26
 */
public class ErpRecdetailNew extends DataEntity<ErpRecdetailNew> {
	
	private static long serialVersionUID = 1L;
	
	private String id;		    // id
	private String recid;		// 主表ID 父类	
	private int subid;          //子表顺序号
	
	private String itemid;      // 项目id
	private String itemno;      // 项目编码
	private String itemdesc;    // 项目描述
	private String itemspec;    //规格
	
	private String uomid;		// 单位id
	private String uomcode;     //单位编码
	private String uomdesc;     //单位描述
	
	private String qty;		    // 数量
	private String sp;		    // 售价
	private BigDecimal spamt;   //售价金额    
	private String rp;           // 进价
	private BigDecimal rpamt;    //进价金额
	
	private String depid;       //入库部门
	private String depDesc;     //部门描述
	
	private String manfid;      //厂家ID
	private String manfdesc;    //厂家描述
	
	private String batno;
	private Date expdate;  
	
	private String itemlbdr;    //批次指向
	private String itemibdr;    //预留
	
	private String invno;       //发票
	private BigDecimal invamt;  //发票金额  
	private Date invdate;       //发票日期
	
	private String margin;     //加成

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRecid() {
		return recid;
	}

	public void setRecid(String recid) {
		this.recid = recid;
	}

	public int getSubid() {
		return subid;
	}

	public void setSubid(int subid) {
		this.subid = subid;
	}

	public String getItemid() {
		return itemid;
	}

	public void setItemid(String itemid) {
		this.itemid = itemid;
	}

	public String getItemno() {
		return itemno;
	}

	public void setItemno(String itemno) {
		this.itemno = itemno;
	}

	public String getItemdesc() {
		return itemdesc;
	}

	public void setItemdesc(String itemdesc) {
		this.itemdesc = itemdesc;
	}

	public String getItemspec() {
		return itemspec;
	}

	public void setItemspec(String itemspec) {
		this.itemspec = itemspec;
	}

	public String getUomid() {
		return uomid;
	}

	public void setUomid(String uomid) {
		this.uomid = uomid;
	}

	public String getUomcode() {
		return uomcode;
	}

	public void setUomcode(String uomcode) {
		this.uomcode = uomcode;
	}

	public String getUomdesc() {
		return uomdesc;
	}

	public void setUomdesc(String uomdesc) {
		this.uomdesc = uomdesc;
	}

	public String getQty() {
		return qty;
	}

	public void setQty(String qty) {
		this.qty = qty;
	}

	public String getSp() {
		return sp;
	}

	public void setSp(String sp) {
		this.sp = sp;
	}

	public BigDecimal getSpamt() {
		return spamt;
	}

	public void setSpamt(BigDecimal spamt) {
		this.spamt = spamt;
	}

	public String getRp() {
		return rp;
	}

	public void setRp(String rp) {
		this.rp = rp;
	}

	public BigDecimal getRpamt() {
		return rpamt;
	}

	public void setRpamt(BigDecimal rpamt) {
		this.rpamt = rpamt;
	}

	public String getDepid() {
		return depid;
	}

	public void setDepid(String depid) {
		this.depid = depid;
	}

	public String getDepDesc() {
		return depDesc;
	}

	public void setDepDesc(String depDesc) {
		this.depDesc = depDesc;
	}

	public String getManfid() {
		return manfid;
	}

	public void setManfid(String manfid) {
		this.manfid = manfid;
	}

	public String getManfdesc() {
		return manfdesc;
	}

	public void setManfdesc(String manfdesc) {
		this.manfdesc = manfdesc;
	}

	public String getBatno() {
		return batno;
	}

	public void setBatno(String batno) {
		this.batno = batno;
	}

	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getExpdate() {
		return expdate;
	}

	public void setExpdate(Date expdate) {
		this.expdate = expdate;
	}

	public String getItemlbdr() {
		return itemlbdr;
	}

	public void setItemlbdr(String itemlbdr) {
		this.itemlbdr = itemlbdr;
	}

	public String getItemibdr() {
		return itemibdr;
	}

	public void setItemibdr(String itemibdr) {
		this.itemibdr = itemibdr;
	}

	public String getInvno() {
		return invno;
	}

	public void setInvno(String invno) {
		this.invno = invno;
	}

	public BigDecimal getInvamt() {
		return invamt;
	}

	public void setInvamt(BigDecimal invamt) {
		this.invamt = invamt;
	}

	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getInvdate() {
		return invdate;
	}

	public void setInvdate(Date invdate) {
		this.invdate = invdate;
	}

	public String getMargin() {
		return margin;
	}

	public void setMargin(String margin) {
		this.margin = margin;
	}

	@Override
	public String toString() {
		return "ErpRecdetailNew [id=" + id + ", recid=" + recid + ", subid="
				+ subid + ", itemid=" + itemid + ", itemno=" + itemno
				+ ", itemdesc=" + itemdesc + ", itemspec=" + itemspec
				+ ", uomid=" + uomid + ", uomcode=" + uomcode + ", uomdesc="
				+ uomdesc + ", qty=" + qty + ", sp=" + sp + ", spamt=" + spamt
				+ ", rp=" + rp + ", rpamt=" + rpamt + ", depid=" + depid
				+ ", depDesc=" + depDesc + ", manfid=" + manfid + ", manfdesc="
				+ manfdesc + ", batno=" + batno + ", expdate=" + expdate
				+ ", itemlbdr=" + itemlbdr + ", itemibdr=" + itemibdr
				+ ", invno=" + invno + ", invamt=" + invamt + ", invdate="
				+ invdate + ", margin=" + margin + "]";
	}
	
    
	
}