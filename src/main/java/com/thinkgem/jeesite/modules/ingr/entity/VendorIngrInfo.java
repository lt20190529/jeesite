package com.thinkgem.jeesite.modules.ingr.entity;

import java.util.List;

public class VendorIngrInfo {

    private String id;
    private String vendorCode;		// 供货商编码
    private String vendorDesc;		// 供货商描述

    private List<Ingr> ingrList;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getVendorCode() {
        return vendorCode;
    }

    public void setVendorCode(String vendorCode) {
        this.vendorCode = vendorCode;
    }

    public String getVendorDesc() {
        return vendorDesc;
    }

    public void setVendorDesc(String vendorDesc) {
        this.vendorDesc = vendorDesc;
    }

    public List<Ingr> getIngrList() {
        return ingrList;
    }

    public void setIngrList(List<Ingr> ingrList) {
        this.ingrList = ingrList;
    }

    @Override
    public String toString() {
        return "VendorIngrInfo{" +
                "id='" + id + '\'' +
                ", vendorCode='" + vendorCode + '\'' +
                ", vendorDesc='" + vendorDesc + '\'' +
                ", ingrList=" + ingrList +
                '}';
    }
}
