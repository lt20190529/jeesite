package com.thinkgem.jeesite.modules.crm.system.flex.entity;

import java.util.ArrayList;
import java.util.List;

/**
 * 字典值
 */
public class FlexValue {
    protected String uuid;
    protected String setUuid;
    protected String parentUuid;
    protected int id;
    protected int setId;
    protected int parentId;
    protected String code;
    protected String fullCode;
    protected String name;
    protected String fullName;
    protected String description;
    protected boolean readEnable;
    protected boolean writeEnable;
    protected Integer flag;
    private int level;
    private FlexValue flexValue;
    private List<FlexValue> childFvs = new ArrayList<FlexValue>();
    private String enable;
    private String attr1;
    private String attr2;
    private String attr3;
    private String attr4;
    private String attr5;
    private String attr6;
    private String reserved;
    private String tenantId = "";
    private String istree;
    private String flexSetCode;

    private String treeFlag="";

    public String getTenantId() {
        return tenantId;
    }

    public void setTenantId(String tenantId) {
        this.tenantId = tenantId;
    }

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

    public String getAttr1() {
        return attr1;
    }

    public void setAttr1(String attr1) {
        this.attr1 = attr1;
    }

    public String getAttr2() {
        return attr2;
    }

    public void setAttr2(String attr2) {
        this.attr2 = attr2;
    }

    public String getAttr3() {
        return attr3;
    }

    public void setAttr3(String attr3) {
        this.attr3 = attr3;
    }

    public String getAttr4() {
        return attr4;
    }

    public void setAttr4(String attr4) {
        this.attr4 = attr4;
    }

    public String getAttr5() {
        return attr5;
    }

    public void setAttr5(String attr5) {
        this.attr5 = attr5;
    }

    public String getAttr6() {
        return attr6;
    }

    public void setAttr6(String attr6) {
        this.attr6 = attr6;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public String getParentUuid() {
        return parentUuid;
    }

    public void setParentUuid(String parentUuid) {
        this.parentUuid = parentUuid;
    }

    public FlexValue getFlexValue() {
        return flexValue;
    }

    public void setFlexValue(FlexValue flexValue) {
        this.flexValue = flexValue;
    }

    public List<FlexValue> getChildFvs() {
        return childFvs;
    }

    public void setChildFvs(List<FlexValue> childFvs) {
        this.childFvs = childFvs;
    }

    public Integer getFlag() {
        return flag;
    }

    public void setFlag(Integer flag) {
        this.flag = flag;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getSetUuid() {
        return setUuid;
    }

    public void setSetUuid(String setUuid) {
        this.setUuid = setUuid;
    }

    public FlexValue() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSetId() {
        return setId;
    }

    public void setSetId(int setId) {
        this.setId = setId;
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

    public String getFullCode() {
        return fullCode;
    }

    public void setFullCode(String fullCode) {
        this.fullCode = fullCode;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isReadEnable() {
        return readEnable;
    }

    public void setReadEnable(boolean readEnable) {
        this.readEnable = readEnable;
    }

    public boolean isWriteEnable() {
        return writeEnable;
    }

    public void setWriteEnable(boolean writeEnable) {
        this.writeEnable = writeEnable;
    }

    public String getReserved() {
        return reserved;
    }

    public void setReserved(String reserved) {
        this.reserved = reserved;
    }

    public String getEnable() {
        return enable;
    }

    public void setEnable(String enable) {
        this.enable = enable;
    }

    public String getIstree() {
        return istree;
    }

    public void setIstree(String istree) {
        this.istree = istree;
    }

    public String getFlexSetCode() {
        return flexSetCode;
    }

    public void setFlexSetCode(String flexSetCode) {
        this.flexSetCode = flexSetCode;
    }

    public String getTreeFlag() {
        return treeFlag;
    }

    public void setTreeFlag(String treeFlag) {
        this.treeFlag = treeFlag;
    }
}
