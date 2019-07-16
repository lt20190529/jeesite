package com.thinkgem.jeesite.modules.Drug.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.erpuom.entity.ErpUom;

public class Drug extends DataEntity<Drug> {

	/**
	 * 药品实体类
	 */
	private static long serialVersionUID = 1L;
	
	private String Drug_id;
	private String Drug_Code;
	private String Drug_Desc;
	private String Drug_Spec;
	private String Drug_Class_Dr;
	private String Drug_Cat_Dr;
	private ErpUom Drug_Uom;
	private String Drug_BarCode;
	private String Drug_Alias;
	
	private String Drug_Rp;
	private String Drug_Sp;
	private Boolean Drug_BaseDrugFlag;
	private Boolean Drug_ActiveFlag;

	
	public Drug() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Drug(String id) {
		super(id);
		// TODO Auto-generated constructor stub
	}
	public String getDrug_id() {
		return Drug_id;
	}
	public void setDrug_id(String drug_id) {
		Drug_id = drug_id;
	}
	public String getDrug_Code() {
		return Drug_Code;
	}
	public void setDrug_Code(String drug_Code) {
		Drug_Code = drug_Code;
	}
	public String getDrug_Desc() {
		return Drug_Desc;
	}
	public void setDrug_Desc(String drug_Desc) {
		Drug_Desc = drug_Desc;
	}
	public String getDrug_Spec() {
		return Drug_Spec;
	}
	public void setDrug_Spec(String drug_Spec) {
		Drug_Spec = drug_Spec;
	}
	
	
	public String getDrug_Class_Dr() {
		return Drug_Class_Dr;
	}
	public void setDrug_Class_Dr(String drug_Class_Dr) {
		Drug_Class_Dr = drug_Class_Dr;
	}
	public String getDrug_Cat_Dr() {
		return Drug_Cat_Dr;
	}
	public void setDrug_Cat_Dr(String drug_Cat_Dr) {
		Drug_Cat_Dr = drug_Cat_Dr;
	}
	public ErpUom getDrug_Uom() {
		return Drug_Uom;
	}
	public void setDrug_Uom(ErpUom drug_Uom) {
		Drug_Uom = drug_Uom;
	}
	public String getDrug_BarCode() {
		return Drug_BarCode;
	}
	public void setDrug_BarCode(String drug_BarCode) {
		Drug_BarCode = drug_BarCode;
	}
	public String getDrug_Rp() {
		return Drug_Rp;
	}
	public void setDrug_Rp(String drug_Rp) {
		Drug_Rp = drug_Rp;
	}
	public String getDrug_Sp() {
		return Drug_Sp;
	}
	public void setDrug_Sp(String drug_Sp) {
		Drug_Sp = drug_Sp;
	}
	public Boolean getDrug_BaseDrugFlag() {
		return Drug_BaseDrugFlag;
	}
	public void setDrug_BaseDrugFlag(Boolean drug_BaseDrugFlag) {
		Drug_BaseDrugFlag = drug_BaseDrugFlag;
	}
	public Boolean getDrug_ActiveFlag() {
		return Drug_ActiveFlag;
	}
	public void setDrug_ActiveFlag(Boolean drug_ActiveFlag) {
		Drug_ActiveFlag = drug_ActiveFlag;
	}
	public String getDrug_Alias() {
		return Drug_Alias;
	}
	public void setDrug_Alias(String drug_Alias) {
		Drug_Alias = drug_Alias;
	}
	@Override
	public String toString() {
		return "Drug [Drug_id=" + Drug_id + ", Drug_Code=" + Drug_Code
				+ ", Drug_Desc=" + Drug_Desc + ", Drug_Spec=" + Drug_Spec
				+ ", Drug_Class_Dr=" + Drug_Class_Dr + ", Drug_Cat_Dr="
				+ Drug_Cat_Dr + ", Drug_Uom=" + Drug_Uom + ", Drug_BarCode="
				+ Drug_BarCode + ", Drug_Alias=" + Drug_Alias + ", Drug_Rp="
				+ Drug_Rp + ", Drug_Sp=" + Drug_Sp + ", Drug_BaseDrugFlag="
				+ Drug_BaseDrugFlag + ", Drug_ActiveFlag=" + Drug_ActiveFlag
				+ "]";
	}
	
	
	
	
    
}
