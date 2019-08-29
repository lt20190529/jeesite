package com.thinkgem.jeesite.modules.crm.system.role.entity;

import java.util.UUID;

public class SysRole {
	  public static final String ROLE_PERFIX = "ROLE_";
	    private long id;
	    private String code;
	    private String name;
	    private String descript;
	    private boolean reserved;
	    private String reserved1;
	    private String companyId;//add(zbw)
	    private int companyRoleId;//
	    private String uuid;
	    private String companyName;
	    private String tenantId;
	    private String tenantName;
	    private String checked;

	    private int userId;

	    private Integer oldRoleId;


	    public SysRole() {
	        String str = UUID.randomUUID().toString();
	        String temp = str.substring(0, 8) + str.substring(9, 13) + str.substring(14, 18) + str.substring(19, 23) + str.substring(24);
	        this.uuid = temp;
	    }

	    public long getId() {
	        return id;
	    }

	    public void setId(long id) {
	        this.id = id;
	    }

	    public String getCode() {
	        return code;
	    }

	    public void setCode(String code) {
	        this.code = code;
	    }

	    /**
	     * 获取带ROLE_前缀的角色代码
	     *
	     * @return 获取带ROLE_前缀的角色代码, 如ROLE_ADMIN
	     */
	    public String getPrefixedCode() {
	        return ROLE_PERFIX + code;
	    }

	    public String getName() {
	        return name;
	    }

	    public void setName(String name) {
	        this.name = name;
	    }

	    public String getDescript() {
	        return descript;
	    }

	    public void setDescript(String descript) {
	        this.descript = descript;
	    }


	    public boolean isReserved() {
	        return reserved;
	    }

	    public void setReserved(boolean reserved) {
	        this.reserved = reserved;
	    }

	    public String getCompanyId() {
	        return companyId;
	    }

	    public void setCompanyId(String companyId) {
	        this.companyId = companyId;
	    }

	    public int getCompanyRoleId() {
	        return companyRoleId;
	    }

	    public void setCompanyRoleId(int companyRoleId) {
	        this.companyRoleId = companyRoleId;
	    }

	    public String getUuid() {
	        return uuid;
	    }

	    public void setUuid(String uuid) {
	        this.uuid = uuid;
	    }

	    public String getCompanyName() {
	        return companyName;
	    }

	    public void setCompanyName(String companyName) {
	        this.companyName = companyName;
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

	    public int getUserId() {
	        return userId;
	    }

	    public void setUserId(int userId) {
	        this.userId = userId;
	    }

	    public String getReserved1() {
	        return reserved1;
	    }

	    public void setReserved1(String reserved1) {
	        this.reserved1 = reserved1;
	    }

	    public String getChecked() {
	        return checked;
	    }

	    public void setChecked(String checked) {
	        this.checked = checked;
	    }

	    public Integer getOldRoleId() {
	        return oldRoleId;
	    }

	    public void setOldRoleId(Integer oldRoleId) {
	        this.oldRoleId = oldRoleId;
	    }

}
