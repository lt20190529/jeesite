<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}${fns:getAdminPath()}" />
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static" />
<html>
<head>
<title>入库管理--入库查询</title>
<meta name="decorator" content="default" />
	<!--引入4.0.0BootStrap-->

	<script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript"></script>

	<%--引入BootStrap Table--%>
	<link href="${pageContext.request.contextPath}/static/bootstrap-table/bootstrap-table.css" type="text/css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
	<script src="${pageContext.request.contextPath}/static/bootstrap-table/bootstrap-table.js" type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/static/bootstrap-table/locale/bootstrap-table-zh-CN.js" type="text/javascript"></script>

	<style type="text/css">
        .subtotal { font-weight: bold; color:red}/*合计单元格样式*/
 </style>
 
<script type="text/javascript">

        function InitTable () {
            $table = $('#table').bootstrapTable({
                url: "",                            //请求后台的URL（*）
                method: 'GET',                      //请求方式（*）
                striped: true,                      //是否显示行间隔色
                cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                sortable: true,                     //是否启用排序
                sortOrder: "asc",                   //排序方式
                sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                pageNumber: 1,                      //初始化加载第一页，默认第一页,并记录
                pageSize: "",                       //每页的记录行数（*）
                pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
                search: false,                      //是否显示表格搜索
                strictSearch: true,
                showColumns: false,                  //是否显示所有的列（选择显示的列）
                showRefresh: false,                  //是否显示刷新按钮
                minimumCountColumns: 2,             //最少允许的列数
                clickToSelect: true,                //是否启用点击选中行
                height: 400,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                uniqueId: "subid",                     //每一行的唯一标识，一般为主键列
                queryParams : function (params) {
                    //这里的键的名字和控制器的变量名必须一致，这边改动，控制器也需要改成一样的
                    var temp = {
                        no:null,
                        depid:'',
                        vendorid:'',
                        page: 0,   //页码
                        rows: 6,                         //页面大小
                    };
                    return temp;
                },
                columns: [{
                    field: 'id',
                    title: 'id',
                    visible: false,
                }, {
                    field: 'no',
                    title: '单据编号',
                    visible: true,
                    sortable:true
                }, {
                    field: 'depdesc',
                    title: '入库部门',
                }, {
                    field: 'createDate',
                    title: '制单人',
                }, {
                    field: 'createDate',
                    title: '日期',
                }, {
                    field: 'auditFlag',
                    title: '是否审核',
                    width:200
                }, {
                    field: 'amtrp',
                    title: '进价金额',
                    width:200
                }, {
                    field: 'amtsp',
                    title: '售价金额',
                    width:200
                }]
            });
        };

	
	function query() {
        $('#table').bootstrapTable('refresh',{url:'${ctx}/rec/erpRecQuery/getRecMainList'});
	}

	

	//单击行加载明细
	function onClickRow(index, row){
		 var id = row["id"];
		// $('#dgDetail').datagrid({url:"${ctx}/rec/erpRec/getListjqGridDetail?ids=" + id});
	};
	
	
	$(document).ready(function() {
        InitTable();
		//initDetailGrid();
	});
	
	

</script>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/rec/erpRecQuery/erpRecQuery">入库<shiro:hasPermission
					name="rec:erpRec:Query">查询</shiro:hasPermission></a></li>
		
	</ul>
	<br />
	<form:form id="searchForm" modelAttribute="erpRec"
		action="${ctx}/rec/erpRec/query" method="post"
		class="breadcrumb form-search">
		<ul class="ul-form">
			<li><label>单号：</label> <form:input path="no" htmlEscape="false"
					maxlength="50" class="input-medium" /></li>
									
			<li><label>库房：</label> 
				<form:select path="depid" class="input-medium">
					<form:option value="">请选择入库部门...</form:option>
					<form:options items="${erpDepartmentslist}"
						itemLabel="departmentDesc" itemValue="id" htmlEscape="false" />
				</form:select>	
			</li>
			
			<li><label>供货商：</label> 
			    <form:select path="vendorid" class="input-medium">
					<form:option value="">请选择供货商...</form:option>
					<form:options items="${erpVendorlist}" itemLabel="vendorDesc"
						itemValue="id" htmlEscape="false" />
				</form:select>	
			</li>

			<li class="btns"><input id="btnSubmit" class="btn btn-primary"
				onclick="query()" value="查询" /></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>

	<div class="control-group">
			<label class="control-label">入库信息：</label>
			<div class="controls">
				<table id="table" style="height:250px">
				</table>
			</div>
	</div>
	<br>
	<%--<div class="control-group">
			<label class="control-label">明细信息：</label>
			<div class="controls">
				<table id="dgDetail" class="easyui-datagrid"
					style="width:550px;height:250px">
				</table>
			</div>
	</div>--%>

</body>

</html>
