package com.thinkgem.jeesite.modules.crm.system.flex.entity;

import com.google.common.collect.Lists;

import java.util.List;

/**
 * 字典分类
 */
public class FlexSet {
    private String uuid;
    private int id;
    private String code;
    private String name;
    private String description;
    private String istree;
    private String reserved;
    private List<FlexValue> valueList;
    private String tenantId;
    private String tenantName;
    private String enableFlag;
    private int parentId;
    private int setId;

    private String treeFlag="";

    public FlexSet() {
        valueList = Lists.newArrayList();
    }

    public FlexSet(int id, String code, String name, String description) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.description = description;
        this.valueList = Lists.newArrayList();
    }


    public String getReserved() {
        return reserved;
    }

    public void setReserved(String reserved) {
        this.reserved = reserved;
    }

    public String getIstree() {
        return istree;
    }


    public void setIstree(String istree) {
        this.istree = istree;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<FlexValue> getValueList() {
        return valueList;
    }

    public void setValueList(List<FlexValue> valueList) {
        this.valueList = valueList;
    }

    public String getTenantId() {
        return tenantId;
    }

    public void setTenantId(String tenantId) {
        this.tenantId = tenantId;
    }

    public String getTenantName() {
        return tenantName;
    }

    public void setTenantName(String tenantName) {
        this.tenantName = tenantName;
    }

    public String getEnableFlag() {
        return enableFlag;
    }

    public void setEnableFlag(String enableFlag) {
        this.enableFlag = enableFlag;
    }

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

    public int getSetId() {
        return setId;
    }

    public void setSetId(int setId) {
        this.setId = setId;
    }

    public String getTreeFlag() {
        return treeFlag;
    }

    public void setTreeFlag(String treeFlag) {
        this.treeFlag = treeFlag;
    }
}
