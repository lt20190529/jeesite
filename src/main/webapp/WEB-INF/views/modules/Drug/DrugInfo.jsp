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
<script>
    $(document).ready(function() {
        $("#btnExcel").click(function(){
            alert(1)
            $.ajax({
                url:"${ctx}/Drug/DrugInfo/Excel",
                type:"post",
                success:function (data) {
                },
                error:function (data) {
                }
            })
		})
	})

</script>
</head>
<body>
	<%--@elvariable id="Drug" type=""--%>
	<form:form id="DrugForm" modelAttribute="Drug"
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
							name="drug.Drug_ActiveFlag" id="optionsRadios1" value="0">禁用
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
						<button type="button" class="btn btn-primary" id="btnExcel">导出</button>
					</div>
					<div class="col-md-1">
					    <button type="button" class="btn btn-primary" onclick="print()">打印</button>
					</div>
					<div class="col-md-12">
						<table id="table" class="table table-striped table-bordered table-condensed">
							<thead>
							<tr>
								<th style="display:none;">ID</th>
								<th style="align:center">编码</th>
								<th>描述</th>
								<th>规格</th>
								<th>单位</th>
								<th>库存分类</th>
								<th>售价</th>
								<th>进价</th>
								<th>别名</th>
								<th>条码</th>
								<th>是否激活</th>
								<th>是否在用</th>
								<th>创建人</th>
								<th>创建日期</th>
								<shiro:hasPermission name="item:erpItem:edit"><th>操作</th></shiro:hasPermission>
							</tr>
							</thead>
							<tbody>
							<c:forEach items="${druglist}" var="drug">
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
											${drug.drug_Cat_Dr}
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
											${drug.createBy}
									</td>
									<td>
										<fmt:formatDate value="${drug.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<shiro:hasPermission name="item:erpItem:edit"><td>
										<a  onclick="editDrug('${drug.drug_id}')">修改</a>
										<a href="" onclick="return confirmx('确认要删除该字典维护吗？', this.href)">删除</a>
									</td></shiro:hasPermission>
								</tr>
							</c:forEach>
							</tbody>
						</table>
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
									<div class="control-group">
										<div class="col-md-2"><span style="color:red">*</span>&nbsp;&nbsp;药品图片：</div>

										<img id="preview_photo" src="" style="height:150px;width:250px;padding: 3px;" border="4">
										<form:input id="Drug_Phone" path="Drug_Phone" type="hidden"/>

										<a type="button" class="btn btn-primary upload" id="up_btn">
											<input class="change" type="file" id="photoFile"  multiple="multiple" onchange="upload()"/>
											<i class="fa fa-upload"></i>选择图片
										</a>
									</div>

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
			//GetUserList();
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

		function cancle(){

			$("#MyModal").modal('hide');

			$("#MyModal").on("hide.bs.modal", function() {
				document.getElementById("DrugInfoForm").reset();
				$("#DrugInfoForm").validate().resetForm();
				$("#DrugInfoForm").removeClass("has-error");
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
            alert(data.drug_id);
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
            if (data.drug_BaseDrugFlag) {
                $("[name='Drug_BaseDrugFlag']").attr("checked", true);
            } else {
                $("[name='Drug_BaseDrugFlag']").attr("checked", false);

            }
            if (data.drug_ActiveFlag) {
                $("[name='Drug_ActiveFlag']").attr("checked", true);
            } else {
                $("[name='Drug_ActiveFlag']").attr("checked", false);

            }
            $("#Drug_Alias").val(data.drug_Alias);
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
			//alert($("#DrugInfoForm").serialize())
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



                 





