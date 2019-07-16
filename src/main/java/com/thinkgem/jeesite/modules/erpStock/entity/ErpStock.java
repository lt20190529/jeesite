package com.thinkgem.jeesite.modules.erpStock.entity;

import java.math.BigDecimal;

import com.thinkgem.jeesite.modules.erpdepartments.entity.ErpDepartments;
import com.thinkgem.jeesite.modules.erpuom.entity.ErpUom;
import com.thinkgem.jeesite.modules.item.entity.ErpItem;

public class ErpStock {
	
	private String id;		                //id
	private ErpDepartments erpDepartments;  //库房
	
	private ErpItem erpItem;                //项目
	private String qty;		                //数量
	private BigDecimal spamt;
	private ErpUom erpuom;                  //单位
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public ErpDepartments getErpDepartments() {
		return erpDepartments;
	}
	public void setErpDepartments(ErpDepartments erpDepartments) {
		this.erpDepartments = erpDepartments;
	}
	
	
	public ErpItem getErpItem() {
		return erpItem;
	}
	public void setErpItem(ErpItem erpItem) {
		this.erpItem = erpItem;
	}
	public String getQty() {
		return qty;
	}
	public void setQty(String qty) {
		this.qty = qty;
	}
	public ErpUom getErpuom() {
		return erpuom;
	}
	public void setErpuom(ErpUom erpuom) {
		this.erpuom = erpuom;
	}
	public BigDecimal getSpamt() {
		return spamt;
	}
	public void setSpamt(BigDecimal spamt) {
		this.spamt = spamt;
	}
	

	
}
