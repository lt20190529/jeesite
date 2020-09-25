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

    <link href="${pageContext.request.contextPath}/static/bootstrap-table/bootstrap-table-fixed-columns-master/bootstrap-table-fixed-columns.css" type="text/css" rel="stylesheet" />
    <script src="${pageContext.request.contextPath}/static/bootstrap-table/bootstrap-table-fixed-columns-master/bootstrap-table-fixed-columns.js" type="text/javascript"></script>
    <style>
        .bella-checkbox{
            position: relative;
        }
        /** 将初始的checkbox的样式改变 */
        .bella-checkbox input[type="checkbox"] {
            opacity: 0; /*将初始的checkbox隐藏起来*/
        }
        /** 设计新的checkbox，位置 */
        .bella-checkbox label:before {
            content: '';
            width: 17px;
            height: 17px;
            display: inline-block;
            border-radius: 2px;
            border: 1px solid #bbb;
            background: #fff;
        }
        /** 点击初始的checkbox，将新的checkbox关联起来 */
        .bella-checkbox input[type="checkbox"]:checked + label:after {
            display: inline-block;
            font-family: 'Glyphicons Halflings';
            content: "\e013";
            top: 15%;
            left: 10%;
            position: absolute;
            font-size: 11px;
            line-height: 1;
            width: 16px;
            height: 16px;
            color: #333;
        }
        .bella-checkbox label {
            cursor: pointer;
            text-align: center;
            position: absolute;
            left: 10px;
        }
        .mm{
            margin:30px 380px;
        }

        .butn{
            margin:2px 3px 2px 660px;   /*margin 上右下左*/
        }
        .box{
            margin:1px 1px 1px 1px;   /*margin 上右下左*/
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

            var lookDetailrows = [];
            var data = ${fns:toJson(erpRec.erpRecDetailList)};
            for (var i=0; i<data.length; i++){
                //alert(data[i].id)
                $('#table').bootstrapTable('insertRow', {index: data[i].subid, row: data[i]});
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
                    field: 'id',
                    title: 'id',
                    visible: false,
                }, {
                    field: 'subid',
                    title: '序号',
                    visible: true,
                    sortable:true
                }, {
                    field: 'itemid',
                    title: 'itemid',
                    visible:false
                }, {
                    field: 'itemno',
                    title: '产品编码',
                    width:200
                }, {
                    field: 'itemdesc',
                    title: '产品名称',
                    width:300,
                    formatter:editFormatter
                }, {
                    field: 'itemspec',
                    title: '规格',
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
                    width:200,
                    formatter:editFormatter2
                }, {
                    field: 'spamt',
                    title: '金额',
                    width:200
                }, {
                    field:'btn',
                    title: '操作',
                    width: 120,
                    align: 'center',
                    valign: 'middle',
                    formatter: function (value, row, index) {
                        return   '<a class="" onclick="edit(\''+row.id+'\',\''+row.subid+'\',\''+row.itemno+'\');" > 删除</a>'
                    }
                }, ]
            });
        };



        function edit(id,subid,itmno){

            $('#table').bootstrapTable('remove', {
                field: "subid",
                values: [parseInt(subid)]
            });
            if(($.trim($("#id").val())!="")&&(id!=="")){  //主数据已经保存，并且明细已经保存
                delItem(id);
            }
            //循环遍历修改序号列
            var rows = $('#table').bootstrapTable('getData');   //行的数据
            for(var i=0;i<rows.length;i++){
                $('#table').bootstrapTable('updateCell', {
                    index: i,
                    field:"subid",
                    value: i+1
                });
            }
            //alert("save")
            //删除明细之后保存更新序号subid
            SaveData();
        }
        function delItem(id){
            $.ajax({
                type : "post",
                url : "${ctx}/rec/erpRec/Delete/"+id,
                dataType : 'text',
                success : function(data) {
                    layer.msg("删除成功！", {
                        offset : '100px'
                    })
                },
                error : function() {
                    layer.msg("删除失败！", {
                        offset : '100px'
                    })
                }
            });
        }
        //模态框Table
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
                pageNumber: 1,                      //初始化加载第一页，默认第一页,并记录11
                pageSize:7,                     //每页的记录行数（*）
                paginationDetailHAlign:" hidden",
               // pageList: [7,14,21,25,32],        //可供选择的每页的行数（*）
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
                    visible: true,                  //是否显示复选
                    width:'30'
                }, {
                    field: 'id',
                    title: 'id',
                    visible: false,
                }, {
                    field: 'itemNo',
                    title: '产品编码',
                    width:'120'
                }, {
                    field: 'itemDesc',
                    title: '产品名称',
                    width:'150'
                }, {
                    field: 'itemSpec',
                    title: '规格',
                    width:'100'
                }, {
                    field: 'erpUom.erpUomdesc',
                    title: '单位',
                    width:'100'
                }, {
                    field: 'erpUom.id',
                    title: 'UomID',
                    visible:false
                }, {
                    field: 'itemSp',
                    title: '售价',
                    width:'100'
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
                        var $label = $('<label onclick=" $(this).prev().click();" for="' + id + '"></label>');
                        $check.attr("id", id).parent().addClass("bella-checkbox").append($label);
                    });
                },

            });


        };

    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a
            href="${ctx}/rec/erpRec/form?id=${ErpRec.id}">入库<shiro:hasPermission
            name="rec:erpRec:view">${not empty erpRec.id?'编辑':'制单'}</shiro:hasPermission>
    </a></li>
