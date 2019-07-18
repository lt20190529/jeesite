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
.container-fluid {
	padding-right: 0px;
	padding-left: 0px;
}

.modal.fade.in {
	left: 500px;
	overflow：hidden
}
</style>

<link
	href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	type="text/css" rel="stylesheet" />
<link rel="stylesheet"
	href="${ctxStatic}/jquery-easyui/themes/default/easyui.css"
	type="text/css" />

</head>
<body>
	<form:form id="DrugForm" modelAttribute=""
		action="${ctx}/Drug/DrugInfo/QueryDrugInfo" method="post">
		<div class="container-fluid">
			<div class="row-fluid ">
				<div class="row">
					<div class="col-md-5">
						<h4><span class="glyphicon glyphicon-th-large">药品检索</span></h4>
					</div>
					<div class="col-md-offset-5 col-md-2">
						<button type="button" class="btn btn-primary" onclick="addDrug()">新增</button>
						<button type="button" class="btn btn-primary" onclick="QueryDrug()">查询</button>
						<button type="button" class="btn btn-primary">清屏</button>

					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col-md-3 form-inline">
						药品编码：<input class="input-medium" type="text" name="drug.Drug_Code"/>
					</div>
					<div class="col-md-3 form-inline">
						药品名称：<input class="input-medium" type="text" name="drug.Drug_Desc"/>
					</div>
					<div class="col-md-3 form-inline">
						药品别名：<input class="input-medium" type="text" name="drug.Drug_Alias"/>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="col-md-3 form-inline">
						类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;组：<select
							class="input-medium" name="drug.Drug_Class_Dr">
							<option value="1">西药</option>
							<option value="2">中成药</option>
							<option value="3">中草药</option>
						</select>
						
					</div>

					<div class="col-md-3 form-inline">
						库存分类：<input class="input-medium" type="text" name="drug.Drug_Cat_Dr" />
					</div>

					<div class="col-md-3 ">
						是否启用： 
						<label class="radio-inline"> <input type="radio"
							name="drug.Drug_ActiveFlag" id="optionsRadios" value="1"
							checked>启用
						</label> <label class="radio-inline"> <input type="radio"
							name="drug.Drug_ActiveFlag" id="optionsRadios" value="0">禁用
						</label>
					</div>


				</div>
				<hr>
				<div class="row">
					<div class="col-md-4">
					    <h4><span class="glyphicon glyphicon-list-alt">药品列表</h4>
					</div>
					<div class="col-md-5"></div>
					<div class="col-md-offset-6 col-md-1">
						<button type="button" class="btn btn-primary" onclick="execl()">导出</button>
					</div>
					<div class="col-md-1">
					    <button type="button" class="btn btn-primary" onclick="print()">打印</button>
					</div>
					<div class="col-md-12">
						<table id="table"></table>
					</div>
					
				</div>

			</div>
		</div>

	</form:form>



	<div class="modal fade" id="MyModal" tabindex="-1"
		style="width:900px;height:520px" data-backdrop="static">
		<div class="modal-header">
			<h3>维护</h3>
		</div>
		<div class="modal-body">
			<form:form id="DrugInfoForm" modelAttribute="Drug" action="${ctx}/Drug/DrugInfo/Save"
				method="post" class="form-horizontal">

				<ul id="myTab" class="nav nav-tabs">
					<li class="active"><a href="#BaseInfo" data-toggle="tab">
					<span class="glyphicon glyphicon-cog">基本信息</span>
					</a></li>
					<li><a href="#OtherInfo" data-toggle="tab">
					<span class="glyphicon glyphicon-cog">附加信息</span>
					</a></li>
				</ul>
				<div id="myTabContent" class="tab-content">
					<!-- 库存项 -->
					<div class="tab-pane fade in active" id="BaseInfo">
						<br>
						<div class="row form-inline">
                            <input type="hidden" id="Drug_id" name="Drug_id" />
                           
							<div class="col-md-2"><span style="color:red">*</span>&nbsp;&nbsp;药品编码：</div>
							<div class="col-md-3">
								 <form:input class="input-medium required" type="text" path="Drug_Code" autocomplete="off"
									placeholder="请输入药品编码" />
								 
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
						<hr>

					</div>
					<!-- 其他信息-->
					<div class="tab-pane fade" id="OtherInfo">
						<br>
						<div class="row col-md-offset-1">
							<div class=" form-group">
								<label for="inputfile">文件上传</label> <input type="file"
									id="inputfile">
								<p class="help-block">这里是块级帮助文本的实例。</p>
							</div>
						</div>
						<br>
						<div class="row col-md-offset-1 ">
							<%-- <div class="control-group">
								<label class="control-label">图片:</label>
								<div class="">
						        <a href="#" class="thumbnail">
						            <img src="../jeesite/static/images/IMG.jpg"
						                 alt="请上传头像...">
						        </a>
						    </div>
							<div class="controls">
								<form:hidden id="nameImage" path="photo" htmlEscape="false" maxlength="255" class="input-xlarge"/>
								<sys:ckfinder input="nameImage" type="images" uploadPath="/photo" selectMultiple="false" maxWidth="100" maxHeight="100"/>
							</div>
							</div> --%>
						</div>
						<br>
						<div class="row"></div>
						<br>
						<div class="row"></div>
					</div>
				</div>
			</form:form>
		</div>
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" aria-hidden="true" onclick="cancle()">取消</button>
			<button class="btn btn-primary" onclick="SaveDrug()"
				aria-hidden="true">提交</button>
		</div>
	</div>



    

	<script>
		$(document).ready(function() {
			//页签切换
			$('#myTab a:first').tab('show');//初始化显示哪个tab 
			$('#myTab a').click(function(e) {
				e.preventDefault();//阻止a链接的跳转行为 
				$(this).tab('show');//显示当前选中的链接及关联的content 
			});
			
			
			
			$("#DrugInfoForm").validate({
				rules:{
					Drug_Code:{remote:{url:"${ctx}/Drug/DrugInfo/checkDrugByCode"}},
					Drug_Desc:{remote:{url:"${ctx}/Drug/DrugInfo/checkDrugByDesc",type:"post"}}
				},
				messages:{
					Drug_Code:{required: "代码不能为空",remote:"代码已经存在"},
					Drug_Desc:{required: "描述不能为空",remote:"描述已经存在..."}
				}
			});

			GetUserList();
			
			
		});

		function cancle(){
			$("#MyModal").modal('hide');
			$("#MyModal").on("hide.bs.modal", function() {
				document.getElementById("DrugInfoForm").reset();
				$("#DrugInfoForm").validate().resetForm();
				$("#DrugInfoForm").removeClass("has-error");
			});
		}

		
		function GetUserList() {
			
			$("#table").datagrid({
				url : "${ctx}/Drug/DrugInfo/getListjqGrid",
				queryParams : //每次请求的参数
				{
					
				},
				fitColumns : true,
				pagination : true,//允许分页
				rownumbers : true,//行号
				pageNumber : 1,
				singleSelect : true,//只选择一行
				pageSize : 10,//每一页数据数量
				checkOnSelect : false,
				pageList : [ 10, 20, 30 ],
				columns : [ [ {
					field : "drug_id",
					title : "药品ID",
					align : "center",
					width : 100,
					hidden:"true"
				}, {
					field : "drug_Code",
					title : "药品编码",
					align : "center",
					width : 100
				}, {
					field : "drug_Desc",
					title : "药品描述",
					align : "center",
					width : 200
				}, {
					field : "drug_Spec",
					title : "规格",
					align : "center",
					width : 100
				}, {
					field : "drug_Uom",
					title : "药品单位",
					align : "center",
					width : 100,
					formatter:function(value,row){ 
	                    if (value!= undefined){
	                    	return row.drug_Uom.erpUomdesc;
					    }else{
					    	return ""; //--值用于显示
					    };
	                }
				}, {
					field : "drug_Class_Dr",
					title : "类组",
					align : "center",
					width : 100,
					formatter : function(value, row, index) {//通过此方法格式化显示内容,value表示从json中取出该单元格的值，row表示这一行的数据，是一个对象,index:行的序号
						if(value =='1'){
							return "西药";
						}else if(value =='2'){
							return "中成药";
						}else if(value =='3'){
							return "草药";
						}
					}
				}, {
					field : "drug_Alias",
					title : "别名",
					align : "left",
					halign: "center",
					width : 100
				}, {
					field : "drug_BarCode",
					title : "条码",
					align : "right",
					halign: "center",
					width : 100
				}, {
					field : "drug_Rp",
					title : "进价",
					align : "right",
					halign: "center",
					width : 100
				}, {
					field : "drug_Sp",
					title : "售价",
					align : "right",
					halign: "center",
					width : 100
				}, {
					field : "drug_BaseDrugFlag",
					title : "基本药物",
					align : "right",
					halign: "center",
					width : 100,
					formatter : function(value, row, index) {//通过此方法格式化显示内容,value表示从json中取出该单元格的值，row表示这一行的数据，是一个对象,index:行的序号
						if(value){
							return "是";
						}else {
							return "否";
						}
					}
				}, {
					field : "createBy",
					title : "创建人",
					align : "left",
					width : 100,
					formatter:function(value,row){ 
	                    if (value!= undefined){
	                    	return row.createBy.name;
					    }else{
					    	return ""; 
					    };
	                }
				}, {
					field : "createDate",
					title : "创建日期",
					align : "right",
					halign: "center",
					width : 150
				} ] ],

				//点击每一行的时候触发
				onClickRow : function(rowIndex, rowData) {
					editDrug(rowData);
				}
			});
		}
		
		function execl(){
			$("#table").datagrid('toExcel', {
			    filename: '药品字典列表'+2019+'.xls',
			    worksheet: 'Worksheet'
			});
		}
		function print(){
			$('#table').datagrid('print', 'DataGrid');
		}
		
		function addDrug(){
		    $("#Drug_id").val("");
		    $("#MyModal").modal("show");
		}
		function editDrug(rowData) {
			$("#MyModal").modal("show");
			$("#Drug_id").val(rowData["drug_id"]);
			$("#Drug_Code").val(rowData["drug_Code"]);
			$("#Drug_Desc").val(rowData["drug_Desc"]);
			$("#Drug_Spec").val(rowData["drug_Spec"]);

			var num = rowData["drug_Class_Dr"]; 
			var num1 = rowData["drug_Uom"].erpUomcode; 
			//$("#DrugClassDr").val(num).trigger("change");
			//$("#DrugUom").val(num1).trigger("change");
			$("#Drug_Class_Dr").val(num).select2();
			$("#Drug_Uom").val(num1).select2();

			$("#Drug_BarCode").val(rowData["drug_BarCode"]);
			$("#Drug_Sp").val(rowData["drug_Sp"]);
			$("#Drug_Rp").val(rowData["drug_Rp"]);
			$("#Drug_BaseDrugFlag").val(rowData["drug_Code"]);
			$("#Drug_ActiveFlag").val(rowData["drug_ActiveFlag"]);

			if (rowData["drug_BaseDrugFlag"]) {
				$("[name='Drug_BaseDrugFlag']").attr("checked", true);
			} else {
				$("[name='Drug_BaseDrugFlag']").attr("checked", false);

			}
			$("#Drug_Alias").val(rowData["drug_Alias"]);
		}

		

		function SaveDrug() {
			var url="";	
			var msg="";	
			if($("input:hidden[name='"+"Drug_id"+"']").val()){
			    msg="编辑成功";
			}else{
				if (!$("#DrugInfoForm").valid()) {return;}
			    msg="保存成功";
			}; 			
			$.ajax({
				url : "${ctx}/Drug/DrugInfo/Save", 
				method : "post",
				data : $("#DrugInfoForm").serialize(),
				contentType : "application/x-www-form-urlencoded",
				dataType : "json",
				success : function(data) {
					if (data.state == "success") {
						layer.alert(msg);
						$("#MyModal").modal('hide');
						$("#table").datagrid('reload');
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



                 





