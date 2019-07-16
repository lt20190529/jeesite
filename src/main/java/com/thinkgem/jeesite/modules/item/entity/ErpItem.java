/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.item.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.erpuom.entity.ErpUom;

/**
 * 字典维护Entity
 * @author lxt
 * @version 2018-08-06
 */
public class ErpItem extends DataEntity<ErpItem> {
	
	private static final long serialVersionUID = 1L;
	private String itemNo;		// 商品编码
	private String itemDesc;		// 商品名称
	private String itemSpec;		// 规格
	private String itemSp;		// 售价
	private ErpUom erpUom;		// 单位
	private String itemBrevitycode;  //简码
	
	public ErpItem() {
		super();
	}

	public ErpItem(String id){
		super(id);
	}

	@Length(min=1, max=50, message="商品编码长度必须介于 1 和 50 之间")
	public String getItemNo() {
		return itemNo;
	}

	public void setItemNo(String itemNo) {
		this.itemNo = itemNo;
	}
	
	@Length(min=1, max=50, message="商品名称长度必须介于 1 和 50 之间")
	public String getItemDesc() {
		return itemDesc;
	}

	public void setItemDesc(String itemDesc) {
		this.itemDesc = itemDesc;
	}
	
	@Length(min=1, max=20, message="规格长度必须介于 1 和 20 之间")
	public String getItemSpec() {
		return itemSpec;
	}

	public void setItemSpec(String itemSpec) {
		this.itemSpec = itemSpec;
	}
	
	public String getItemSp() {
		return itemSp;
	}

	public void setItemSp(String itemSp) {
		this.itemSp = itemSp;
	}

	public ErpUom getErpUom() {
		return erpUom;
	}

	public void setErpUom(ErpUom erpUom) {
		this.erpUom = erpUom;
	}

	

	public String getItemBrevitycode() {
		return itemBrevitycode;
	}

	public void setItemBrevitycode(String itemBrevitycode) {
		this.itemBrevitycode = itemBrevitycode;
	}

	@Override
	public String toString() {
		return "ErpItem [itemNo=" + itemNo + ", itemDesc=" + itemDesc
				+ ", itemSpec=" + itemSpec + ", itemSp=" + itemSp + ", erpUom="
				+ erpUom + ", itemBrevitycode=" + itemBrevitycode + "]";
	}

	
}