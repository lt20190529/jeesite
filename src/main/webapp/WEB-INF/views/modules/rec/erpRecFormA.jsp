<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<c:set var="ctx" value="${pageContext.request.contextPath}${fns:getAdminPath()}" />
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static" />

<html>
<head>
    <title>入库制单</title>
    <meta name="decorator" content="default" />
    <!--引入4.0.0BootStrap-->

    <script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript"></script>

    <%--引入BootStrap Table--%>
    <link href="${pageContext.request.contextPath}/static/bootstrap-table/bootstrap-table.css" type="text/css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script src="${pageContext.request.contextPath}/static/bootstrap-table/bootstrap-table.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/bootstrap-table/locale/bootstrap-table-zh-CN.js" type="text/javascript"></script>


    <style>

        .checkbox-custom {
            position: relative;
            padding: 0 15px 0 25px;
            margin-bottom: 7px;
            margin-top: 0;
            display: inline-block;
        }
        /*
        将初始的checkbox的样式改变
        */
        .checkbox-custom input[type="checkbox"] {
            opacity: 0;/*将初始的checkbox隐藏起来*/
            position: absolute;
            cursor: pointer;
            z-index: 2;
            margin: -6px 0 0 0;
            top: 90%;
            left: 3px;
        }
        /*
        设计新的checkbox，位置
        */
        .checkbox-custom label:before {
            content: '';
            position: absolute;
            top: 100%;
            left: 4px;
            margin-top: -9px;
            width: 19px;
            height: 18px;
            display: inline-block;
            border-radius: 2px;
            border: 1px solid #bbb;
            background: #fff;
        }
        /*
        点击初始的checkbox，将新的checkbox关联起来
        */
        .checkbox-custom input[type="checkbox"]:checked +label:after {
            position: absolute;
            display: inline-block;
            font-family: 'Glyphicons Halflings';
            content: "\e013";
            top: 90%;
            left: 3px;
            margin-top: -5px;
            font-size: 11px;
            line-height: 1;
            width: 16px;
            height: 16px;
            color: #333;
        }
        .checkbox-custom label {
            cursor: pointer;
            line-height: 1.2;
            font-weight: normal;/*改变了rememberme的字体*/
            margin-bottom: 0;
            text-align: left;
        }

        .pp{
        margin:20px 15px 25px;
        }
        .btn{
        margin:20px;
        }
        .btnhight{
            height: 20px;
        }
        .mm{
            margin:30px 380px;
        }
        .qq{
            margin:0px 0px 0px 0px;
        }
        .butn{
            margin:2px 3px 2px 660px;   /*margin 上右下左*/
        }
        .box{
            margin:1px 1px 1px 1px;   /*margin 上右下左*/
        }
        .pull-right.pagination-detail{   /*//bootstrap table不显示分页信息*/
            display:none;
        }
        .fixed-table-pagination .page-list {
            display:none;
        }
    </style>


    <script>


        $(document).ready(function() {
            InitTable();

            /*获取单据编码*/
            var id = $.trim($("#id").val());
            if (id == "") {
                GetMaxNo();
            }
        });

        //获取最大单据编号
        function GetMaxNo() {
            $.ajax({
                type : "post",
                url : "${ctx}/rec/erpRec/GetMaxNo",
                dataType : 'json',
                data : { //传值，多个值之间用逗号隔开，最后一个不用写逗号
                },
                success : function(data) {
                    $("#no").val(data.result);
                    $("#no").attr("readonly", "readonly");
                }
            });

        }
        function InitTable () {
            $table = $('#table').bootstrapTable({
                url: "",                            //请求后台的URL（*）
                method: 'GET',                      //请求方式（*）
                toolbar: '#toolbar',              //工具按钮用哪个容器
                striped: true,                      //是否显示行间隔色
                cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                pagination: true,                   //是否显示分页（*）
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
                height: 400,                      //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
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
                    field: 'id',
                    title: 'id',
                    visible: false,
                }, {
                    field: 'itemid',
                    title: 'itemid',
                    visible:false
                }, {
                    field: 'itemno',
                    title: '产品编码',
                    sortable: true,
                    width:200
                }, {
                    field: 'itemdesc',
                    title: '产品名称',
                    sortable: true,
                    width:300,
                    formatter:editFormatter,
                    events: operatorDrugDesc,

                }, {
                    field: 'itemspec',
                    title: '规格',
                    sortable: true,
                    formatter: "",
                    width:200
                }, {
                    field: 'uomdesc',
                    title: '单位',
                    formatter: "",
                    width:200
                }, {
                    field: 'uomid',
                    title: 'uomid',
                    visible:false
                }, {
                    field: 'qty',
                    title: '数量',
                    width:200,
                    formatter:editFormatter1,
                    events: operatorQty,
                }, {
                    field: 'sp',
                    title: '单价',
                    sortable: true,
                    width:200,
                    formatter:editFormatter2,
                    events: operatorPrice,
                }, {
                    field: 'spamt',
                    title: '金额',
                    width:200
                }, {
                    field:'ID',
                    title: '操作',
                    width: 120,
                    align: 'center',
                    valign: 'middle',
                    formatter:function(value,row,index){
                        var element =
                            "<a class='edit' data-id='"+row.id +"'>编辑</a> "+
                            "<a class='delet' data-id='"+row.id +"'>删除</a> ";
                        return element;
                    }
                }, ],
                onLoadSuccess: function () {
                },
                onLoadError: function () {
                },
                onDblClickRow: function (field,value,row, $element) {
                },
                onPostBody:function(){
                }
            });
        };


        //模态框Table
        function InitTableSub (input) {
            var queryUrl =  "${ctx}/rec/erpRec/getItemList?input=" + input;
            $table = $('#table1').bootstrapTable({
                url: queryUrl,                            //请求后台的URL（*）
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
                    /*var style = "";
                    if (row.name=="小红") {style='success';}*/
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
                    $("#table1").find("input:checkbox").each(function (i) {
                        var $check = $(this);
                        if ($check.attr("id") && $check.next("label")) {
                            return;
                        }
                        var name = $check.attr("name");
                        var id = name + "-" + i;
                        var $label = $('<label for="'+ id +'"></label>');
                        $check.attr("id", id).parent().addClass("checkbox-custom").append($label);
                    });
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
        <div class="row ">
            <div class="col-xs-6">
                编号：<form:input path="no" id="no" class="input-xlarge required" readonly="true" />
            </div>


            <div class="col-lg-6">
                部门：
                <form:select path="depid" class="input-xlarge" >
                    <form:option value="">请选择入库部门...</form:option>
                    <form:options items="${erpDepartmentslist}"
                                  itemLabel="departmentDesc" itemValue="id" htmlEscape="false" />
                </form:select>
            </div>

        </div>

        <br>

        <div class="row">
            <div class="col-lg-6">
                厂商：
                <form:select path="vendorid" class="input-xlarge">
                    <form:option value="">请选择供货商...</form:option>
                    <form:options items="${erpVendorlist}"
                                  itemLabel="vendorDesc" itemValue="id" htmlEscape="false" />
                </form:select>
            </div>
            <div class="col-lg-6">
                备注：
                <form:textarea path="remarks"  id="remarks" htmlEscape="false"
                               maxlength="140" class="input-xlarge " />
            </div>

        </div>
    </div>


    </div>


    <div>
        <div id="toolbar" style="height: 50px">
        <button type="button" class="btn btn-primary" onclick="append()">添加</button>
        </div>
        <table id="table" class="table table-bordered table-hover" data-height="300" ></table>
    </div>
    <div class="form-actions">
        <shiro:hasPermission name="rec:erpRec:edit">
            <input id="btnsave" class="btn btn-primary" onclick="SaveData()"
                   type="button" value="提交" />&nbsp;</shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回"
               onclick="history.go(-1)" />
    </div>
</form:form>
<!-- 模态框（Modal） -->
<div class="modal fade mm" id="myModal" style="width:50%;height: 515px" tabindex="-1" >
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel">选择药品</h4>
        </div>
        <div class="modal-header box" style="height: 370px">
            <table id="table1"></table>
        </div>
        <input id="append" type="button" class="btn btn-primary butn" value="选择" onclick="appenddata()"></input>
</div>
<script>


    function editFormatter(value,row,index){
        return [
            '<input type="text" id="1plan'+row.id+'" style="height:30px;margin: 0px 0px 0px 0px" class="Desc" data='+value+' value='+value+' onkeydown="myFunction('+row.id+',1)"/>'
        ].join("");
    }
    function editFormatter1(value,row,index){
        return [
            '<input type="text" id="2plan'+row.id+'" style="height:30px;margin: 0px 0px 0px 0px" class="Qty" data='+value+' value='+value+' onBlur="amount('+row.id+','+row.sp+',value)">'
        ].join("");
    }
    function editFormatter2(value,row,index){
        return [
            '<input type="text" id="3plan'+row.id+'" style="height:30px;margin: 0px 0px 0px 0px" class="Price" data='+value+' value='+value+'>'
        ].join("");

    }

    var operatorDrugDesc = {
        "change .itemdesc":function (e,value,row,index) {//描述列，change
            $("#"+"1plan"+row.id).attr("readonly",true)
        },
        "blur .itemdesc":function (e,value,row,index) {//描述列，失去焦点
            $("#"+"1plan"+row.id).attr("readonly",true)
        },
        "focus .itemdesc":function (e,value,row,index) {//描述列，得到焦点
            $("#"+"1plan"+row.id).attr("readonly",false)
        }
    }

    var operatorQty = {
        "change .qty":function (e,value,row,index) { //单价列，注意通过样式.price监听
            var price = row.sp || 0;//单价   ||0 Price有值返回值，无值返回0
            var nums = $("#"+"2plan"+row.id).val() || 0;  //数量
            var amt =  price * nums ;

            $('#table').bootstrapTable('updateCell', {
                index: index,
                field:"qty",
                value: nums
            });
            $('#table').bootstrapTable('updateCell', {
                index: index,
                field:"spamt",
                value: amt
            });
        },
        "blur .qty":function (e,value,row,index) {//单价列，失去焦点
            $("#"+"2plan"+row.id).attr("readonly",true)
        },
        "focus .qty":function (e,value,row,index) {//单价列，得到焦点
            $("#"+"2plan"+row.id).attr("readonly",false)
        }


    }
    var operatorPrice = {
        "change .sp":function (e,value,row,index) {//单价列，change
            alert("xxx:"+"Price");
        },
        "blur .sp":function (e,value,row,index) {//单价列，失去焦点
            $("#"+"3plan"+row.id).attr("readonly",true)
        },
        "focus .sp":function (e,value,row,index) {//单价列，得到焦点
            $("#"+"3plan"+row.id).attr("readonly",false)
        }
    }

    function amount(id,price,value){

    }

    function myFunction(id,type) {

        var writevalue=$("#"+type+"plan"+id).val(); //获取改变后的输入框的值
        var oldvalue = $("#"+type+"plan"+id).attr("data"); //获取输入框原本的值
        if (event.keyCode==13){
           $("#"+type+"plan"+id).blur();
           InitTableSub(writevalue)   //初始化弹出框Table
           $("#myModal").modal('show');
        }
    }

    //保存数据
    function SaveData() {
        var rows=$("#table").bootstrapTable("getData").length;   //获取总行数方式1
        var rows1=$("#table").bootstrapTable("getOptions").totalRows; //获取总行数方式2
        var params = {};// 参数对象
        params.id = "";
        params.no = $.trim($("#no").val());
        params.depid = $.trim($("#depid").val());
        params.vendorid = $.trim($("#vendorid").val());
        params.erpRecdetailNewList =$('#table').bootstrapTable('getData');
        $.ajax({
            type : "post",
            url : "${ctx}/rec/erpRec/SaveListjqGridItemE",
            data :JSON.stringify(params),
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
        var count = $('#table').bootstrapTable('getData').length;

        var rows = $('#table').bootstrapTable('getData');   //行的数据
        for(var i=0;i<rows.length;i++){
            if(rows[i].itemdesc==""){
                layer.msg("项目不能为空!");
                return;
            };
            if(rows[i].qty==""){
                layer.msg("数量不能为空!");
                return;
            }

        }


        $('#table').bootstrapTable('insertRow', {
            index: count,
            row: {
                id:count,
                itemid:"",
                itemno: "",
                itemdesc: "",
                itemspec: "",
                sp: "",
                uomdesc:"",
                uomid:"",
                qty:"",
                spamt:""
            }
        })

    }
    function appenddata() {
        var row=$("#table1").bootstrapTable("getSelections");
        var count = $('#table').bootstrapTable('getData').length;

        $('#table').bootstrapTable('updateRow', {
            index: count-1,
            row: {
                id:"",
                itemid:row[0].id,
                itemno: row[0].itemNo,
                itemdesc: row[0].itemDesc,
                itemspec: row[0].itemSpec,
                sp: row[0].itemSp,
                uomdesc:row[0].erpUom.erpUomdesc,
                uomid:row[0].erpUom.id,
                qty:"",
                spamt:""
            }
        })
        $('#myModal').modal('hide')

    }
    $('#myModal').on('hide.bs.modal', function () {

    })


</script>
</body>

</html>
