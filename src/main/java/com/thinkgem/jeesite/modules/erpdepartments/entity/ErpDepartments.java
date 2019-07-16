package com.thinkgem.jeesite.modules.erpdepartments.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;


public class ErpDepartments extends DataEntity<ErpDepartments>{
	
	
	private static final long serialVersionUID = 1L;
	private String departmentCode;		// 部门编码
	private String departmentDesc;		// 部门描述
	private String departmentTel;		// 部门电话
	private String departmentMan;		// 部门联系人
	private String departmentNote1;		// 备用1
	private String departmentNote2;		// 备用2
	private String departmentNote3;		// 备用3
	
	public ErpDepartments() {
		super();
	}

	public ErpDepartments(String id){
		super(id);
	}
	
	public String getDepartmentCode() {
		return departmentCode;
	}
	public void setDepartmentCode(String departmentCode) {
		this.departmentCode = departmentCode;
	}
	public String getDepartmentDesc() {
		return departmentDesc;
	}
	public void setDepartmentDesc(String departmentDesc) {
		this.departmentDesc = departmentDesc;
	}
	public String getDepartmentTel() {
		return departmentTel;
	}
	public void setDepartmentTel(String departmentTel) {
		this.departmentTel = departmentTel;
	}
	public String getDepartmentMan() {
		return departmentMan;
	}
	public void setDepartmentMan(String departmentMan) {
		this.departmentMan = departmentMan;
	}
	public String getDepartmentNote1() {
		return departmentNote1;
	}
	public void setDepartmentNote1(String departmentNote1) {
		this.departmentNote1 = departmentNote1;
	}
	public String getDepartmentNote2() {
		return departmentNote2;
	}
	public void setDepartmentNote2(String departmentNote2) {
		this.departmentNote2 = departmentNote2;
	}
	public String getDepartmentNote3() {
		return departmentNote3;
	}
	public void setDepartmentNote3(String departmentNote3) {
		this.departmentNote3 = departmentNote3;
	}
	
	

}
