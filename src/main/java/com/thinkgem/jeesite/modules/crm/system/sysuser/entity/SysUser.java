package com.thinkgem.jeesite.modules.crm.system.sysuser.entity;

import com.google.common.collect.Lists;
import com.thinkgem.jeesite.modules.sys.entity.Office;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * 用户实体类
 */
public class SysUser {
    private String id;
    private String loginName;
    private String displayName;
    private String employeeNumber;
    private String password;
    private Date passwordModifyDate;
    private int loginErrorCount;

    private Date startDate;
    private Date endDate;

    private boolean enabled;

    private String mobile;
    private String email;
    private String fax;
    private String qq;
    private String officeTel;

    private List<String> roleList = Lists.newArrayList();
    private List<Office> groupList = Lists.newArrayList();

    private int primaryGroupID;

    private String companyID;
    private String officeID;

    private  String uuid;

    private String tenantName;
    private String groupName;
    private String companyName;

    private String roleId;
    private String tenantId;

    private String userType;
    private String userGrade;


    public SysUser(){
        this.enabled = true;
        this.startDate = new Date();

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(startDate);
        calendar.add(Calendar.YEAR,100);
        this.endDate = calendar.getTime();
        String str =UUID.randomUUID().toString();
        String temp = str.substring(0, 8) + str.substring(9, 13) + str.substring(14, 18) + str.substring(19, 23) + str.substring(24);
        this.uuid=temp;

    }

    public String getCompanyID() {
        return companyID;
    }

    public void setCompanyID(String companyID) {
        this.companyID = companyID;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getEmployeeNumber() {
        return employeeNumber;
    }

    public void setEmployeeNumber(String employeeNumber) {
        this.employeeNumber = employeeNumber;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getPasswordModifyDate() {
        return passwordModifyDate;
    }

    public void setPasswordModifyDate(Date passwordModifyDate) {
        this.passwordModifyDate = passwordModifyDate;
    }

    public int getLoginErrorCount() {
        return loginErrorCount;
    }

    public void setLoginErrorCount(int loginErrorCount) {
        this.loginErrorCount = loginErrorCount;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public String getOfficeTel() {
        return officeTel;
    }

    public void setOfficeTel(String officeTel) {
        this.officeTel = officeTel;
    }

    public List<String> getRoleList() {
        return roleList;
    }

    public void setRoleList(List<String> roleList) {
        this.roleList = roleList;
    }

    public List<Office> getGroupList() {
        return groupList;
    }

    public void setGroupList(List<Office> groupList) {
        this.groupList = groupList;
    }

    public int getPrimaryGroupID() {
        return primaryGroupID;
    }

    public void setPrimaryGroupID(int primaryGroupID) {
        this.primaryGroupID = primaryGroupID;
    }

    public String getOfficeID() {
        return officeID;
    }

    public void setOfficeID(String officeID) {
        this.officeID = officeID;
    }



    public String getTenantName() {
        return tenantName;
    }

    public void setTenantName(String tenantName) {
        this.tenantName = tenantName;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public String getTenantId() {
        return tenantId;
    }

    public void setTenantId(String tenantId) {
        this.tenantId = tenantId;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getUserGrade() {
        return userGrade;
    }

    public void setUserGrade(String userGrade) {
        this.userGrade = userGrade;
    }

    @Override
    public String toString() {
        return "SysUser{" +
                "id='" + id + '\'' +
                ", loginName='" + loginName + '\'' +
                ", displayName='" + displayName + '\'' +
                ", employeeNumber='" + employeeNumber + '\'' +
                ", password='" + password + '\'' +
                ", passwordModifyDate=" + passwordModifyDate +
                ", loginErrorCount=" + loginErrorCount +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", enabled=" + enabled +
                ", mobile='" + mobile + '\'' +
                ", email='" + email + '\'' +
                ", fax='" + fax + '\'' +
                ", qq='" + qq + '\'' +
                ", officeTel='" + officeTel + '\'' +
                ", roleList=" + roleList +
                ", groupList=" + groupList +
                ", primaryGroupID=" + primaryGroupID +
                ", companyID='" + companyID + '\'' +
                ", officeID='" + officeID + '\'' +
                ", uuid='" + uuid + '\'' +
                ", tenantName='" + tenantName + '\'' +
                ", groupName='" + groupName + '\'' +
                ", companyName='" + companyName + '\'' +
                ", roleId='" + roleId + '\'' +
                ", tenantId='" + tenantId + '\'' +
                ", userType='" + userType + '\'' +
                ", userGrade='" + userGrade + '\'' +
                '}';
    }
}
