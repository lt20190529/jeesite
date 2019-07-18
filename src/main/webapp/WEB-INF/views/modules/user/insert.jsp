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
            
                   <!-- <div class="col-md-4 form-inline">
                            <label class="col-sm-4 ">角色：</label>
                            <div class="col-sm-8 checkbox" style="width: 55.8%;border:1px solid #b1b1b1">
                                <c:forEach items="" var="roleList" varStatus="status" >
                                    
                                </c:forEach>
                                <div id="roleErrorDiv"></div>
                            </div>
                    </div>
                    
                    <div class="col-xs-12 col-sm-8 col-md-8">
                            <form:hidden path="" id="companyDiv"/>
                            <div class="form-group sino-form-group">
                                <label class="col-sm-2 control-label showStar">选择公司：</label>
                                <ol style="background-color:transparent" id="companyTitle" class="breadcrumb">

                                </ol>
                            </div>
                            <div id="companyErrorDiv"></div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="col-xs-12 col-sm-8 col-md-8">
                            <form:hidden path="" id="groupDiv"/>
                            <div class="form-group sino-form-group">
                                <label class="col-sm-2 control-label showStar">选择组别：</label>
                                <ol style="background-color:transparent" id="groupTitle" class="breadcrumb">

                                </ol>

                            </div>
                            <div id="groupErrorDiv"></div>
                        </div> -->

		</div>
		
		<div class="modal fade sino-box" id="myModalCompany" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog sino-modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h3 id="company_title" class="modal-title" id="myModalLabel"><i class="fa fa-window-maximize"></i>
                        更多公司选择</h3>
                </div>
                <div class="modal-body sino-box-modal">

                    <form class="form-inline text-left">

                        <div class="form-group">
                            <input type="text" size="50" class="form-control input-sm" id="company_name"
                                   placeholder="名称">
                        </div>
                        <div class="form-group">
                            <button id="company_search_button" type="button" class="btn btn-sm btn-warning"><i
                                    class="fa fa-search"></i> 查 询
                            </button>
                        </div>
                    </form>
                    <div class="mt-10"></div>

                    <div class="table-responsive box-table">
                        <table class="table table-bordered table-striped table-hover">
                            <thead>
                            <tr>
                                <th width="30%">编号</th>
                                <th width="70%">名称</th>

                            </tr>
                            </thead>
                            <tbody id="company_details">

                            </tbody>
                        </table>
                    </div>
                    <!--分页-->
                    <nav class="text-right" id="companyPager">
                        <ul class="pagination">
                            <li><a id="first" role="button" disabled>&laquo;</a></li>
                            <li><a id="previous" role="button" disabled>上一页</a></li>
                            <li><a id="next" role="button" disabled>下一页</a></li>
                            <li><a id="last" role="button" disabled>&raquo;</a></li>
                        </ul>
                        <ul class="pagination-msg">
                            <span>共<span name="totalPages"></span>页，当前是第<span name="page"></span>页，跳转至：
                            </span>
                            <input type="text" class="form-control input-sm" name="topage"
                                   onkeypress="if (event.keyCode == 13) paginationQuery(this.value);">
                            <span>页</span>
                        </ul>
                    </nav>
                    <div class="text-center">
                        <button id="" type="button" class="btn btn-warning"><i
                                class="fa fa-check-square-o"></i>选 择
                        </button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <div class="modal fade sino-box" id="myModalGroup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog sino-modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h3 id="group_title" class="modal-title" ><i class="fa fa-window-maximize"></i> 更多组别选择</h3>
                </div>
                <div class="modal-body sino-box-modal">

                    <form class="form-inline text-left">

                        <div class="form-group">
                            <input type="text" size="50" class="form-control input-sm" id="group_name" placeholder="名称">
                        </div>
                        <div class="form-group">
                            <button id="group_search_button" type="button" class="btn btn-sm btn-warning"><i
                                    class="fa fa-search"></i> 查 询
                            </button>
                        </div>
                    </form>
                    <div class="mt-10"></div>

                    <div class="table-responsive box-table">
                        <table class="table table-bordered table-striped table-hover">
                            <thead>
                            <tr>
                                <th width="30%">编号</th>
                                <th width="70%">名称</th>

                            </tr>
                            </thead>
                            <tbody id="group_details">

                            </tbody>
                        </table>
                    </div>

                    <!--分页-->
                    <nav class="text-right" id="companyPager">
                        <ul class="pagination">
                            <li><a id="first" role="button" disabled>&laquo;</a></li>
                            <li><a id="previous" role="button" disabled>上一页</a></li>
                            <li><a id="next" role="button" disabled>下一页</a></li>
                            <li><a id="last" role="button" disabled>&raquo;</a></li>
                        </ul>
                        <ul class="pagination-msg">
                            <span>共<span name="totalPages"></span>页，当前是第<span name="page"></span>页，跳转至：
                            </span>
                            <input type="text" class="form-control input-sm" name="topage"
                                   onkeypress="if (event.keyCode == 13) paginationQuery(this.value);">
                            <span>页</span>
                        </ul>
                    </nav>
                    <div class="text-center">
                        <button id="group_select_button" type="button" class="btn btn-warning"><i
                                class="fa fa-check-square-o" data-dismiss="modal"></i>选 择
                        </button>
                    </div>

                </div>
            </div>
        </div>
    </div>
	</form:form>

</body>
</html>
