<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
  <head>
   <title>部门维护管理</title>
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
		<li class="active"><a href="${ctx}/erpdepartments/departments/">部门维护列表</a></li>
		<shiro:hasPermission name="erpdepartments:departments:edit"><li><a href="${ctx}/erpdepartments/departments/form">部门维护添加</a></li></shiro:hasPermission>
	</ul>
	
	
	<form:form id="searchForm" modelAttribute="erpDepartments" action="${ctx}/erpdepartments/departments/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>部门编码：</label>
				<form:input path="departmentCode" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>部门描述：</label>
				<form:input path="departmentDesc" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>部门编码</th>
				<th>部门商描述</th>
				<th>部门商电话</th>
				<th>部门联系人</th>

				<th>创建者</th>
				<th>创建时间</th>
				<th>更新者</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<th>删除标记</th>
				<shiro:hasPermission name="erpdepartments:departments:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="ErpDepartments">
			<tr>
				
				<td><a href="${ctx}/erpdepartments/departments/form?id=${ErpDepartments.id}">
					${ErpDepartments.departmentCode}
				</a></td>
				<td>
					${ErpDepartments.departmentDesc}
				</td>
				<td>
					${ErpDepartments.departmentTel}
				</td>
				<td>
					${ErpDepartments.departmentMan}
				</td>
				<td>
					${ErpDepartments.createBy.id}
				</td>
				<td>
				    <fmt:formatDate value="${ErpDepartments.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${ErpDepartments.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${ErpDepartments.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${ErpDepartments.remarks}
				</td>
				<td>
					${fns:getDictLabel(ErpDepartments.delFlag, 'del_flag', '')}
				</td>
				
				<shiro:hasPermission name="erpdepartments:departments:edit"><td>
    				<a href="${ctx}/erpdepartments/departments/form?id=${ErpDepartments.id}">修改</a>
					<a href="${ctx}/erpdepartments/departments/delete?id=${ErpDepartments.id}" onclick="return confirmx('确认要删除该部门吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
  </body>
</html>
