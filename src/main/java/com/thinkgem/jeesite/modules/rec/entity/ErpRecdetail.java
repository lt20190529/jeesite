/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.rec.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.item.entity.ErpItem;
import com.thinkgem.jeesite.modules.sys.entity.Dict;

/**
 * 入库Entity
 * @author lxt
 * @version 2018-07-26
 */
public class ErpRecdetail extends DataEntity<ErpRecdetail> {
	
	private static final long serialVersionUID = 1L;
	private String recid;		// 主表ID 父类
	private ErpItem item;		// 产品
	private String uom;		// 单位
	private String qty;		// 数量
	private String sp;		// 价格
	
	public ErpRecdetail() {
		super();
	}

	public ErpRecdetail(String id){
		super(id);
	}


	public String getRecid() {
		return recid;
	}

	public void setRecid(String recid) {
		this.recid = recid;
	}

	
	
	public ErpItem getItem() {
		return item;
	}

	public void setItem(ErpItem item) {
		this.item = item;
	}

	

	

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

	@Override
	public String toString() {
		return "ErpRecdetail [recid=" + recid + ", item=" + item + ", uom="
				+ uom + ", qty=" + qty + ", sp=" + sp + "]";
	}

	

	

	

	
	
}