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
	<link href="${pageContext.request.contextPath}/static/bootstrap-table/bootstrap-table.css" type="text/css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
	<script src="${pageContext.request.contextPath}/static/bootstrap-table/bootstrap-table.js" type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/static/bootstrap-table/locale/bootstrap-table-zh-CN.js" type="text/javascript"></script>

 
<script type="text/javascript">

	$(document).ready(function() {
        InitTable();
        InitTableDetail();
	});
    function InitTable () {
        $table = $('#table').bootstrapTable({
            url: '',                            //请求后台的URL（*）
            method: 'post',                      //请求方式（*）
            contentType: "application/x-www-form-urlencoded",
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pagination: true,                   //是否显示分页（*）
            pageNumber: 1,
            pageSize:5,
            hight:100,
            queryParams : function (params) {
                var param = {
                    no:$.trim($("#no").val()),
                    depid:$.trim($("#depid").val()),
                    vendorid:$.trim($("#vendorid").val()),
                    page: 1,   //页码
                    rows: 5,                         //页面大小
                };
                return param;
            },
            columns: [{
                field: 'id',
                title: 'id',
                visible: false,
            }, {
                field: 'no',
                title: '单据编号',
                halign:"center"
            }, {
                field: 'depdesc',
                title: '入库部门',
                halign:"center"
            }, {
                field: 'createBy.loginName',
                title: '制单人',
                halign:"center"
            }, {
                field: 'createDate',
                title: '日期',
                halign:"center"
            }, {
                field: 'auditFlag',
                title: '是否审核',
            }, {
                field: 'amtrp',
                title: '进价金额',
                halign:"center",
				hidden:false
            }, {
                field: 'amtsp',
                title: '售价金额',
                halign:"center"
            }],
            onClickRow:function(row, $element){
               loadDetail(row.id);
            }
        });
    };
    function query(){
        var queryUrl =  "${ctx}/rec/erpRecQuery/getRecMainList";
        $('#table').bootstrapTable('refresh',{url:queryUrl});
    }
    function loadDetail(recid){
        var Url =  "${ctx}/rec/erpRecQuery/getRecDetailList?id=" + recid;
        $('#DetailTable').bootstrapTable('refresh',{url:Url});
	}


    function InitTableDetail () {
            $table = $('#DetailTable').bootstrapTable({
                url: '',                            //请求后台的URL（*）
                method: 'post',                      //请求方式（*）
                contentType: "application/x-www-form-urlencoded",
                sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                pagination: true,                   //是否显示分页（*）
                clickToSelect: true,                //是否启用点击选中行
                hight:350,
                queryParams : function (params) {
                    var temp = {
                        page: 0,   //页码
                        rows: 6,                         //页面大小
                    };
                    return temp;
                },
                columns: [{
                    field: 'subid',
                    title: '序号'
                }, {
                    field: 'itemno',
                    title: '编码',
                    visible: true,
                    sortable:true,
                    halign:"center"
                }, {
                    field: 'itemdesc',
                    title: '名称',
                    halign:"center"
                }, {
                    field: 'itemspec',
                    title: '规格',
                    halign:"center"
                }, {
                    field: 'uomdesc',
                    title: '单位',
                    halign:"center"
                }, {
                    field: 'qty',
                    title: '数量',
                    halign:"center"
                }, {
                    field: 'sp',
                    title: '单价',
                    halign:"center"
                }, {
                    field: 'spamt',
                    title: '金额',
                    halign:"center"
                }]
            });
    };

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

	<div class="controls" style="height: 220px">
		<table id="table" >
		</table>
	</div>

	<br>

	<div class="controls" style="height:240px">
		<table id="DetailTable" >
		</table>
	</div>


</body>

</html>
