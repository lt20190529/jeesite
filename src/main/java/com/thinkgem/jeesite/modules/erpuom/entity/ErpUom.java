/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erpuom.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 单位维护Entity
 * @author 单位维护
 * @version 2018-09-20
 */
public class ErpUom extends DataEntity<ErpUom> {
	
	private static final long serialVersionUID = 1L;
	
	private String erpUomcode;		// 单位编码
	private String erpUomdesc;		// 单位描述
	
	public ErpUom() {
		super();
	}

	public ErpUom(String id){
		super(id);
	}

	
	
	@Length(min=1, max=50, message="单位编码长度必须介于 1 和 50 之间")
	public String getErpUomcode() {
		return erpUomcode;
	}

	public void setErpUomcode(String erpUomcode) {
		this.erpUomcode = erpUomcode;
	}
	
	@Length(min=1, max=50, message="单位描述长度必须介于 1 和 50 之间")
	public String getErpUomdesc() {
		return erpUomdesc;
	}

	public void setErpUomdesc(String erpUomdesc) {
		this.erpUomdesc = erpUomdesc;
	}
	
}