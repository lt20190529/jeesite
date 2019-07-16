/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.rec.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 入库Entity
 * @author lxt
 * @version 2018-07-26
 */
public class ErpRecdetailTmp extends DataEntity<ErpRecdetailTmp> {
	
	private static final long serialVersionUID = 1L;
	private String recid;		// 主表ID 父类
	private String item;		// 产品
	private String itemid;		// 产品id
	private String uom;		// 单位
	private String uomid;		// 单位
	private String qty;		// 数量
	private String sp;		// 价格
	
	public ErpRecdetailTmp() {
		super();
	}

	public ErpRecdetailTmp(String id){
		super(id);
	}

	
	
	

	public String getRecid() {
		return recid;
	}

	public void setRecid(String recid) {
		this.recid = recid;
	}

	@Length(min=0, max=50, message="产品长度必须介于 0 和 50 之间")
	public String getItem() {
		return item;
	}

	public void setItem(String item) {
		this.item = item;
	}
	
	@Length(min=0, max=64, message="单位长度必须介于 0 和 64 之间")
	public String getUom() {
		return uom;
	}

	public void setUom(String uom) {
		this.uom = uom;
	}
	
	@Length(min=0, max=100, message="数量长度必须介于 0 和 100 之间")
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

	public String getItemid() {
		return itemid;
	}

	public void setItemid(String itemid) {
		this.itemid = itemid;
	}

	public String getUomid() {
		return uomid;
	}

	public void setUomid(String uomid) {
		this.uomid = uomid;
	}

	@Override
	public String toString() {
		return "ErpRecdetailTmp [recid=" + recid + ", item=" + item
				+ ", itemid=" + itemid + ", uom=" + uom + ", uomid=" + uomid
				+ ", qty=" + qty + ", sp=" + sp + "]";
	}

	
	
	
}