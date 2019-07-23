package com.thinkgem.jeesite.common.utils;


public class AlertInfo {
    protected Type type;        //提示类型 success,info,warning,danger
    protected String title;     //提示标题
    protected String message;   //提示内容

    public enum Type{
        success,info,warning,danger
    }

    public AlertInfo() {
    }

    public AlertInfo(Type type, String title) {
        this.type = type;
        this.title = title;
    }

    public AlertInfo(Type type, String title, String message) {
        this.type = type;
        this.title = title;
        this.message = message;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
