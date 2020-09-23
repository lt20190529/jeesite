package com.thinkgem.jeesite.modules.drug.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

public class DrugVo extends DataEntity<DrugVo> {
	private Drug drug;

	public Drug getDrug() {
		return drug;
	}

	public void setDrug(Drug drug) {
		this.drug = drug;
	}
	
}
