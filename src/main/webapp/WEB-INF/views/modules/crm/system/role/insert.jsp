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
<sys:alertbar data="${alertInfo}"/>
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
                <label class="col-sm-1 col-md-offset-2">角色编码：</label>
                <div class="col-sm-1">
                    <form:input path="code" class="" required="true" />
                </div>
            </div>

            <br>
            <div class="row">
                <label class="col-sm-1 col-md-offset-2">角色名称：</label>
                <div class="col-sm-1">
                    <form:input path="name" class="" required="true" />
                </div>
            </div>
            <br>
            <div class="row">
                <label class="col-sm-1 col-md-offset-2">角色描述：</label>
                <div class="col-sm-1">
                    <form:input path="descript" class="" required="true" />
                </div>
            </div>
            <br>
            <div class="row">
                    <label class="col-sm-1 col-md-offset-2">系统角色：</label>
                    <div class="col-sm-8">
                        <form:radiobuttons path="sysflag" items="${sysFlag}"
                                           delimiter="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                                           labelCssClass="radio-inline" />
                    </div>
            </div>
            <br>
            <div class="row">
                    <label class="col-sm-1 col-md-offset-2">角色类型：</label>
                    <div class="col-sm-1">
                        <select id="roletype" name="roletype"
                                style="width:210px;height:26.96px">
                            <c:forEach items="${ROLE_TYPE}" var="roletype">
                                <option value="${roletype.code}">${roletype.name}</option>
                            </c:forEach>
                        </select>
                    </div>
            </div>
            <br>
            <div class="row">
                    <label class="col-sm-1 col-md-offset-2">是否启用：</label>
                    <div class="col-sm-1">
                        <form:radiobuttons path="reserved" items="${roleStatus}"
                                           delimiter="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                                           labelCssClass="radio-inline" />
                    </div>
                </div>
            </div>
            <br>
            <div class="row">
                    <label class="col-sm-1 col-md-offset-2" >所属机构：</label>
                    <div class="col-sm-10" style="width:890px;height:26.96px">
                        <div class='input-group date' id='office_dr'>
                            </label>
                            <sys:treeselect id="office" name="office.id" value="${office.id}" labelName="office.name" labelValue="${role.office.name}"
                                            title="公司" url="/sys/office/treeData?type=1" cssClass="required"/>

                        </div>
                    </div>
            </div>

        </div>
    </div>

    <hr>
    <div class="container-fluid">
        <div class="row-fluid ">
            <div class="row">


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
