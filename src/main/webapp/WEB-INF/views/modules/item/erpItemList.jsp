<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>字典维护管理</title>
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
		<li class="active"><a href="${ctx}/item/erpItem/">字典维护列表</a></li>
		<shiro:hasPermission name="item:erpItem:edit"><li><a href="${ctx}/item/erpItem/form">字典维护添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="erpItem" action="${ctx}/item/erpItem/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>商品编码：</label>
				<form:input path="itemNo" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>商品名称：</label>
				<form:input path="itemDesc" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<!-- <th>主键</th> -->
				<th>商品编码</th>
				<th>商品名称</th>
				<th>规格</th>
				<th>售价</th>
				<th>单位</th>
				<th>创建者</th>
				<th>创建时间</th>
				<th>更新者</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="item:erpItem:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erpItem">
			<tr>
				<%-- <td><a href="${ctx}/item/erpItem/form?id=${erpItem.id}">
					${erpItem.id}
				</a></td> --%>
				<td><a href="${ctx}/item/erpItem/form?id=${erpItem.id}">
					${erpItem.itemNo}
				</a></td>
				<td>
					${erpItem.itemDesc}
				</td>
				<td>
					${erpItem.itemSpec}
				</td>
				<td>
					${erpItem.itemSp}
				</td>
				<td>
					${erpItem.erpUom.erpUomdesc}
				</td>
				<td>
					${erpItem.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${erpItem.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${erpItem.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${erpItem.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${erpItem.remarks}
				</td>
				<shiro:hasPermission name="item:erpItem:edit"><td>
    				<a href="${ctx}/item/erpItem/form?id=${erpItem.id}">修改</a>
					<a href="${ctx}/item/erpItem/delete?id=${erpItem.id}" onclick="return confirmx('确认要删除该字典维护吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>