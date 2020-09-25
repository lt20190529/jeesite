<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 

<c:set var="ctx"
	value="${pageContext.request.contextPath}${fns:getAdminPath()}" />
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static" />
<html>
<head>
<title>测试</title>
<meta name="decorator" content="default" />
<style>
	.upload{
		padding: 4px 6px;
		height:30px;
		position: relative;
	}
	.change{
		  position: absolute;
		  overflow: hidden;
		  right: 0;
		  top: 0;
		  opacity: 0;
	  }
</style>

<link
	href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.css"
	type="text/css" rel="stylesheet" />
    <link rel="stylesheet"
	href="${ctxStatic}/jquery-easyui/themes/default/easyui.css"
	type="text/css" />

	<script src="https://cdn.bootcss.com/bootstrap-validator/0.5.3/js/bootstrapValidator.js"></script>

	<%--<script src="${pageContext.request.contextPath}/static/lodop/LodopFuncs.js"></script>
	<object  id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
		<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
	</object>--%>
<script>
    $(document).ready(function() {

        $("#optionsRadios1").prop("checked", false) //$("#optionsRadios").attr("checked", false);   //
        $("#optionsRadios").prop("checked", false);

        $("#btnExcel").click(function(){
            var url =  $("#searchForm").attr("action");
            top.$.jBox.confirm("确认要导出数据吗？","系统提示",function(v,h,f){
                if(v=="ok"){
                    $("#DrugForm").attr("action","${ctx}/Drug/DrugInfo/Excel");
                    $("#DrugForm").submit();
                }
                $("#searchForm").attr("action",url);

            },{buttonsFocus:1});
            top.$('.jbox-body .jbox-icon').css('top','55px');
        })

        $("#btnImport").click(function(){
            $.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true},
                bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
        });

        $("#btnprint").click(function () {
            var LODOP=getLodop();
            LODOP.PRINT_INIT("打印药品字典信息");               //首先一个初始化语句
            LODOP.ADD_PRINT_TEXT(0,0,100,20,"文本内容一");//然后多个ADD语句及SET语句
            LODOP.PRINT_INIT("");
            LODOP.SET_PRINT_PAGESIZE(0,5500,4000,"");
            LODOP.ADD_PRINT_TABLE(10,0,1500,1800,document.getElementById("table").innerHTML);
            LODOP.PRINT_DESIGN();
        })
	})

	//分页
    function page(n,s){
        if(n) $("#pageNo").val(n);
        if(s) $("#pageSize").val(s);
        $("#DrugForm").attr("action","${ctx}/Drug/DrugInfo/QueryDrugInfo");
        $("#DrugForm").submit();
        return false;
    }
