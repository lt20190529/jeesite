<%@ tag pageEncoding="utf-8"%>
<%@ attribute name="data" type="com.thinkgem.jeesite.common.utils.AlertInfo" required="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%--
建议在控制层使用RedirectAttributes来传递提示信息
参数说明:
    data:com.sinoprof.core.entity.AlertInfo类型
作者:江再德
日期:2015.7.13
--%>

<%
    if(data==null) return;
%>
<div id="alexMessageDiv" class="alert alert-${data.type}" onclick="$('#alexMessageDiv').hide();"
     style="padding: 8px;margin-top:10px;margin-bottom: 10px;">
    <a href="#" class="close">&times;</a>
    <span class="glyphicon glyphicon-exclamation-sign"></span>
    <strong>${data.title}</strong>
    <div style="margin-left: 20px;">
        <span>${data.message}</span>
    </div>
</div>
