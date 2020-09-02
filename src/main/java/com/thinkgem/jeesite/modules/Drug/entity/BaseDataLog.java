package com.thinkgem.jeesite.modules.Drug.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import java.util.Date;

public class BaseDataLog extends DataEntity<BaseDataLog> {

    private String type; 		// 日志类型（1：接入日志；2：错误日志）
    private String title;		// 日志标题
    private String remoteAddr; 	// 操作用户的IP地址
    private String requestUri; 	// 操作的URI
    private String method; 		// 操作的方式
    private String params; 		// 操作提交的数据
    private String userAgent;	// 操作用户代理信息
    private String exception; 	// 异常信息

    private Date beginDate;		// 开始日期
    private Date endDate;		// 结束日期
}
