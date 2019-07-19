<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="ctx"
	value="${pageContext.request.contextPath}${fns:getAdminPath()}" />
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>用户管理</title>
<link
	href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	type="text/css" rel="stylesheet" />
<link rel="stylesheet"
	href="${ctxStatic}/jquery-easyui/themes/default/easyui.css"
	type="text/css" />
<meta name="decorator" content="default" />
<style>
.container-fluid {
	padding-right: 10px;
	padding-left: 10px;
}

.row-fluid {
	padding-right: 30px;
	padding-left: 80px;
}

</style>
</head>

<body>

	<form:form id="userInsert" method="post" modelAttribute="sysUser"
		class="form-horizontal" role="form" action="${ctx}/sysmgr/user/insert">
		<div class="container-fluid">
                <div class="row-fluid ">
				<div class="row">
					<div class="col-md-5">
						<h4>
							<span class="glyphicon glyphicon-plus-sign">&nbsp;新增用户</span>
						</h4>
					</div>
				</div>

                <br>
                <br>
                
				<div class="col-md-4 form-inline">
					<label class="col-sm-4">登录名：</label>
					<div class="col-sm-8">
						<form:input path="" class="" required="true" />
					</div>
				</div>
				
				<div class="col-md-4 form-inline">
					<label class="col-sm-4">用户名：</label>
					<div class="col-sm-8">
						<form:input path="" class="" required="true" />
					</div>
				</div>
				
				<div class="col-md-4 form-inline">
					<label class="col-sm-4">用户编码：</label>
					<div class="col-sm-8">
						<form:input path="" class="" required="true" />
					</div>
				</div>
				
                <br>
                <br>
                
                
                <div class="col-md-4 form-inline">
					<label class="col-sm-4">是否有效：</label>
					<div class="col-sm-8">
						<form:input path="" class="" required="true" />
					</div>
				</div>
				
				<div class="col-md-4 form-inline">
					<label class="col-sm-4">办公电话：</label>
					<div class="col-sm-8">
						<form:input path="" class="" required="true" />
					</div>
				</div>
				
				<div class="col-md-4 form-inline">
					<label class="col-sm-4">手机：</label>
					<div class="col-sm-8">
						<form:input path="" class="" required="true" />
					</div>
				</div>
	
                <br>
                <br>
                
                
                <div class="col-md-4 form-inline">
					<label class="col-sm-4">QQ：</label>
					<div class="col-sm-8">
						<form:input path="" class="" required="true" />
					</div>
				</div>
				
				<div class="col-md-4 form-inline">
					<label class="col-sm-4">传真：</label>
					<div class="col-sm-8">
						<form:input path="" class="" required="true" />
					</div>
				</div>
				
				<div class="col-md-4 form-inline">
					<label class="col-sm-4">用户类别：</label>
					<div class="col-sm-8">
						<form:input path="" class="" required="true" />
					</div>
				</div
				
			  
                <br>
                <br>
                <br>
                
				<div class="col-md-4 form-inline">
					<label class="col-sm-4">生效日期：</label>
					<div class="col-sm-8">
						<form:input path="" class="" required="true" />
					</div>
				</div>
				
				<div class="col-md-4 form-inline">
					<label class="col-sm-4">失效日期：</label>
					<div class="col-sm-8">
						<form:input path="" class="" required="true" />
					</div>
				</div>
				
				<div class="col-md-4 form-inline">
					<label class="col-sm-4">启用状态：</label>
					<div class="col-sm-8">
						<form:input path="" class="" required="true" />
					</div>
				</div>
      
                <br>
                <br>  
              
             
		</div>
    </div>
	</form:form>

</body>
</html>
