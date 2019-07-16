<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>厂家维护管理</title>
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
		<li class="active"><a href="${ctx}/erpmanf/erpManf/">厂家维护列表</a></li>
		<shiro:hasPermission name="erpmanf:erpManf:edit"><li><a href="${ctx}/erpmanf/erpManf/form">厂家维护添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="erpManf" action="${ctx}/erpmanf/erpManf/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>厂家编码：</label>
				<form:input path="manfCode" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>厂家名称：</label>
				<form:input path="manfDesc" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>厂家电话：</label>
				<form:input path="manfTel" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>厂家联系人：</label>
				<form:input path="manfMan" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>厂家地址：</label>
				<form:input path="manfAddress" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>主键</th>
				<th>厂家编码</th>
				<th>厂家名称</th>
				<th>厂家电话</th>
				<th>厂家联系人</th>
				<th>厂家地址</th>
				
				<th>创建者</th>
				<th>创建时间</th>
				<th>更新者</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<th>删除标记</th>
				<shiro:hasPermission name="erpmanf:erpManf:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erpManf">
			<tr>
				<td><a href="${ctx}/erpmanf/erpManf/form?id=${erpManf.id}">
					${erpManf.id}
				</a></td>
				<td>
					${erpManf.manfCode}
				</td>
				<td>
					${erpManf.manfDesc}
				</td>
				<td>
					${erpManf.manfTel}
				</td>
				<td>
					${erpManf.manfMan}
				</td>
				<td>
					${erpManf.manfAddress}
				</td>
				<td>
					${erpManf.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${erpManf.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${erpManf.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${erpManf.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${erpManf.remarks}
				</td>
				<td>
					${fns:getDictLabel(erpManf.delFlag, 'del_flag', '')}
				</td>
				<shiro:hasPermission name="erpmanf:erpManf:edit"><td>
    				<a href="${ctx}/erpmanf/erpManf/form?id=${erpManf.id}">修改</a>
					<a href="${ctx}/erpmanf/erpManf/delete?id=${erpManf.id}" onclick="return confirmx('确认要删除该厂家维护吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>