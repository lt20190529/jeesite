/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erpmanf.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 厂家维护Entity
 * @author lt
 * @version 2018-10-30
 */
public class ErpManf extends DataEntity<ErpManf> {
	
	private static final long serialVersionUID = 1L;
	private String manfCode;		// 厂家编码
	private String manfDesc;		// 厂家名称
	private String manfTel;		// 厂家电话
	private String manfMan;		// 厂家联系人
	private String manfAddress;		// 厂家地址
	private String manfNote1;		// 备注1
	private String manfNote2;		// 备注1
	private String manfNote3;		// 备注1
	
	public ErpManf() {
		super();
	}

	public ErpManf(String id){
		super(id);
	}

	@Length(min=1, max=50, message="厂家编码长度必须介于 1 和 50 之间")
	public String getManfCode() {
		return manfCode;
	}

	public void setManfCode(String manfCode) {
		this.manfCode = manfCode;
	}
	
	@Length(min=1, max=50, message="厂家名称长度必须介于 1 和 50 之间")
	public String getManfDesc() {
		return manfDesc;
	}

	public void setManfDesc(String manfDesc) {
		this.manfDesc = manfDesc;
	}
	
	@Length(min=0, max=20, message="厂家电话长度必须介于 0 和 20 之间")
	public String getManfTel() {
		return manfTel;
	}

	public void setManfTel(String manfTel) {
		this.manfTel = manfTel;
	}
	
	@Length(min=0, max=20, message="厂家联系人长度必须介于 0 和 20 之间")
	public String getManfMan() {
		return manfMan;
	}

	public void setManfMan(String manfMan) {
		this.manfMan = manfMan;
	}
	
	@Length(min=0, max=64, message="厂家地址长度必须介于 0 和 64 之间")
	public String getManfAddress() {
		return manfAddress;
	}

	public void setManfAddress(String manfAddress) {
		this.manfAddress = manfAddress;
	}
	
	@Length(min=0, max=10, message="备注1长度必须介于 0 和 10 之间")
	public String getManfNote1() {
		return manfNote1;
	}

	public void setManfNote1(String manfNote1) {
		this.manfNote1 = manfNote1;
	}
	
	@Length(min=0, max=10, message="备注1长度必须介于 0 和 10 之间")
	public String getManfNote2() {
		return manfNote2;
	}

	public void setManfNote2(String manfNote2) {
		this.manfNote2 = manfNote2;
	}
	
	@Length(min=0, max=10, message="备注1长度必须介于 0 和 10 之间")
	public String getManfNote3() {
		return manfNote3;
	}

	public void setManfNote3(String manfNote3) {
		this.manfNote3 = manfNote3;
	}
	
}