</ul>
<br />

<form:form id="inputForm" modelAttribute="erpRec"
           action="" method="post" >
    <form:hidden path="id" id="id" />
    <input type="hidden" id="token" name="token" value="${token}" />
    <sys:message content="${message}" />

    <div class="container">
        <div class="row " >
            <div class="col-xs-6" >
                编&nbsp;&nbsp;&nbsp;&nbsp;号：<form:input path="no" id="no" style="height:25px" class="input-xlarge required" readonly="true" />
            </div>


            <div class="col-xs-6">
                备&nbsp;&nbsp;&nbsp;&nbsp;注： <form:input path="remarks"  id="remarks" style="height:25px" class="input-xlarge"/>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-xs-6">
                供货商：
                <form:select path="vendorid" class="input-xlarge">
                    <form:option value="">请选择供货商...</form:option>
                    <form:options items="${erpVendorlist}"
                                  itemLabel="vendorDesc" itemValue="id" htmlEscape="false" style="height:30px"/>
                </form:select>
            </div>
            <div class="col-xs-6">
                部&nbsp;&nbsp;&nbsp;&nbsp;门：
                <form:select path="depid" class="input-xlarge" >
                    <form:option value="">请选择入库部门...</form:option>
                    <form:options items="${erpDepartmentslist}"
                                  itemLabel="departmentDesc" itemValue="id" htmlEscape="false"/>
                </form:select>
            </div>
        </div>
    </div>

    <div class="row" style="padding-left: 20px;padding-right: 20px">
        <br>
        <table id="table">
        <tfoot style="hight:20px">
        <tr><td></td><td></td><td></td><td><td></td><td></td><td></td><td></td><td style="margin:1px;padding-left: 30px"><a class="btn btn-default" onclick="append()" class="btn">新增</a></td></tr>
        </tfoot>
        </table>
    </div>
    <br>
    <div class="">
        <shiro:hasPermission name="rec:erpRec:edit">
            <input id="btnsave" class="btn btn-primary" onclick="SaveData()"
                   type="button" value="提交" />
        </shiro:hasPermission>
        <input id="btnCancel" class="btn btn-primary" type="button" value="返 回"
               onclick="history.go(-1)"
        />
    </div>
</form:form>
<!-- 模态框（Modal） -->
<div class="modal fade mm" id="myModal" style="width:760px;height:512px" tabindex="-1" >
        <div class="row" >
                <div class="modal-header" >
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x&nbsp;&nbsp;</button>
                    <h3 class="" id="myModalLabel">&nbsp;&nbsp;&nbsp;&nbsp;选择物品</h3>
                </div>
        </div>
        <div class="row" >
                <div class="modal-header box" style="height: 320px">
                    <table id="table1" class="table  table-condensed" style="table-layout: fixed;word-break:break-all;">
                    </table>
                </div>
        </div>
        <div class="row" >
                <div class="modal-footer" >
                   <input id="append" type="button" class="btn btn-primary butn" value="选择" onclick="appenddata()"></input>
                </div>
        </div>
