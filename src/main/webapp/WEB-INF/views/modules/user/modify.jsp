<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="sino" tagdir="/WEB-INF/tags/sys" %>
<c:set var="ctx" value="${pageContext.request.contextPath}${fns:getAdminPath()}"/>
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static"/>
<html>
<head>
    <title> 修改用户基本信息</title>
    <meta name="decorator" content="default"/>
    <style>
        .container-fluid {
            padding-right: 10px;
            padding-left: 10px;
        }

        .modal.fade.in {
            left: 500px;
            overflow：hidden
        }
        .vat {
            vertical-align: top
        }

        .container-fluid {
            padding-right: 10px;
            padding-left: 10px;
        }

        .row-fluid {
            padding-right: 30px;
            padding-left: 80px;
        }
    </style>

    <link
            href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            type="text/css" rel="stylesheet"/>
    <link rel="stylesheet"
          href="${ctxStatic}/jquery-easyui/themes/default/easyui.css"
          type="text/css"/>
    <link rel="stylesheet"
          href="${ctxStatic}/font-awesome-4.7.0/css/font-awesome.min.css"
          type="text/css"/>

</head>

<body>
<sino:alertbar data="${alertInfo}"/>
<form:form id="flexDetailModify" class="form-horizontal" role="form"
           action="${ctx}/sysmgr/user/modify" method="post" modelAttribute="sysUser">


<div class="container-fluid">
    <div class="row-fluid ">
        <div class="row">
            <div class="col-md-12">
                <ul class="nav nav-tabs-title">
                    <li class="active"><span><i class="fa fa-gear"></i>  修改用户</span></li>

                </ul>
            </div>
        </div>
        <br>
        <br>
        <div class="row">

            <div class="col-md-4 form-inline">
                <label class="col-sm-4">登录名：</label>
                <div class="col-sm-8">
                    <form:input path="loginName" class="" required="true"/>
                </div>
            </div>

            <div class="col-md-4 form-inline">
                <label class="col-sm-4">用户名：</label>
                <div class="col-sm-8">
                    <form:input path="displayName" class="" required="true"/>
                </div>
            </div>

            <div class="col-md-4 form-inline">
                <label class="col-sm-4">编码：</label>
                <div class="col-sm-8">
                    <form:input path="employeeNumber" class="" required="true"/>
                </div>
            </div>
        </div>
        <br>
        <br>

        <div class="row">

            <div class="col-md-4 form-inline">
                <label class="col-sm-4">手机：</label>
                <div class="col-sm-8">
                    <form:input path="mobile" class="" required="true"/>
                </div>
            </div>

            <div class="col-md-4 form-inline">
                <label class="col-sm-4">Email：</label>
                <div class="col-sm-8">
                    <form:input path="email" class="" required="true"/>
                </div>
            </div>

            <div class="col-md-4 form-inline">
                <label class="col-sm-4">传真：</label>
                <div class="col-sm-8">
                    <form:input path="fax" class="" required="true"/>
                </div>
            </div>
        </div>
        <br>
        <br>
        <div class="row">

            <div class="col-md-4 form-inline">
                <label class="col-sm-4">QQ：</label>
                <div class="col-sm-8">
                    <form:input path="qq" class="" required="true"/>
                </div>
            </div>

            <div class="col-md-4 form-inline">
                <label class="col-sm-4">办公电话：</label>
                <div class="col-sm-8">
                    <form:input path="officeTel" class="" required="true"/>
                </div>
            </div>

            <div class="col-md-4 form-inline">
                <label class="col-sm-4">用户类型：</label>
                <div class="col-sm-8">
                  <%--  <form:select path="userType" class="input-medium">
                        <form:options items="${USER_TYPE}" itemLabel="name"
                                      itemValue="code" htmlEscape="false" />
                    </form:select>--%>


                    <form:select ="userType" name="userType"
                            style="width:210px;height:26.96px">

                        <form:options items="${USER_TYPE}" itemLabel="name"
                                      itemValue="code" htmlEscape="false" />
                    </form:select>path
                </div>
            </div>
        </div>

        <br>
        <br>
        <div class="row">

            <div class="col-md-4 form-inline">
                <label class="col-sm-4">生效日期：</label>
                <div class="col-sm-8">
                    <div class='input-group date'>
                        <form:input path="startDate"  class="form-control" required="true"
                                    style="width:170px;height:26.96px" /> <span
                            class="input-group-addon"> <span
                            class="glyphicon glyphicon-calendar"></span>
							</span>
                    </div>
                </div>
            </div>

            <div class="col-md-4 form-inline">
                <label class="col-sm-4">失效日期：</label>
                <div class="col-sm-8">
                    <div class='input-group date'>
                        <form:input path="endDate" class="form-control" required="true"
                                    style="width:170px;height:26.96px" /> <span
                            class="input-group-addon"> <span
                            class="glyphicon glyphicon-calendar"></span>
							</span>
                    </div>
                </div>
            </div>

            <div class="col-md-4 form-inline">
                <label class="col-sm-4">是否启用：</label>
                <div class="col-sm-8">
                    <form:radiobuttons path="enabled" items="${userStatus}"
                                       delimiter="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                                       labelCssClass="radio-inline" />
                </div>
            </div>
        </div>

        <br>
        <br>
        <hr>


        <div class="col-md-12 form-inline">
            <label class="col-sm-2" style="width:140.74px">所属公司：</label>
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
        <br>
        <hr>

        <div class="col-md-12 form-inline">
            <label class="col-sm-2" style="width:140.74px">所属公司组别：</label>
            <div class="col-sm-10" >
                <div class='input-group date' id='officeD'>
                    </label>
                    <sys:treeselect id="groupList" name="groupList"
                                    value="groupList" labelName="office.name"
                                    labelValue="" title="组别"
                                    url="/sys/office/treeData?type=2" cssClass="input-large" cssStyle="width:675px;height:26.96px"
                                    hideBtn="true" smallBtn="true" allowClear="true"  isAll="true"  checked="true"
                                    notAllowSelectParent="true" />
                </div>
            </div>
        </div>

        <br> <br>

        <hr>
        <div class="col-md-12 form-inline">
            <label class="col-sm-1">角色：</label>
            <div class="col-sm-10 col-md-offset-0 text-left " style="">
                <c:forEach items="" var="roleList" varStatus="status">
                    <label style="vertical-align:middle;padding:0px 20px 0px 20px">
                        <input id= name="roleList" type="checkbox"
                               class="vertical-align:middle" style="zoom:140%;"
                               value="">
                    </label>
                </c:forEach>
            </div>
        </div>

        <br>

        <hr>
        <div class="row">


            <div class="row">
                <div class="col-md-3 col-md-offset-8 form-inline">
                    <button type="submit" class="btn btn-warning"><i class="fa fa-floppy-o"></i>&nbsp;&nbsp;保 存</button>
                    <a type="button" href="${ctx}/sysmgr/user/list?page=1"
                       class="btn btn-default"><i class="fa fa-undo"></i>返回列表</a>
                </div>
            </div>
        </div>
    </div>
    </form:form>
</body>
</html>
