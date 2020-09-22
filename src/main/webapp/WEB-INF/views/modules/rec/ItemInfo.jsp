<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}${fns:getAdminPath()}" />
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static" />
<html>
<head>
    <title>物品选择</title>
    <meta name="decorator" content="default" />
    <!--引入4.0.0BootStrap-->

    <script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript"></script>

    <%--引入BootStrap Table--%>
    <link href="${pageContext.request.contextPath}/static/bootstrap-table/bootstrap-table.css" type="text/css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script src="${pageContext.request.contextPath}/static/bootstrap-table/bootstrap-table.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/bootstrap-table/locale/bootstrap-table-zh-CN.js" type="text/javascript"></script>

    <script type="text/javascript">


        function InitTableSub () {
            $table1 = $('#table1').bootstrapTable({
                url: "",                            //请求后台的URL（*）
                method: 'post',
                contentType: "application/x-www-form-urlencoded",
                search: true,                      //是否显示表格搜索
                strictSearch: true,
                striped: true,                      //是否显示行间隔色
                pagination: true,                   //是否显示分页（*）
                singleSelect: true,                 //设置True 将禁止多选
                sortable: true,                     //是否启用排序
                sortOrder: "asc",                   //排序方式
                sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                pageNumber: 0,                      //初始化加载第一页，默认第一页,并记录11
                pageSize:8,                     //每页的记录行数（*）
                paginationDetailHAlign:"left",
                pageList: [8, 16, 24],        //可供选择的每页的行数（*）
                search: false,                      //是否显示表格搜索
                clickToSelect: true,                //是否启用点击选中行
                uniqueId: "id",                     //每一行的唯一标识，一般为主键列
                rowStyle: function (row, index) {   //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
                    return { classes: "active" }
                },
                queryParamsType:'',
                queryParams: function queryParams(params) {
                    var param = {
                        pageNumber: params.pageNumber,
                        pageSize: params.pageSize
                    };
                    return param;
                },
                columns: [{
                    checkbox: true,
                    visible: true,                  //是否显示复选框
                }, {
                    field: 'id',
                    title: 'id',
                    visible: false,
                }, {
                    field: 'itemNo',
                    title: '产品编码'
                }, {
                    field: 'itemDesc',
                    title: '产品名称'
                }, {
                    field: 'itemSpec',
                    title: '规格'
                }, {
                    field: 'erpUom.erpUomdesc',
                    title: '单位'
                }, {
                    field: 'erpUom.id',
                    title: 'UomID',
                    visible:false
                }, {
                    field: 'itemSp',
                    title: '售价'
                }, ],
                onLoadSuccess: function () {
                },
                onLoadError: function () {
                },
                onDblClickRow: function (field,value,row, $element) {
                },
                onPostBody : function () {
                },

            });


        };

        $(document).ready(function(){
            alert(2332233)
            InitTableSub();
            var input=$("input:hidden[name='params']").val();
            var queryUrl =  "${ctx}/rec/erpRec/getItemList?input=" +input;
            $('#table1').bootstrapTable('refresh',{url:queryUrl});
            $('#table1').bootstrapTable({ height: $(window).height() - 120 });

            if ($(".fixed-table-body table").height() < $(".fixed-table-container").height()) {    //当表格内容的高度小于外面容器的高度，容器的高度设置为内容的高度，相反时容器设置为窗口的高度-160
                $(".fixed-table-container").css({ "padding-bottom": "0px", height: $(".fixed-table-body table").height() + 20 });
                $('#table1').bootstrapTable('resetView', { height: "auto" });                      // 是当内容少时，使用搜索功能高度保持不变
            } else {
                $(".fixed-table-container").css({ height: $(window).height() - 160 });
            }
        });
    </script>

</head>
<body>
<form:form id="inputForm" action="" method="post">
                <table id="table1"  ></table>
    <input type="hidden" name="params" value="${params}">
</form:form>
</body>
</html>