</div>
<script>


    //名称
    function editFormatter(value,row,index){
        return [
            '<input type="text" id="1plan'+row.subid+'" style="height:26px;margin: 0px 0px 0px 0px" class="Desc" data='+value+' value='+value+' onkeydown="myFunction(event,'+row.subid+',1)"/>'
        ].join("");

    }
    //数量
    function editFormatter1(value,row,index){
        return [
            '<input type="text" id="2plan'+row.subid+'" style="height:26px;margin: 0px 0px 0px 0px" class="Qty" data='+value+' value='+value+'>'
        ].join("");
    }
    //单价
    function editFormatter2(value,row,index){
        return [
            '<input type="text" id="3plan'+row.subid+'" style="height:26px;margin: 0px 0px 0px 0px" class="Price" data='+value+' value='+value+'>'
        ].join("");

    }

    var operatorQty = {
        "change .qty":function (e,value,row,index) { //单价列，注意通过样式.price监听
            var price = row.sp || 0;//单价   ||0 Price有值返回值，无值返回0
            var nums = $("#"+"2plan"+row.subid).val() || 0;  //数量
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
            $("#"+"2plan"+row.subid).attr("readonly",true)
        },
        "focus .qty":function (e,value,row,index) {//单价列，得到焦点
            $("#"+"2plan"+row.subid).attr("readonly",false)
        }


    }




    //模态框实现列表选择
    var sid=""
    function myFunction(event,id,type) {
        sid=id;

        var e = event || window.event || arguments.callee.caller.arguments[0];
        var input=$("#"+type+"plan"+id).val(); //获取改变后的输入框的值
        var oldvalue = $("#"+type+"plan"+id).attr("data"); //获取输入框原本的值

        if (isEmpty(input)) {return;}

        if(e && e.keyCode==13){
           $("#"+type+"plan"+id).blur();
           InitTableSub()                                        //初始化弹出框Table
           var queryUrl =  "${ctx}/rec/erpRec/getItemList?input=" + input;
           $('#table1').bootstrapTable('refresh',{url:queryUrl});
           $("#myModal").modal('show');
        }
    }

    //非模态框实现列表选择
    function show(event,id,type){
        var e = event || window.event || arguments.callee.caller.arguments[0];
        var input=$("#"+type+"plan"+id).val(); //获取改变后的输入框的值
        if (isEmpty(input)) {return;}

        $.jBox.open("iframe:${ctx}/rec/erpRec/getItemList?input=" + input, "", 600, 350, {
                 buttons: {"选择": "ok", "关闭": true},submit: function (v, h, f) {
                if(v=="ok") {
                    var table=h.find("iframe")[0].contentWindow.document.getElementById("table1");
                }
            },
            loaded: function (h) {
                $(".jbox-content", document).css("overflow-y", "hidden");
            }
        });
    };

    //判断字符是否为空的方法
    function isEmpty(obj){
        var regu = "^[ ]+$";
        var re = new RegExp(regu);
        if(typeof obj == "undefined" || obj == null || obj == "" || re.test(obj)){
            return true;
        }else{
            return false;
        }
    }

    /*
    Description:保存数据
     */
    function SaveData() {

        if(!checkDetailInfo()){return;}  //明细校验
        var params = {};// 参数对象
        params.id = $.trim($("#id").val());
        params.no = $.trim($("#no").val());
        params.depid = $.trim($("#depid").val());
        params.vendorid = $.trim($("#vendorid").val());
        var token=$('#token').val();   //$("input[name='token']").val();
        params.erpRecDetailList =$('#table').bootstrapTable('getData');
        $.ajax({
            type : "post",
            url : "${ctx}/rec/erpRec/Save?token="+token,
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

        if((!checkMainInfo())||(!checkDetailInfo())){return;}


        var count = $('#table').bootstrapTable('getData').length;
        $('#table').bootstrapTable('insertRow', {
            index: count,
            row: {
                id:"",
                subid:count+1,
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

        if(row==""){return;}
        $('#table').bootstrapTable('updateRow', {
            index: sid-1,
            row: {
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






    /*
    Description:主信息校验
     */
    function checkMainInfo(){
        if($.trim($("#depid").val())==""){
            layer.msg("请选择部门!");
            return false;
        }
        if($.trim($("#vendorid").val())==""){
            layer.msg("请选择供货商!");
            return false;
        }
        return true;
    }

    /*
    Description:明细数据校验
     */
    function checkDetailInfo(){
        var rows = $('#table').bootstrapTable('getData');   //行的数据
        for(var i=0;i<rows.length;i++){
            if(rows[i].itemdesc==""){
                layer.msg("项目不能为空!");
                return false;
            };
            if(rows[i].qty==""){
                layer.msg("数量不能为空!");
                return false;
            }
        }
        return true;
    }
</script>
</body>

</html>
