<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商维护管理</title>
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
		<li class="active"><a href="${ctx}/erpvendor/erpVendor/">供应商维护列表</a></li>
		<shiro:hasPermission name="erpvendor:erpVendor:edit"><li><a href="${ctx}/erpvendor/erpVendor/form">供应商维护添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="erpVendor" action="${ctx}/erpvendor/erpVendor/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			
			<li><label>编码：</label>
				<form:input path="vendorCode" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>描述：</label>
				<form:input path="vendorDesc" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>电话：</label>
				<form:input path="vendorTel" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>联系人：</label>
				<form:input path="vendorMan" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>地址：</label>
				<form:input path="vendorAddress" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			
			<li><label>创建者：</label>
				<form:input path="createBy.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>创建时间：</label>
				<input name="createDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${erpVendor.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			
			
			<li><label>删除标记：</label>
				<form:radiobuttons path="delFlag" items="${fns:getDictList('del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>供货商编码</th>
				<th>供货商描述</th>
				<th>供货商电话</th>
				<th>联系人</th>
				<th>地址</th>
				
				<th>创建者</th>
				<th>创建时间</th>
				<th>更新者</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<th>删除标记</th>
				<shiro:hasPermission name="erpvendor:erpVendor:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erpVendor">
			<tr>
				
				<td><a href="${ctx}/erpvendor/erpVendor/form?id=${erpVendor.id}">
					${erpVendor.vendorCode}
				</a></td>
				<td>
					${erpVendor.vendorDesc}
				</td>
				<td>
					${erpVendor.vendorTel}
				</td>
				<td>
					${erpVendor.vendorMan}
				</td>
				<td>
					${erpVendor.vendorAddress}
				</td>
				
				<td>
					${erpVendor.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${erpVendor.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${erpVendor.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${erpVendor.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${erpVendor.remarks}
				</td>
				<td>
					${fns:getDictLabel(erpVendor.delFlag, 'del_flag', '')}
				</td>
				<shiro:hasPermission name="erpvendor:erpVendor:edit"><td>
    				<a href="${ctx}/erpvendor/erpVendor/form?id=${erpVendor.id}">修改</a>
					<a href="${ctx}/erpvendor/erpVendor/delete?id=${erpVendor.id}" onclick="return confirmx('确认要删除该供应商维护吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>