<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019-08-28
  Time: 14:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="ctx" value="${pageContext.request.contextPath}${fns:getAdminPath()}" />
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
    <title>角色列表</title>
    <link
            href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            type="text/css" rel="stylesheet" />
    <meta name="decorator" content="default" />
    <style>
        .container-fluid {
            padding-right: 10px;
            padding-left: 10px;
        }
    </style>
</head>
<body>
<form:form id="addrole" method="post" modelAttribute="role"
           class="form-horizontal" role="form" action="${ctx}/sysmgr/role/insert">
    <div class="container-fluid">
        <div class="row-fluid ">
            <div class="row">
                <div class="col-md-12">
                    <ul class="nav nav-tabs-title">
                        <li class="active"><span><i class="fa fa-gear"></i>  新增角色</span></li>

                    </ul>
                </div>
            </div>

            <br>

            <div class="row">
                <label class="col-sm-4 col-md-offset-2 form-inline">角色编码：</label>
                <div class="col-sm-4">
                    <form:input path="code" class="" required="true"/>
                </div>
            </div>
            <br>
            <div class="row">
                <label class="col-sm-4 col-md-offset-2 form-inline">角色名称：</label>
                <div class="col-sm-8">
                    <form:input path="name" class="" required="true"/>
                </div>
            </div>
            <br>
            <div class="row">
                <label class="col-sm-4 col-md-offset-2 form-inline">角色描述：</label>
                <div class="col-sm-8">
                    <form:input path="descript" class="" required="true"/>
                </div>
            </div>
            <br>
            <div class="row">
                <div class="col-md-6 col-md-offset-2 form-inline">
                    <label class="col-sm-4">系统角色：</label>
                    <%--<div class="col-sm-8">
                        <form:radiobuttons path="sysflag" items="${roleFlag}"
                                           delimiter="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                                           labelCssClass="radio-inline" />
                    </div>--%>
                </div>
            </div>
            <br>
            <div class="row">
                <div class="col-md-6 col-md-offset-2 form-inline">
                    <label class="col-sm-4">角色类型：</label>
                    <div class="col-sm-8">
                        <select id="userType" name="userType"
                                style="width:210px;height:26.96px">
                            <c:forEach items="${ROLE_TYPE}" var="role">
                                <option value="${role.code}">${role.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>
            <br>
            <div class="row">
                <div class="col-md-6 col-md-offset-2 form-inline">
                    <label class="col-sm-4">是否启用：</label>
                    <div class="col-sm-8">
                        <form:radiobuttons path="reserved" items="${roleStatus}"
                                           delimiter="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                                           labelCssClass="radio-inline" />
                    </div>
                </div>
            </div>
            <br>
            <div class="row">
                <div class="col-md-12 col-md-offset-2 form-inline">
                    <label class="col-sm-2 role" style="width:140.74px">所属机构：</label>
                    <div class="col-sm-10" style="width:890px;height:26.96px">
                        <div class='input-group date' id='companyD'>
                            </label>
                            <sys:treeselect id="companyID" name="companyID"
                                            value="companyID" labelName="company.name"
                                            labelValue="" title="公司"
                                            url="/sys/office/treeData?type=1" cssClass="input-large"  cssStyle="width:675px;height:26.96px"
                                            hideBtn="true" smallBtn="true" allowClear="true"  isAll="true"
                                            notAllowSelectParent="true" />

                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <hr>
    <div class="container-fluid">
        <div class="row-fluid ">
            <div class="row">

                <
                <div class="col-md-3 col-md-offset-3 form-inline">
                    <button type="submit" class="btn btn-warning"><i class="fa fa-floppy-o"></i>&nbsp;&nbsp;保 存</button>

                    <button type="button" class="btn btn-default" onclick="history.back();"><i
                            class="fa fa-undo"></i>&nbsp;&nbsp;返 回
                    </button>
                </div>
            </div>
        </div>
    </div>

</form:form>
</body>
</html>
