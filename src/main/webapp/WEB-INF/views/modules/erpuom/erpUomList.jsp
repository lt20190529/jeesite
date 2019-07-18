<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单位维护管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/erpuom/erpUom/">单位维护列表</a></li>
		<shiro:hasPermission name="erpuom:erpUom:edit"><li><a href="${ctx}/erpuom/erpUom/form">单位维护添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="erpUom" action="${ctx}/erpuom/erpUom/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>单位编码：</label>
				<form:input path="erpUomcode" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>单位描述：</label>
				<form:input path="erpUomdesc" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>单位编码</th>
				<th>单位描述</th>
				<th>创建者</th>
				<th>创建时间</th>
				<th>更新者</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<th>删除标记</th>
				<shiro:hasPermission name="erpuom:erpUom:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erpUom">
			<tr>
				<td><a href="${ctx}/erpuom/erpUom/form?id=${erpUom.id}">
					${erpUom.erpUomcode}
				</a></td>
				<td>
					${erpUom.erpUomdesc}
				</td>
				<td>
					${erpUom.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${erpUom.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${erpUom.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${erpUom.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${erpUom.remarks}
				</td>
				<td>
					${fns:getDictLabel(erpUom.delFlag, 'del_flag', '')}
				</td>
				<shiro:hasPermission name="erpuom:erpUom:edit"><td>
    				<a href="${ctx}/erpuom/erpUom/form?id=${erpUom.id}">修改</a>
					<a href="${ctx}/erpuom/erpUom/delete?id=${erpUom.id}" onclick="return confirmx('确认要删除该单位维护吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>