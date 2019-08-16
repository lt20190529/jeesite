<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sino" tagdir="/WEB-INF/tags/sys"%>
<c:set var="ctx" value="${pageContext.request.contextPath}${fns:getAdminPath()}" />
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static" />
<html>
<head>
    <title> 修改字典分类明细</title>
    <meta name="decorator" content="default" />
	<style>
	.container-fluid {
		padding-right: 10px;
		padding-left: 10px;
	}
	
	.modal.fade.in {
		left: 500px;
		overflow:hidden
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

  <form:form id="flexDetailModify" class="form-horizontal" role="form"
		action="${ctx}/sysmgr/flex/flexDetailModify?reserved=${reserved}" method="post" modelAttribute="flexValue">
 
          
          <br>
		  <div class="container-fluid">
				<div class="row-fluid ">
				<div class="row">
					<div class="col-md-11">
						<ul class="nav nav-tabs-title">
			                <li class="active"><span><i class="fa fa-gear"></i>  修改字典分类明细</span></li>值集:${flexSet.name}
			            </ul>
					</div>
                </div>
                
                <br>
				<div class="col-xs-12 col-sm-11 col-md-11">
				         <input type="hidden" name="id" value="${flexValue.id}"/>
		                 <input type="hidden" name="treeFlag" value="${treeFlag}"/>
	                     <div class="row">
		                      <div class="col-md-6 form-inline">
								   明细编码：<input class="input-large" type="text" id="code" name="code" 
								    value="${flexValue.code}" />
		                      </div>
		                      <div class="col-md-6 form-inline">
								  明细名称：<input class="input-large" type="text" id="name" name="name" 
								   value="${flexValue.name}" />
		                      </div>
	                     </div>
	                     <br>
	                     <div class="row">
		                      <div class="col-md-6 form-inline">
								   明细描述：<input class="input-large" type="text" id="description" name="description" 
								   value="${flexValue.description}" />
		                      </div>
		                      <div class="col-md-6 form-inline" hidden="hidden">
								   setId：<input class="input-large" type="text" id="setId" name="setId" 
								   value="${flexValue.setId}" />
		                      </div>
	                     </div>
	                     <hr>
	                     <div class="row"> 
	                      <div class="col-md-3 col-md-offset-8 form-inline">
	                          <button type="submit" class="btn btn-warning"><i class="fa fa-floppy-o"></i>&nbsp;&nbsp;保 存</button>
	                          <button type="button" class="btn btn-default" onclick="history.back();"><i
	                                  class="fa fa-undo"></i>&nbsp;&nbsp;返 回
	                          </button>
	                          
	                      </div>   
	                   </div>
	                </div>
				</div>
		  </div>	            
	</form:form>

  </body>
</html>

