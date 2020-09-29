package com.thinkgem.jeesite.modules.rec.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

public class ErpRecReport extends DataEntity<ErpRecDetail> {

    private String depid;
    private String depdesc;
    private Double amt;
    private int count;

    public ErpRecReport(String depid, String depdesc, Double amt, int count) {
        this.depid = depid;
        this.depdesc = depdesc;
        this.amt = amt;
        this.count = count;
    }

    public String getDepid() {
        return depid;
    }

    public void setDepid(String depid) {
        this.depid = depid;
    }

    public String getDepdesc() {
        return depdesc;
    }

    public void setDepdesc(String depdesc) {
        this.depdesc = depdesc;
    }

    public Double getAmt() {
        return amt;
    }

    public void setAmt(Double amt) {
        this.amt = amt;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}
