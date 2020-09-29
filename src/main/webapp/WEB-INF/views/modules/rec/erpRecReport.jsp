<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>入库管理--入库统计</title>
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
            paginationFirstText: "首页",
            paginationPreText: "上一页",
            paginationNextText: "下一页",
            paginationLastText: "末页",
            hight:100,
            queryParams : function (params) {
                var param = {
                    depid:'',
                    vendorid:'',
                    rows: params.limit,                         //页面大小
                    page: (params.offset / params.limit) + 1,   //页码
                };
                return param;
            },
            columns: [{
                field: 'depid',
                title: 'ID',
                visible: false,
            }, {
                field: 'depdesc',
                title: '科室',
                halign:"center"
            }, {
                field: 'amt',
                title: '金额',
                halign:"center"
            }, {
                field: 'count',
                title: '单据总数',
                halign:"center"
            }]
        });
    };

    function query(){
        var queryUrl =  "${ctx}/rec/erpRec/queryRecReport";
        $('#table').bootstrapTable('refresh',{url:queryUrl});
	}

</script>
</head>

<body>
	<ul class="nav nav-tabs">
	    <li class="active"><a href="${ctx}/rec/erpRec/erpRecReport">入库统计</a></li>
	</ul>
	<br />
	<form:form id="searchForm"
		action="${ctx}/rec/erpRec/query" method="post"
		class="breadcrumb form-search">
		<ul class="ul-form">

			<li class="btns"><input id="btnSubmit" class="btn btn-primary"
				onclick="query()" value="查询" /></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>

		<div class="control-group">
			<table id="table" > </table>
		</div>

</body>

</html>
