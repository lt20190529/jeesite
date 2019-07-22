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
<link 
    href="${pageContext.request.contextPath}/static/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" 
    type="text/css" rel="stylesheet" />


<link rel="stylesheet"
	href="${ctxStatic}/jquery-easyui/themes/default/easyui.css"
	type="text/css" />
	

<script src="${pageContext.request.contextPath}/static/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>

<meta name="decorator" content="default" />
<script type="text/javascript">
$(function () {
    $('#datetimeStart').datetimepicker({
        format: 'yyyy-mm-dd',
        minView:'month',
        language: 'zh-CN',
        autoclose:true,
        pickerPosition:'bottom-left',  //位置：相对图标而言
        todayHighlight:true,   //当天高亮显示
        startDate:new Date()
        }).on("click",function(){
    });
    $('#datetimeEnd').datetimepicker({
        format: 'yyyy-mm-dd',
        minView:'month',
        language: 'zh-CN',
        autoclose:true,
        pickerPosition:'bottom-left',  //位置：相对图标而言
        todayHighlight:true,   //当天高亮显示
        startDate:new Date()
        }).on("click",function(){
    });
    
});


</script>
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

				<br> <br>

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

				<br> <br>

                <div class="col-md-4 form-inline">
					<label class="col-sm-4">Email：</label>
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

				<br> <br>


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
					<label class="col-sm-4">用户类型：</label>
					<div class="col-sm-8">
						<select  id="userType" name="userType" style="width:210px;height:26.96px" >
                                        <c:forEach items="${USER_TYPE}" var="ut">
                                            <option value="${ut.code}">${ut.name}</option>
                                        </c:forEach>
                        </select>
					</div>
				</div>


				<br> <br>

				<div class="col-md-4 form-inline">
					<label class="col-sm-4">生效日期：</label>
					<div class="col-sm-8">
						   <div class='input-group date' id='datetimeStart'>
				                <input type='text' class="form-control" style="width:170px;height:26.96px"/>
				                <span class="input-group-addon">
				                    <span class="glyphicon glyphicon-calendar"></span>
				                </span>
				            </div>
					</div>
				</div>
				
				

				<div class="col-md-4 form-inline">
					<label class="col-sm-4">失效日期：</label>
					<div class="col-sm-8">
						<div class='input-group date' id='datetimeEnd'>
				                <input type='text' class="form-control" style="width:170px;height:26.96px"/>
				                <span class="input-group-addon">
				                    <span class="glyphicon glyphicon-calendar"></span>
				                </span>
				            </div>
					</div>
				</div>

				<div class="col-md-4 form-inline">
					<label class="col-sm-4">是否有效：</label>
					<div class="col-sm-8">
						 <form:radiobuttons path="" items="${userStatus}" delimiter="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                                                     labelCssClass="radio-inline"/>
					</div>
				</div>
				
				<br> 
				<br>
			
                <hr>
               
				
				<div class="col-md-4 form-inline">
					<label class="col-sm-4">所属公司：</label>
					<div class="col-sm-8">
						<div class='input-group date' id='datetimeEnd'>
							</label>
							<sys:treeselect id="company" name="company.id"
								value="${user.office.id}" labelName="company.name"
								labelValue="${user.office.name}" title="组别"
								url="/sys/office/treeData?type=1" cssClass="input-large"
								hideBtn="true" smallBtn="true" allowClear="true"
								notAllowSelectParent="true" />

						</div>
					</div>
				</div>



				<div class="col-md-4 form-inline">
					<label class="col-sm-4">所属组别：</label>
					<div class="col-sm-8">
						<div class='input-group date' id='datetimeEnd'>
							</label>
							<sys:treeselect id="office" name="office.id"
								value="${user.office.id}" labelName="office.name"
								labelValue="${user.office.name}" title="组别"
								url="/sys/office/treeData?type=2" cssClass="input-large"
								hideBtn="true" smallBtn="true" allowClear="true"
								notAllowSelectParent="true" />

						</div>
					</div>
				</div>

				<br>
				<br>
				
				<hr>
				<div class="col-md-12 form-inline">
					<label class="col-sm-1">角色：</label>
					<div class="col-sm-10 col-md-offset-0 text-left " style="">
						<c:forEach items="${roleList}" var="roleList" varStatus="status">
									<label> <input id=${roleList.id } name="roleList"
										type="checkbox" value=${roleList.id } disabled="false" checked>${roleList.name}
									</label>
						</c:forEach>
					</div>
				</div>
				
				
				
			</div>

  
		</div>
	</form:form>

</body>
</html>
