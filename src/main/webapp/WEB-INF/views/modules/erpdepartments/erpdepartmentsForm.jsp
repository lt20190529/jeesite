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
		<li><a href="${ctx}/erpdepartments/departments/">部门维护列表</a></li>
		<shiro:hasPermission name="erpdepartments:departments:edit"><li  class="active"><a href="${ctx}/erpdepartments/departments/form">部门维护添加</a></li></shiro:hasPermission>
	</ul>
	
	<form:form id="inputForm" modelAttribute="erpDepartments" action="${ctx}/erpdepartments/departments/save" method="post" class="form-horizontal">
		<form:hidden path="id"/> 
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">部门编码：</label>
			<div class="controls">
				<form:input path="departmentCode" htmlEscape="false" maxlength="50" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">部门描述：</label>
			<div class="controls">
				<form:input path="departmentDesc" htmlEscape="false" maxlength="50" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">部门电话：</label>
			<div class="controls">
				<form:input path="departmentTel" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">部门联系人：</label>
			<div class="controls">
				<form:input path="departmentMan" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		
		
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="erpdepartments:departments:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
  </body>
</html>
