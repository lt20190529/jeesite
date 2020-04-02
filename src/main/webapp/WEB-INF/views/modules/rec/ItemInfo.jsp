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
                url: "${ctx}/rec/erpRec/getItemList?input="+"d",                            //请求后台的URL（*）
                //method: 'post',
                contentType: "application/x-www-form-urlencoded",
                striped: true,                      //是否显示行间隔色
                clickToSelect: true,                //是否启用点击选中行
                queryParams: function queryParams(params) {
                    var param = {
                        pageNumber: 1,
                        pageSize: 6
                    };
                    return param;
                },
                columns: [{
                    checkbox: true,
                    visible: true,                  //是否显示复选框
                }, {
                    field: 'itemID',
                    title: 'itemID',
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
            });
        };

        $(document).ready(function(){
            InitTableSub();
            //$('#table1').bootstrapTable('resetView', { height: 200 });
            //设置bootstrapTable起始的高度
            $('#table1').bootstrapTable({ height: $(window).height() - 120 });
            //当表格内容的高度小于外面容器的高度，容器的高度设置为内容的高度，相反时容器设置为窗口的高度-160
            if ($(".fixed-table-body table").height() < $(".fixed-table-container").height()) {
                $(".fixed-table-container").css({ "padding-bottom": "0px", height: $(".fixed-table-body table").height() + 20 });
                // 是当内容少时，使用搜索功能高度保持不变
                $('#table1').bootstrapTable('resetView', { height: "auto" });
            } else {
                $(".fixed-table-container").css({ height: $(window).height() - 160 });
            }
        });
    </script>

</head>
<body>
<form:form id="inputForm" action="" method="post">
                <table id="table1"  ></table>
</form:form>
</body>
</html>
