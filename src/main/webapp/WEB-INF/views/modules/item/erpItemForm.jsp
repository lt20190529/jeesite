<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>

<head>
	<title>字典维护管理</title>
	<meta name="decorator" content="default"/>
	 <!--引入4.0.0BootStrap-->
	<link href="${pageContext.request.contextPath}/static/bootstrap-4.0.0-dist/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
	<script src="${pageContext.request.contextPath}/static/bootstrap-4.0.0-dist/js/bootstrap.min.js" type="text/javascript"></script>
	
	<script type="text/javascript">
		$(document).ready(function() {
	
			$("#inputForm").validate({
		        rules: {
		        	itemNo: {remote: "${ctx}/item/erpItem/checkItemCode"}, 
		        	itemDesc:{remote: "${ctx}/item/erpItem/checkItemDesc",type: "post"},
		        },
		        //messages 处，如果某个控件没有 message，将调用默认的信息
		        messages: {
		        	itemNo: {required: "代码不能为空",remote: "代码已经存在"},
		        	itemDesc: {required: "描述不能为空",remote: "描述已经存在"}
		        }
		    });
		});
	</script>
	
	 
</head>
<!-- 笔记 -->
<!-- form:input  htmlEscape 属性作用理解为：是否转义字符， 默认为 true ，若要设置不对特殊字符进行转移，需设置为 false 。 -->
<body>


    
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/item/erpItem/">字典维护列表</a></li>
		<li class="active"><a href="${ctx}/item/erpItem/form?id=${erpItem.id}">字典维护<shiro:hasPermission name="item:erpItem:edit">${not empty erpItem.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="item:erpItem:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="erpItem" action="${ctx}/item/erpItem/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
				
		<div class="control-group">
			<label class="control-label">商品编码：</label>
			<div class="controls">
				<form:input path="itemNo" htmlEscape="false" maxlength="50"  class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">商品名称：</label>
			<div class="controls">
				<form:input path="itemDesc" htmlEscape="false" maxlength="50" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">规格：</label>
			<div class="controls">
				<form:input path="itemSpec" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">售价：</label>
			<div class="controls">
				<form:input path="itemSp" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">单位：</label>
			<div class="controls">
				<form:select path="erpUom" class="input-medium">
				    <form:option value="">请选择单位</form:option>
					<form:options items="${uomlist}" itemLabel="erpUomdesc" itemValue="erpUomcode" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="item:erpItem:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>