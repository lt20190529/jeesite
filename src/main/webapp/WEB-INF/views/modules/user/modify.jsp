<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sino" tagdir="/WEB-INF/tags/sys"%>
<c:set var="ctx" value="${pageContext.request.contextPath}${fns:getAdminPath()}" />
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static" />
<html>
  <head>
      <title> 修改用户基本信息</title>
      <meta name="decorator" content="default" />
      <style>
          .container-fluid {
              padding-right: 10px;
              padding-left: 10px;
          }

          .modal.fade.in {
              left: 500px;
              overflow：hidden
          }

      </style>

      <link
              href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
              type="text/css" rel="stylesheet" />
      <link rel="stylesheet"
            href="${ctxStatic}/jquery-easyui/themes/default/easyui.css"
            type="text/css" />
      <link rel="stylesheet"
            href="${ctxStatic}/font-awesome-4.7.0/css/font-awesome.min.css"
            type="text/css" />

  </head>
  
  <body>
      <sino:alertbar data="${alertInfo}"/>
      <form:form id="flexDetailModify" class="form-horizontal" role="form"
           action="${ctx}/sysmgr/user/modify" method="post" modelAttribute="sysUser">
          <ul class="nav nav-tabs-title">
              <li class="active"><span><i class="fa fa-wpforms"></i> 修改用户</span></li>
          </ul>

      <div class="container-fluid">
          <div class="row-fluid ">
          <div class="row">
              <label class="col-sm-4">登录名：</label>
              <div class="col-sm-8">
                  <form:input path="loginName" class="" required="true" />
              </div>
          </div>
          <div class="row">
              <label class="col-sm-4">登录名：</label>
              <div class="col-sm-8">
                  <form:input path="displayName" class="" required="true" />
              </div>
          </div>
          <br>

          <div class="row">
              <div class="col-md-3 col-md-offset-8 form-inline">
                  <button type="submit" class="btn btn-warning"><i class="fa fa-floppy-o"></i>&nbsp;&nbsp;保 存</button>
              </div>
          </div>
          </div>
      </div>
      </form:form>
  </body>
</html>
