<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
		action="${ctx}/sysmgr/flex/flexList" method="post"
		modelAttribute="flexSet">
		<div class="container-fluid">
			<div class="row-fluid ">
				<br>
				<div class="row">
					<div class="col-md-12">
						<ul class="nav nav-tabs-title">
			                <li class="active"><span><i class="fa fa-file-text"></i> 字典分类</span></li>
			                <li class="buttons">
				                <button type="submit" class="btn btn-warning btn-sm">
								<i class="fa fa-search"></i>&nbsp;&nbsp;查 询
								</button>
								<button type="button" class="btn btn-primary btn-sm">
									<i class="fa fa-bug"></i>&nbsp;&nbsp;清 屏
								</button>
							</li>
			            </ul>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="col-md-3 col-md-offset-1 form-inline">
						字典编码：<input class="input-large" type="text" name="code" />
					</div>
					<div class="col-md-3 form-inline">
						字典名称：<input class="input-large" type="text" name="name" />
					</div>
					<div class="col-md-3 col-md-offset-2 form-inline">
						

					</div>
				</div>
			</div>
			<br>

		</div>
		<div class="container-fluid">
			<div class="row-fluid ">
				<div class="row">
					<div class="col-md-12">
						<ul class="nav nav-tabs-title">
			                <li class="active"><span><i class="fa fa-file-text"></i> 检索结果</span></li>
			                <li class="buttons"><a href="${ctx}/sysmgr/flex/insert"
							class="btn btn-success btn-sm"><i class="fa fa-plus-circle"></i>&nbsp;&nbsp;添
								加</a></li>
			            </ul>
					</div>
					<br>
					<div class="col-md-offset-4 col-md-3">
						
					</div>
				</div>
				<br>
				<div class="row">
					<div class="table-responsive box-table mb-20">
						<table class="table table-bordered table-striped table-hover">
							<thead>
								<tr>
									<th style="text-align:center">序号</th>
									<th style="text-align:center">分类代码</th>
									<th style="text-align:center">分类名称</th>
									<th style="text-align:center">分类描述</th>
									<th style="text-align:center">是否树形</th>
									<th style="text-align:center">是否保留</th>
									<th style="text-align:center">租户名称</th>
									<th style="text-align:center">状态</th>
									<th style="text-align:center" width="280px">操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${flexSetList}" var="flexSet"
									varStatus="status">
									<tr>
										<td style="text-align:center">${status.index + 1}</td>
										<td style="text-align:center">${flexSet.code}</td>
										<td style="text-align:center"><a
											href="${ctx}/sysmgr/flex/flexDetail/${flexSet.id}/${flexSet.reserved}">${flexSet.name}</a>
										</td>
										<td style="text-align:center">${flexSet.description}</td>
										<td style="text-align:center">
											<c:if test="${flexSet.istree=='Y'}">
											   是
											</c:if> 
	                                        <c:if test="${flexSet.istree=='N'}"> 
	                                                                                                                            否
	                                        </c:if>
                                        </td>
										<td style="text-align:center">
											<c:if test="${flexSet.reserved=='Y'}">
	                                                                                                                                是
	                                        </c:if> 
	                                        <c:if test="${flexSet.reserved=='N'}">
	                                                                                                                               否
	                                        </c:if>
                                        </td>
										<td style="text-align:center">${flexSet.tenantName}</td>
										<td style="text-align:center"><c:choose>
												<c:when test="${flexSet.enableFlag =='Y'}">启用</c:when>
												<c:otherwise>禁用</c:otherwise>
											</c:choose></td>
										<td style="text-align:center"><c:choose>
												<c:when test="${flexSet.reserved=='Y'}">
													<sec:authorize access="hasRole('ROLE_ADMIN')">
														<a href="${ctx}/sysmgr/flex/modify/${flexSet.id}">
															<i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp;修改
														</a>
														<a href="${ctx}/sysmgr/flex/delete/${flexSet.id}">
															<i class="fa fa-trash" aria-hidden="true"></i>&nbsp;删除
														</a>
														<a href="${ctx}/sysmgr/flex/toggleStatus/${flexSet.id}"> 
														<c:choose>
																<c:when test="${flexSet.enableFlag =='Y'}">
																	<i class="fa fa-ban" aria-hidden="true"></i>&nbsp;禁用
                                                        </c:when>
																<c:otherwise>
																	<i class="fa fa-sign-in" aria-hidden="true"></i>&nbsp;启用
                                                        </c:otherwise>
															</c:choose>
														</a>
													</sec:authorize>
												</c:when>
												<c:when test="${flexSet.reserved=='N'}">
													<sec:authorize ifNotGranted="ROLE_ADMIN">
														<c:if test="${curTenantId==flexSet.tenantId}">
															<%--如果不是admin，那么自己只能操作自己创建的--%>
															<a href="${ctx}/sysmgr/flex/flexSetModify/${flexSet.id}">
																<i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp;修改
															</a>
															<a href="${ctx}/sysmgr/flex/flexSetDelete/${flexSet.id}">
																<i class="fa fa-trash" aria-hidden="true"></i>&nbsp;删除
															</a>
															
															
														</c:if>
													</sec:authorize>
												</c:when>
											</c:choose></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>


						<sys:pagination paginator="${flexSetListPaginator}" />
					</div>

				</div>
			</div>
		</div>

	</form:form>
<script type="text/javascript">

</script>
</body>
</html>
