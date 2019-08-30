package com.thinkgem.jeesite.modules.crm.system.role.entity;

import java.util.UUID;

public class SysRole {
    public static final String ROLE_PERFIX = "ROLE_";
    private long id;
    private String uuid;
    private String code;
    private String name;
    private String descript;
    private boolean reserved;
    private String roletype;
    private boolean sysflag;
    private String office_dr;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
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

    public String getRoletype() {
        return roletype;
    }

    public void setRoletype(String roletype) {
        this.roletype = roletype;
    }

    public boolean getSysflag() {
        return sysflag;
    }

    public void setSysflag(boolean sysflag) {
        this.sysflag = sysflag;
    }

    public String getOffice_dr() {
        return office_dr;
    }

    public void setOffice_dr(String office_dr) {
        this.office_dr = office_dr;
    }

    @Override
    public String toString() {
        return "SysRole{" +
                "id=" + id +
                ", uuid='" + uuid + '\'' +
                ", code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", descript='" + descript + '\'' +
                ", reserved=" + reserved +
                ", roletype='" + roletype + '\'' +
                ", sysflag='" + sysflag + '\'' +
                ", office_dr='" + office_dr + '\'' +
                '}';
    }
}
