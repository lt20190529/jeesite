<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sino" tagdir="/WEB-INF/tags/sys"%>
<c:set var="ctx" value="${pageContext.request.contextPath}${fns:getAdminPath()}" />
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static" />
<html>
<head>
    <title>新增字典分类</title>
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
  <div class="container">
  <div class="row">
  <ul class="nav nav-tabs-title">
	  <li class="active"><span><i class="fa fa-file-text"></i> 新增字典分类</span></li>
  </ul> 

  <form:form id="queryParamsForm" class="form-horizontal" role="form"
		action="${ctx}/sysmgr/flex/insert" method="post" modelAttribute="flexSet">
		<br>
        <br>
		<div class="container-fluid">
			<div class="row-fluid ">
		        <%-- <input type="hidden" id="userId" name="userId" value="<%=UserUtils.getUser()%>"/> --%>
                <input type="hidden" name="treeFlag" value="${treeFlag}"/>
                <div class="col-xs-12 col-sm-11 col-md-11">
                   <div class="row">
                      <div class="col-md-6 form-inline">
						   分类编码：<input class="input-large" type="text" id="code" name="code" />
                      </div>
                      <div class="col-md-6 form-inline">
						   分类名称：<input class="input-large" type="text" id="name" name="name" />
                      </div>
                    </div>
                    <br>
                    <div class="row">
                      <div class="col-md-6 form-inline">
						   分类描述：<input class="input-large" type="text" id="description" name="description" />
                      </div>
                      <div class="col-md-6 form-inline">
						  是否树形：
						 <label class="radio-inline"> <input type="radio"
							name="istree" id="opt1" value="Y" checked>是
						 </label> <label class="radio-inline"> <input type="radio"
							name="istree" id="opt2" value="N">否
						</label>
                      </div>
                     </div>
                     <br>
                     <br>
                     <br>
                     <div class="row"> 
                      <div class="col-md-3 col-md-offset-8 form-inline">
                         <button type="submit" class="btn btn-warning"><i class="fa fa-floppy-o"></i>&nbsp;&nbsp;保 存</button>
                          <c:if test="${treeFlag!='Y'}">
                              <button type="button" class="btn btn-default" onclick="history.back();"><i
                                      class="fa fa-undo"></i>&nbsp;&nbsp;返 回
                              </button>
                          </c:if>
                          <c:if test="${treeFlag=='Y'}">
                              <button type="button" class="btn btn-default" onclick="window.location.href='${ctx}/sysmgr/anotherFlex'"><i
                                      class="fa fa-undo"></i>&nbsp;&nbsp;返 回
                              </button>
                          </c:if>
                      </div>
                      
                   </div>
                </div>
			</div>
		</div>
	</form:form>
   </div>
   </div>
  </body>
</html>
