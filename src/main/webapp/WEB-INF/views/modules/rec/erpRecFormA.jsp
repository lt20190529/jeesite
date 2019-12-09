<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<c:set var="ctx" value="${pageContext.request.contextPath}${fns:getAdminPath()}" />
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static" />

<html>
<head>
    <title>入库制单</title>
    <meta name="decorator" content="default" />
    <!--引入4.0.0BootStrap-->
    <link href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript"></script>

    <%--引入BootStrap Table--%>
    <link href="${pageContext.request.contextPath}/static/bootstrap-table/bootstrap-table.css" type="text/css" rel="stylesheet" />
    <script src="${pageContext.request.contextPath}/static/bootstrap-table/bootstrap-table.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/bootstrap-table/locale/bootstrap-table-zh-CN.js" type="text/javascript"></script>

    <script>
        $(document).ready(function() {
            InitTable();
        });
        //初始化bootstrap-table的内容
        function InitTable () {
            //记录页面bootstrap-table全局变量$table，方便应用
            //var queryUrl = '/TestUser/FindWithPager?rnd=' + Math.random()
            $table = $('#table').bootstrapTable({
                url: "",                            //请求后台的URL（*）
                method: 'GET',                      //请求方式（*）
                //toolbar: '#toolbar',              //工具按钮用哪个容器
                striped: true,                      //是否显示行间隔色
                cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                pagination: true,                   //是否显示分页（*）
                sortable: true,                     //是否启用排序
                sortOrder: "asc",                   //排序方式
                sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                pageNumber: 1,                      //初始化加载第一页，默认第一页,并记录
                pageSize: "",                     //每页的记录行数（*）
                pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
                search: false,                      //是否显示表格搜索
                strictSearch: true,
                showColumns: false,                  //是否显示所有的列（选择显示的列）
                showRefresh: false,                  //是否显示刷新按钮
                minimumCountColumns: 2,             //最少允许的列数
                clickToSelect: true,                //是否启用点击选中行
                //height: 500,                      //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
                showToggle: false,                   //是否显示详细视图和列表视图的切换按钮
                cardView: false,                    //是否显示详细视图
                detailView: false,                  //是否显示父子表
                //得到查询的参数
                queryParams : function (params) {
                    //这里的键的名字和控制器的变量名必须一致，这边改动，控制器也需要改成一样的
                    var temp = {
                        rows: params.limit,                         //页面大小
                        page: (params.offset / params.limit) + 1,   //页码
                        sort: params.sort,      //排序列名
                        sortOrder: params.order //排位命令（desc，asc）
                    };
                    return temp;
                },
                columns: [{
                    checkbox: true,
                    visible: false,                  //是否显示复选框
                }, {
                    field: 'DrugCode',
                    title: '产品编码',
                    sortable: true
                }, {
                    field: 'DrugDesc',
                    title: '产品名称',
                    sortable: true
                }, {
                    field: 'Spec',
                    title: '规格',
                    sortable: true,
                    formatter: ""
                }, {
                    field: 'Uom',
                    title: '单位',
                    formatter: ""
                }, {
                    field: 'Qty',
                    title: '数量'
                }, {
                    field: 'Price',
                    title: '单价',
                    sortable: true
                }, {
                    field: 'Amount',
                    title: '金额'
                }, {
                    field:'ID',
                    title: '操作',
                    width: 120,
                    align: 'center',
                    valign: 'middle',
                    formatter: ""
                }, ],
                onLoadSuccess: function () {
                },
                onLoadError: function () {

                },
                onDblClickRow: function (row, $element) {

                },
            });
        };


    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a
            href="${ctx}/rec/erpRec/formA?id=${ErpRecNew.id}">入库<shiro:hasPermission
            name="rec:erpRec:view">${not empty erpRec.id?'编辑':'制单'}</shiro:hasPermission>
    </a></li>
</ul>
<br />

<form:form id="inputForm" modelAttribute="erpRecNew"
           action="" method="post" >
    <form:hidden path="id" />
    <sys:message content="${message}" />

    <div class="container">
        <div class="row">
            <div class="col-xs-4 col-sm-4">
                单据编号：<form:input path="no" id="no"  class="required" readonly="true" />
            </div>


            <div class="col-xs-4 col-sm-4">
                部门：
                <form:select path="depid" class="input-medium"
                             onchange="show_dep(this.options[this.options.selectedIndex].value)">
                    <form:option value="">请选择入库部门...</form:option>
                    <form:options items="${erpDepartmentslist}"
                                  itemLabel="departmentDesc" itemValue="id" htmlEscape="false" />
                    <span id="val_dep" style="color:#F00" class="help-inline"><font
                            color="red">*</font> </span>
                </form:select>
            </div>
            <div class="col-xs-4 col-sm-4">
                供货商：
                <form:select path="vendorid" class="input-medium"
                             onchange="show_vendor(this.options[this.options.selectedIndex].value)">
                    <form:option value="">请选择供货商...</form:option>
                    <form:options items="${erpVendorlist}" itemLabel="vendorDesc"
                                  itemValue="id" htmlEscape="false" />
                </form:select>
            </div>
        </div>

        <br>

        <div class="row">
            <div class="col-xs-12 col-sm-12">
                备注信息：
                <form:textarea path="remarks" id="remarks" htmlEscape="false"
                               maxlength="255" class="input-xxlarge " />
            </div>
        </div>
    </div>


    <br>

    <div>

        <div>
            <input id="button" class="btn btn-primary" type="button" value="添加明细" onclick="append()"></button>
        </div>
        <table id="table" data-height="360"></table>

        <div class="form-actions">
            <shiro:hasPermission name="rec:erpRec:edit">
                <input id="btnsave" class="btn btn-primary" onclick="SaveData()"
                       type="button" value="提交" />&nbsp;</shiro:hasPermission>
            <input id="btnCancel" class="btn" type="button" value="返 回"
                   onclick="history.go(-1)" />
        </div>

    </div>
</form:form>
<script>

    //保存数据
    function SaveData() {
        var params = {};// 参数对象
        params.id = id;
        params.no = no;
        params.depid = $.trim($("#depid").val());
        params.vendorid = $.trim($("#vendorid").val());
        params.erpRecdetailNewList = "";
        alert(JSON.stringify(params))
        $.ajax({
            type : "post",
            url : "${ctx}/rec/erpRec/SaveRecItemA",
            data : JSON.stringify(params),
            contentType : "application/json;charset=utf-8",
            dataType : "text",
            success : function(data) {
                layer.msg("保存成功！", {
                    offset : '100px'
                })
            },
            error : function() {
                layer.msg("保存失败！", {
                    offset : '100px'
                })
            }
        });
    }


    function append() {
        $('#table').bootstrapTable('insertRow', {
            index: 1,
            row: {
                DrugCode: "",
                DrugDesc: "",
                Spec: "",
                Price:"",
                Uom:"",
                Qty:"",
                Amount:""
            }
        })

    }
</script>
</body>

</html>
