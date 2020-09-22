<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<c:set var="ctx" value="${pageContext.request.contextPath}${fns:getAdminPath()}" />
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static" />

<html>
<head>
	<title>测试</title>
	<meta name="decorator" content="default"/>
	<!--引入4.0.0BootStrap-->

	<script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript"></script>

	<%--引入BootStrap Table--%>
	<link href="${pageContext.request.contextPath}/static/bootstrap-table/bootstrap-table.css" type="text/css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
	<script src="${pageContext.request.contextPath}/static/bootstrap-table/bootstrap-table.js" type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/static/bootstrap-table/locale/bootstrap-table-zh-CN.js" type="text/javascript"></script>
    <style>
		.modal.fade.in{
			top:150px;
			left:650px;
		}
	</style>
	<script type="text/javascript">
        window.onload = function() {
            $('#myModal').on('hide.bs.modal', function() {

            })
        };
     function submit(){
         $.ajax({
             type : "post",
             url : "${ctx}/lxt/test/requiredCookie",
             contentType : "application/text;charset=utf-8",
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
     function submit1(){
         $.ajax({
             type : "post",
             url : "${ctx}/lxt/test/session",
             contentType : "application/text;charset=utf-8",
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
     function uploadPhoto() {
         $("#photoFile").click();
     }

     function upload(){
         if ($("#photoFile").val() == '') {
             return;
         }

         var formData = new FormData();
         formData.append('photo', document.getElementById('photoFile').files[0]);
         alert(formData.get("phone"));

         $.ajax({
             type : "post",
             url : "${ctx}/lxt/test/photoUpload",
             data: formData,
             contentType: false,
             processData: false,
             success: function(data) {
                 if (data.type == "success") {

                     $("#preview_photo").attr("src", data.filepath+data.filename);
                     $("#path").attr("value", data.filepath+data.filename);
                     $("#productImg").val(data.filename);
                 } else {
                     alert(data.msg);
                 }
             },
             error:function(data) {
                 alert("上传失败")
             }
         });
     }

     function addRow(list, idx, tpl, row){
         $(list).append(Mustache.render(tpl, {
             idx: idx, delBtn: true, row: row
         }));
         $(list+idx).find("select").each(function(){
             $(this).val($(this).attr("data-value"));
         });
         $(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
             var ss = $(this).attr("data-value").split(',');
             for (var i=0; i<ss.length; i++){
                 if($(this).val() == ss[i]){
                     $(this).attr("checked","checked");
                 }
             }
         });
     }
     function delRow(obj, prefix){
         var id = $(prefix+"_id");
         var delFlag = $(prefix+"_delFlag");
         if (id.val() == ""){
             $(obj).parent().parent().remove();
         }else if(delFlag.val() == "0"){
             delFlag.val("1");
             $(obj).html("&divide;").attr("title", "撤销删除");
             $(obj).parent().parent().addClass("error");
         }else if(delFlag.val() == "1"){
             delFlag.val("0");
             $(obj).html("&times;").attr("title", "删除");
             $(obj).parent().parent().removeClass("error");
         }
     }
	</script>
</head>
<>
<h4>测试界面</h4>
<input id="btnsave" class="btn btn-primary" onclick="submit()"
		 type="button" value="CookieValue" />
<input id="btnSession" class="btn btn-primary" onclick="submit1()"
	   type="button" value="Session" />

<input id="btnModelAttribute" class="btn btn-primary" onclick="submit2()"
	   type="button" value="ModelAttribute" />

<input  id="name" class="input-xlarge required" readonly="true" >


<a href="${ctx}/lxt/test/form?id=23">修改</a>


<%--<div>
	<a href="javascript:void(0)" onclick="uploadPhoto()">选择图片</a>
	<input type="file" id="photoFile"  onchange="upload()">
	<img id="preview_photo" src="" width="200px" height="200px">
	<input id="path">
</div>
<h4>${'明日科技'}</h4>
<h4>${"明日科技"}</h4>

${pageContext.out.bufferSize/1024}M

${pageContext.page}
11
${pageContext.servletContext.contextPath}--%>
<br>
<br>
<br>
<h3>表格测试</h3>
<div class="control-group">
	<label class="control-label"><h2>业务数据子表：</h2></label>
	<div class="controls">
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead>
			<tr>
				<th class="hide"></th>
				<th>编码</th>
				<th>名称</th>
				<th>规格</th>
				<th>单位</th>
				<th>数量</th>
				<th>单价</th>
				<th>金额</th>
				<shiro:hasPermission name="test:testDataMain:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
			</tr>
			</thead>
			<tbody id="testDataChildList">
			</tbody>
			<shiro:hasPermission name="test:testDataMain:edit"><tfoot>
			<tr><td colspan="9"><a href="javascript:" onclick="addRow('#testDataChildList', testDataChildRowIdx, testDataChildTpl);testDataChildRowIdx = testDataChildRowIdx + 1;" class="btn">新增</a></td></tr>
			</tfoot></shiro:hasPermission>
		</table>

		<script type="text/template" id="testDataChildTpl">//<!--
						<tr id="testDataChildList{{idx}}">
							<td class="hide">
								<input id="testDataChildList{{idx}}_id" name="testDataChildList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="testDataChildList{{idx}}_delFlag" name="testDataChildList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td >
								<input id="testDataChildList{{idx}}_name" name="testDataChildList[{{idx}}].code"  type="text" value="{{row.name}}" maxlength="100" class="input-small "/>
							</td>
							<td >
								<input id="testDataChildList{{idx}}_remarks" name="testDataChildList[{{idx}}].desc" onkeydown="show()" type="text" value="{{row.remarks}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="testDataChildList{{idx}}_remarks" name="testDataChildList[{{idx}}].spec" type="text" value="{{row.remarks}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="testDataChildList{{idx}}_remarks" name="testDataChildList[{{idx}}].uom" readonly="true" type="text" value="{{row.remarks}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="testDataChildList{{idx}}_remarks" name="testDataChildList[{{idx}}].qty" type="text" value="{{row.remarks}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="testDataChildList{{idx}}_remarks" name="testDataChildList[{{idx}}].sp" type="text" value="{{row.remarks}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="testDataChildList{{idx}}_remarks" name="testDataChildList[{{idx}}].amt" type="text" value="{{row.remarks}}" maxlength="255" class="input-small "/>
							</td>

							<shiro:hasPermission name="test:testDataMain:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#testDataChildList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
		</script>
		<script type="text/javascript">
            var testDataChildRowIdx = 0, testDataChildTpl = $("#testDataChildTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
            $(document).ready(function() {
                var data = ${fns:toJson(testDataMain.testDataChildList)};
                for (var i=0; i<data.length; i++){
                    addRow('#testDataChildList', testDataChildRowIdx, testDataChildTpl, data[i]);
                    testDataChildRowIdx = testDataChildRowIdx + 1;
                }
            });

            //模态框实现列表选择
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
                            var $label = $('<label for="'+ id +'"></label>');
                            $check.attr("id", id).parent().addClass("checkbox-custom").append($label);
                        });
                    },

                });


            };
            function show(){
                var e = event || window.event || arguments.callee.caller.arguments[0];
                if(e && e.keyCode==13){
                    InitTableSub()                                        //初始化弹出框Table
                    var queryUrl =  "${ctx}/rec/erpRec/getItemList?input=";
                    $('#table1').bootstrapTable('refresh',{url:queryUrl});
                    $("#myModal").modal('show');
                }
			}
            function close_p(){
                $("#myModal").modal('hide');
                $("body").removeClass('modal-open');
                $('body').css("overflow-y", "scroll");
                $('body').css("padding-right", "0px");
            }
		</script>
	</div>
</div>
<!-- 模态框（Modal） -->
<div class="modal fade mm" id="myModal" style="width:760px;height:482px" tabindex="-1" >
	<div class="row" >
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x&nbsp;&nbsp;</button>
			<h3 class="" id="myModalLabel">&nbsp;&nbsp;&nbsp;&nbsp;选择物品</h3>
		</div>
	</div>
	<div class="row" >
		<div class="modal-header box" style="height: 300px">
			<table id="table1" class="table  table-condensed" style="table-layout: fixed;word-break:break-all;">
			</table>
		</div>
	</div>
	<div class="row" >
		<div class="modal-footer">
			<input id="append" type="button" class="btn btn-primary butn" value="选择" onclick="appenddata()"></input>
			<button type="button" class="btn btn-primary" onclick="close_p()">
				提交
			</button>
		</div>
	</div>
</div>
</body>



</html>
