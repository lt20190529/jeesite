<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sino" tagdir="/WEB-INF/tags/sys"%>
<c:set var="ctx" value="${pageContext.request.contextPath}${fns:getAdminPath()}" />
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static" />

<html>
  <head>
    <title>基础数据-字典维护</title>
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
.nav-tabs-title {
  margin-top: 10px;
  margin-bottom: 10px;
  line-height: normal;
  border-bottom: 1px solid #ddd;
}
</style>

<link
	href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	type="text/css" rel="stylesheet" />
<link rel="stylesheet"
	href="${ctxStatic}/jquery-easyui/themes/default/easyui.css"
	type="text/css" />
  </head>
  
  <body>
   <c:if test="${not empty message}">
	 <div class="alert alert-success alert-dismissible" role="alert">
	    <button type="button" class="close" data-dismiss="alert">
	        <span aria-hidden="true">&times;</span>
	        <span class="sr-only">Close</span>
	    </button>
	    <strong>消息:</strong>${message}
	 </div>
   </c:if>
	<form:form id="queryParamsForm" class="form-horizontal" role="form"
		action="${ctx}/sysmgr/flex/flexDetail/${setId}/${reserved}" method="post"
		modelAttribute="flexValue">
		<div class="container-fluid">
			<div class="row-fluid ">
			  <br>
				<div class="row">
					<div class="col-md-12">
						<ul class="nav nav-tabs-title">
			                <li class="active"><span><i class="fa fa-file-text"></i> 字典分类明细</span></li>
			                <li class="buttons">
				                
		                            <%--只能操作自己创建的--%>
		                        <a href="${ctx}/sysmgr/flex/flexDetailInsert/${setId}?reserved=${reserved}" type="button" class="btn btn-primary btn-sm" ><i class="fa fa-plus-circle"></i>新增</a>
		                        
								<a  type="button" class="btn btn-primary btn-sm" href="${ctx}/sysmgr/flex"><i class="fa fa-undo"></i>返回</a>
							</li>
			            </ul>
					</div>
				</div>
				<br>
			    <div class="table-responsive box-table mb-20">
                <table class="table table-bordered table-striped table-hover">
                    <thead>
                        <tr>
                            <th class="col-sm-1">序号</th>
                            <th class="col-sm-2">明细代码</th>
                            <th class="col-sm-2">明细名称</th>
                            <th class="col-sm-4">明细描述</th>
                            <th class="col-sm-1">状态</th>
                            <th class="col-sm-2">操作</th>
                        </tr>
                    </thead>
                    <tbody>

                    <c:forEach items="${flexValue}" var="flexValue" varStatus="status">
                    <tr>
                        <td style="text-align:center">${status.index + 1}</td>
                        <td style="text-align:center">${flexValue.code}</td>
                        <td style="text-align:center">

                            <c:if test="${flexValue.istree=='Y'}">
                                <a href="${ctx}/sysmgr/flex/list?setId=${flexValue.id}&parentId=${flexValue.setId}">${flexValue.name}</a>
                            </c:if>
                            <c:if test="${flexValue.istree=='N'}">
                                ${flexValue.name}
                            </c:if>
                        </td>
                        <td style="text-align:center">${flexValue.description}</td>
                        <td class="text-center">
                            <c:choose>
                                <c:when test="${flexValue.enable =='Y'}">启用</c:when>
                                <c:otherwise>禁用</c:otherwise>
                            </c:choose>
                        </td>
                        <td style="text-align:center">
                            <%-- <c:if test="${userId==1?(reserved=='Y'):(curTenantId==flexValue.tenantId)}"> --%>
                                <%--只能操作自己创建的--%>
                                <a href="${ctx}/sysmgr/flex/flexDetailModify/${flexValue.id}/${setId}?reserved=${reserved}">
                                    <i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp;修改</a>
                                <a href="${ctx}/sysmgr/flex/flexValueDelete/${flexValue.id}/${setId}">
                                    <i class="fa fa-trash" aria-hidden="true"></i>&nbsp;删除</a>
                                <a href="${ctx}/sysmgr/flex/toggleValueStatus/${flexValue.code}/${flexValue.setId}">
                                    <c:choose>
                                        <c:when test="${flexValue.enable =='Y'}">
                                            <i class="fa fa-ban" aria-hidden="true"></i>&nbsp;禁用
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fa fa-sign-in" aria-hidden="true"></i>&nbsp;启用
                                        </c:otherwise>
                                    </c:choose>
                                </a>
                            <%-- </c:if> --%>
                        </td>
                    </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <sino:pagination paginator="${flexValuePaginator}" formId="queryParamsForm"/>
            </div>
			</div>
		</div>
	</form:form>
  </body>
</html>