</script>
</head>
<body>
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/Drug/DrugInfo/import" method="post" enctype="multipart/form-data"
			  class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<a href="${ctx}/Drug/DrugInfo/import/template">下载模板</a>
		</form>
	</div>
	<%--@elvariable id="Drug" type=""--%>
	<form:form id="DrugForm" modelAttribute="Drug"
		action="${ctx}/Drug/DrugInfo/QueryDrugInfo" method="post">

		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>

		<div class="container-fluid">
			<div class="row-fluid ">
				<div class="row">
					<div class="col-md-5">
						<h4><span class="glyphicon glyphicon-th-large">药品检索</span></h4>
					</div>
					<div class="col-md-offset-5 col-md-2">
						<button type="button" class="btn btn-primary" onclick="addDrug()">新增</button>
						<button type="submit" class="btn btn-primary" onclick="return page();">查询</button>
						<button type="button" class="btn btn-primary">清屏</button>

					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col-md-3 form-inline">
						药品编码：<input class="input-medium" type="text" name="Drug_Code" path="Drug_Code"/>
					</div>
					<div class="col-md-3 form-inline">
						药品名称：<input class="input-medium" type="text" name="Drug_Desc" path="Drug_Desc"/>
					</div>
					<div class="col-md-3 form-inline">
						药品别名：<input class="input-medium" type="text" name="Drug_Alias" path="Drug_Alias"/>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="col-md-3 form-inline">
						类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;组：
						<select
							class="input-medium" name="Drug_Class_Dr">
							<option value="0"></option>
							<option value="1">西药</option>
							<option value="2">中成药</option>
							<option value="3">中草药</option>
						</select>
						
					</div>

					<div class="col-md-3 form-inline">
						库存分类：
						<select class="input-medium" name="Drug_Cat_Dr">
							<option value="0"><option>
							<option value="1">西药</option>
							<option value="2">中成药</option>
							<option value="3">中草药</option>
						</select>
					</div>

					<div class="col-md-3 ">
						是否启用： 
						<label class="radio-inline"> <input type="radio"
							name="Drug_ActiveFlag" id="optionsRadios"
							checked>启用
						</label> <label class="radio-inline"> <input type="radio"
							name="Drug_ActiveFlag" id="optionsRadios1">禁用
						</label>
					</div>


				</div>
				<hr>
				<div class="row">
					<div class="col-md-4">
					    <h4><span class="glyphicon glyphicon-list-alt">药品列表</h4>
					</div>
					<div class="col-md-2 col-md-offset-6">

						<input type="button" class="btn btn-primary" id="btnExcel" value="导出"/>
						<input id="btnImport" class="btn btn-primary" type="button" value="导入"/>
					    <input type="button" class="btn btn-primary" id="btnprint" value="打印"/>

					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<sys:message content="${message}"/>
						<table id="table" class="table table-striped table-bordered table-condensed">
							<thead>
							<tr>
								<th style="display:none;">ID</th>
								<th style="align:center">编码</th>
								<th>描述</th>
								<th>规格</th>
								<th>单位</th>
								<th>库存大类</th>
								<th>库存分类</th>
								<th>售价</th>
								<th>进价</th>
								<th>别名</th>
								<th>条码</th>
								<th>基本药物</th>
								<th>是否在用</th>
								<th>逻辑删除</th>
								<th>创建人</th>
								<th>创建日期</th>
								<shiro:hasPermission name="item:erpItem:edit"><th>操作</th></shiro:hasPermission>
							</tr>
							</thead>
							<tbody>
							<c:forEach items="${page.list}" var="drug">
								<tr>
									<td style="display:none;">
											${drug.drug_id}
									</td>
									<td>
											${drug.drug_Code}
									</td>
									<td>
											${drug.drug_Desc}
									</td>
									<td>
											${drug.drug_Spec}
									</td>
									<td>
											${drug.drug_Uom.erpUomdesc}
									</td>
									<td>
										<c:choose>
											<c:when test="${drug.drug_Class_Dr=='1'}">
												西药
											</c:when>
											<c:when test="${drug.drug_Class_Dr=='2'}">
												中药
											</c:when>
											<c:when test="${drug.drug_Class_Dr=='3'}">
												草药
											</c:when>
										</c:choose>
									</td>
									<td>
										<c:choose>
											<c:when test="${drug.drug_Cat_Dr=='1'}">
												西药
											</c:when>
											<c:when test="${drug.drug_Cat_Dr=='2'}">
												中药
											</c:when>
											<c:when test="${drug.drug_Cat_Dr=='3'}">
												草药
											</c:when>
										</c:choose>
									</td>
									<td>
										    ${drug.drug_Sp}
									</td>
									<td>
											${drug.drug_Rp}
									</td>
									<td>
											${drug.drug_Alias}
									</td>
									<td>
											${drug.drug_BarCode}
									</td>
									<td>
											${drug.drug_BaseDrugFlag=='true'?'是':'否'}
									</td>
									<td>
											${drug.drug_ActiveFlag=='true'?'是':'否'}
									</td>
									<td>
											${drug.delFlag=='1'?'是':'否'}
									</td>
									<td>
											${drug.createBy}
									</td>
									<td>
										<fmt:formatDate value="${drug.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<shiro:hasPermission name="item:erpItem:edit"><td>
										<a  onclick="editDrug('${drug.drug_id}')">修改</a>
										<a href="${ctx}/Drug/DrugInfo/delete?id=${drug.drug_id}" onclick="return confirmx('确认要删除该字典维护吗？', this.href)">删除</a>
									</td></shiro:hasPermission>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						<div class="pagination">${page}</div>
					</div>
				</div>
				</div>

			</div>
		</div>

	</form:form>


	<div class="modal" id="MyModal"
		 style="width:900px;height:580px;top:60px;left:600px" tabindex="-1" role="dialog"
		 aria-labelledby="myModalLabel" aria-hidden="true">

				<div class="modal-header">
					<h3>维护</h3>
				</div>
				<div class="modal-body">
					<form:form id="DrugInfoForm" modelAttribute="Drug" action="${ctx}/Drug/DrugInfo/Save"
							   method="post" class="form-horizontal">
                        <form:hidden path="Drug_id"></form:hidden>
						<div id="myTabContent" class="">
							<div class="tab-pane fade in active" id="BaseInfo">
								<div class="row form-inline">


									<div class="col-md-2"><span style="color:red">*</span>&nbsp;&nbsp;药品编码：</div>
									<div class="col-md-3">
										<form:input class="input-medium required" type="text" path="Drug_Code" autocomplete="off"
													placeholder="请输入药品编码" required="required" />

									</div>
									<div class="col-md-2"><span style="color:red">*</span>&nbsp;&nbsp;药品描述：</div>
									<div class="col-md-3">
										<form:input class="input-medium" type="text" path="Drug_Desc" autocomplete="off"
													placeholder="请输入药品描述" required="true"/>
									</div>
									<div class="col-md-2">
										<div class="checkbox">
											<label>
												<form:checkbox path="Drug_BaseDrugFlag" value="1"/>
												基本药物
											</label>
										</div>
									</div>
								</div>
								<br>
								<div class="row form-inline">

									<div class="col-md-2"><span style="color:red">*</span>&nbsp;&nbsp;规格：</div>
									<div class="col-md-3">
										<form:input class="input-medium" type="text"
													path='Drug_Spec' placeholder="请输入规格" autocomplete="off" required="true"/>
									</div>
									<div class="col-md-2"><span style="color:red">*</span>&nbsp;&nbsp;单位：</div>
									<div class="col-md-3">
										<form:select path="Drug_Uom" class="input-medium">
											<form:option value="">请选择单位</form:option>
											<form:options items="${uomlist}" itemLabel="erpUomdesc"
														  itemValue="erpUomcode" htmlEscape="false" />
										</form:select>
									</div>
									<div class="col-md-2">
										<div class="checkbox">
											<label> <form:checkbox path="Drug_ActiveFlag"
											/>是否启用</label>
										</div>
									</div>
								</div>
								<br>
								<div class="row form-inline">

									<div class="col-md-2"><span style="color:red">*</span>&nbsp;&nbsp;库存大类：</div>
									<div class="col-md-3">
										<form:select path="Drug_Class_Dr" class="input-medium">
											<form:option value="">请选择分类</form:option>
											<form:option value="1">西药</form:option>
											<form:option value="2">中药</form:option>
											<form:option value="3">草药</form:option>
										</form:select>
									</div>
									<div class="col-md-2"><span style="color:red">*</span>&nbsp;&nbsp;库存小类：</div>
									<div class="col-md-3">
										<form:select path="Drug_Cat_Dr" class="input-medium">
											<form:option value="">请选择分类</form:option>
											<form:option value="1">西药</form:option>
											<form:option value="2">中药</form:option>
											<form:option value="3">草药</form:option>
										</form:select>
									</div>


								</div>
								<br>
								<div class="row form-inline">

									<div class="col-md-2"><span style="color:red">*</span>&nbsp;&nbsp;进价：</div>
									<div class="col-md-3">
										<form:input class="input-medium" type="text" path="Drug_Rp"
													placeholder="请输入进价" autocomplete="off"/>
									</div>
									<div class="col-md-2"><span style="color:red">*</span>&nbsp;&nbsp;售价：</div>
									<div class="col-md-3">
										<form:input class="input-medium" type="text" path="Drug_Sp"
													placeholder="请输入售价" autocomplete="off"/>
									</div>

								</div>
								<br>
								<div class="row form-inline">

									<div class="col-md-2">&nbsp;&nbsp;别名：</div>
									<div class="col-md-3">
										<form:input class="input-medium" type="text" path="Drug_Alias"
													placeholder="请输入别名" autocomplete="off"/>
									</div>
									<div class="col-md-2"><span style="color:red">*</span>&nbsp;&nbsp;条码：</div>
									<div class="col-md-3">
										<form:input class="input-medium" type="text" path="Drug_BarCode"
													name='Drug_BarCode' placeholder="请输入条码" autocomplete="off" required="true"/>
									</div>
								</div>
								<br>
								<div class="row form-inline">
									<div class="col-md-2"><span style="color:red">*</span>&nbsp;&nbsp;药品图片：</div>

									<img id="preview_photo" src="" style="height:150px;width:250px;padding: 3px;" border="4">
									<form:input id="Drug_Phone" path="Drug_Phone" type="hidden"/>

									<a type="button" class="btn btn-primary upload" id="up_btn">
										<input class="change" type="file" id="photoFile"  multiple="multiple" onchange="upload()"/>
										<i class="fa fa-upload"></i>选择图片
									</a>
								</div>
								<hr>
							</div>
						</div>
					</form:form>
				</div>
				<div class="modal-footer">
					<button class="btn"  aria-hidden="" onclick="cancle()">取消</button>
					<button class="btn btn-primary" onclick="SaveDrug()"
							aria-hidden="true">提交</button>

		</div>
	</div>




    

	<script>
        function cancle(){

            $("#MyModal").modal('hide');
            $("#DrugInfoForm").validate().resetForm();
            $("#DrugInfoForm").removeClass("has-error");
            $("#MyModal").on("hide.bs.modal", function() {
                document.getElementById("DrugInfoForm").reset();

            });


        }
		$(document).ready(function() {

            $("#DrugInfoForm").validate({
				rules:{
					Drug_Code:{remote:{url:"${ctx}/drug/DrugInfo/checkDrugByCode"}},
					Drug_Desc:{remote:{url:"${ctx}/drug/DrugInfo/checkDrugByDesc",type:"post"}}
				},
				messages:{
					Drug_Code:{required: "代码不能为空",remote:"代码已经存在"},
					Drug_Desc:{required: "描述不能为空",remote:"描述已经存在..."}
				}
			});
		});

        function uploadPhoto() {
            $("#photoFile").click();
        }
        function upload(){
            if ($("#photoFile").val() == '') {
                return;
            }

            var formData = new FormData();
            formData.append('photo', document.getElementById('photoFile').files[0]);

            $.ajax({
                type : "post",
                url : "${ctx}/Drug/DrugInfo/photoUpload",
                data: formData,
                contentType: false,
                processData: false,
                success: function(data) {
                    if (data.type == "success") {
                        $("#preview_photo").attr("src", data.filepath+data.filename);
                        $("#Drug_Phone").attr("value", data.filepath+data.filename);
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



		
		function addDrug(){
		    $("#Drug_id").val("");
		    $("#MyModal").modal("show");
		}
		function editDrug(drugID) {
            $.ajax({
                type : "post",
                url : "${ctx}/Drug/DrugInfo/getDrugInfo/"+drugID,
                dataType : 'json',
                success : function(data) {
                    showInfo(data)
                }
            });
		}
		function showInfo(data){
            $("#MyModal").modal("show");

            $("#Drug_id").val(data.drug_id);
            $("#Drug_Code").val(data.drug_Code);
            $("#Drug_Desc").val(data.drug_Desc);
            $("#Drug_Spec").val(data.drug_Spec);
            var num = data.drug_Class_Dr;
            var num1 = data.drug_Uom.erpUomcode;
            $("#Drug_Class_Dr").val(num).select2();
            $("#Drug_Uom").val(num1).select2();

            $("#Drug_Phone").val(data.drug_Phone!= undefined ? data.drug_Phone:"");
            $("#preview_photo").attr("src",data.drug_Phone!= undefined ? data.drug_Phone:"");
            $("#Drug_BarCode").val(data.drug_BarCode);
            $("#Drug_Sp").val(data.drug_Sp);
            $("#Drug_Rp").val(data.drug_Rp);
            $("#Drug_Phone").val(data.drug_Phone);
            $("[name='Drug_BaseDrugFlag']").attr("checked", data.drug_BaseDrugFlag?true:false);
            $("[name='Drug_ActiveFlag']").attr("checked", data.drug_ActiveFlag?true:false);
            $("#Drug_Alias").val(data.drug_Alias);
		}

		

		function SaveDrug() {
			//alert($("#DrugInfoForm").serialize())
			//表单必填信息校验
            if(($('#Drug_id').val()=="")&&($('#DrugInfoForm').valid()==false)){
                return;
			};
			$.ajax({
				url : "${ctx}/Drug/DrugInfo/Save",
				method : "post",
				data : $("#DrugInfoForm").serialize(),
				contentType : "application/x-www-form-urlencoded",
				dataType : "json",
				success : function(data) {
					if (data.state == "success") {
						layer.alert($("input:hidden[name='"+"Drug_id"+"']").val()?"编辑成功":"保存成功");
						$("#MyModal").modal('hide');
						document.getElementById("DrugInfoForm").reset();
						$("#DrugInfoForm").validate().resetForm();
					}
				},
				error : function() {
					layer.alert("保存失败!");
				}
			});
		}


		function QueryDrug() {
			var formdata = $("#DrugForm").serializeJson();
			$('#table').datagrid('load', formdata);
		}
		/*
		   自定义jquery函数，完成将form 数据转换为 json格式 
		 */
		$.fn.serializeJson = function() {
			var serializeObj = {};
			var array = this.serializeArray();
			// var str=this.serialize(); 
			$(array).each(
					function() { // 遍历数组的每个元素 
						if (serializeObj[this.name]) { // 判断对象中是否已经存在 name，如果存在name 
							if ($.isArray(serializeObj[this.name])) {
								serializeObj[this.name].push(this.value); // 追加一个值 hobby : ['音乐','体育'] 
							} else {
								// 将元素变为 数组 ，hobby : ['音乐','体育'] 
								serializeObj[this.name] = [
										serializeObj[this.name], this.value ];
							}
						} else {
							serializeObj[this.name] = this.value; // 如果元素name不存在，添加一个属性 name:value 
						}
					});
			return serializeObj;
		};
	</script>

</body>


</html>



                 





