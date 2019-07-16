/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erpvendor.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 供应商维护Entity
 * @author lt
 * @version 2018-09-20
 */
public class ErpVendor extends DataEntity<ErpVendor> {
	
	private static final long serialVersionUID = 1L;
	private String vendorCode;		// 供货商编码
	private String vendorDesc;		// 供货商描述
	private String vendorTel;		// 供货商电话
	private String vendorMan;		// 联系人
	private String vendorAddress;		// 地址
	private String vendorNote1;		// 备用1
	private String vendorNote2;		// 备用2
	private String vendorNote3;		// 备用3
	
	public ErpVendor() {
		super();
	}

	public ErpVendor(String id){
		super(id);
	}

	
	
	@Length(min=1, max=50, message="供货商编码长度必须介于 1 和 50 之间")
	public String getVendorCode() {
		return vendorCode;
	}

	public void setVendorCode(String vendorCode) {
		this.vendorCode = vendorCode;
	}
	
	@Length(min=1, max=50, message="供货商描述长度必须介于 1 和 50 之间")
	public String getVendorDesc() {
		return vendorDesc;
	}

	public void setVendorDesc(String vendorDesc) {
		this.vendorDesc = vendorDesc;
	}
	
	@Length(min=0, max=20, message="供货商电话长度必须介于 0 和 20 之间")
	public String getVendorTel() {
		return vendorTel;
	}

	public void setVendorTel(String vendorTel) {
		this.vendorTel = vendorTel;
	}
	
	@Length(min=0, max=20, message="联系人长度必须介于 0 和 20 之间")
	public String getVendorMan() {
		return vendorMan;
	}

	public void setVendorMan(String vendorMan) {
		this.vendorMan = vendorMan;
	}
	
	@Length(min=0, max=64, message="地址长度必须介于 0 和 64 之间")
	public String getVendorAddress() {
		return vendorAddress;
	}

	public void setVendorAddress(String vendorAddress) {
		this.vendorAddress = vendorAddress;
	}
	
	@Length(min=0, max=10, message="备用1长度必须介于 0 和 10 之间")
	public String getVendorNote1() {
		return vendorNote1;
	}

	public void setVendorNote1(String vendorNote1) {
		this.vendorNote1 = vendorNote1;
	}
	
	@Length(min=0, max=10, message="备用2长度必须介于 0 和 10 之间")
	public String getVendorNote2() {
		return vendorNote2;
	}

	public void setVendorNote2(String vendorNote2) {
		this.vendorNote2 = vendorNote2;
	}
	
	@Length(min=0, max=10, message="备用3长度必须介于 0 和 10 之间")
	public String getVendorNote3() {
		return vendorNote3;
	}

	public void setVendorNote3(String vendorNote3) {
		this.vendorNote3 = vendorNote3;
	}
	
}