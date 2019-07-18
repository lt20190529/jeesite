<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>入库管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	
		//获取最大单据编号
	    function GetMaxNo(){
	    	$.ajax({
				type : "post",
				url : "${ctx}/rec/erpRec/GetMaxNo",
				dataType : 'json',
		    	data: {						//传值，多个值之间用逗号隔开，最后一个不用写逗号
		    	},
		    	success:function(data){  
			           $("#no").val(data.result); 
			           $("#no").attr("readonly","readonly")  
			        },  
			        error:function(data){  
			           layer.msg("加载入库单号失败！")
			        } 
			});
	    	
	    }
		$(document).ready(function() {

			GetMaxNo();   //默认设置单据编号
		    
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
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
		function modfly(id){	
		     var model = jQuery("#jqGrid-recDetail").jqGrid('getRowData', id);  
		     var delFlag=model.delFlag;
             //alert($("#a_"+id));
		     //'setCell'：固定的，rowId ：行id，virUseData： 修改的单元格的name，equip.virUseData ：修改的值。
		     if (delFlag==0){
		    	//$("#a_"+id).text('撤销删除');  //定义a标签text
		    	$("#a_"+id).html("&divide;").attr("title", "撤销删除");
		        $("#jqGrid-recDetail").jqGrid('setCell',id,"delFlag",1);
		        $("#a_"+id).parent().parent().addClass("error");
		     }else{
		    	//$("#a_"+id).text('删除');   //定义a标签text
		    	$("#a_"+id).html("&times;").attr("title", "删除");
			    $("#jqGrid-recDetail").jqGrid('setCell',id,"delFlag",0); 
			    //$("#a_"+id).parent().parent().css("background-color","red");
			    $("#a_"+id).parent().parent().removeClass("error");  //
		     }
		    	 
		}
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/rec/erpRec/">入库<shiro:hasPermission name="rec:erpRec:Audit">列表</shiro:hasPermission></a></li>
	    <li class="active"><a href="${ctx}/rec/erpRec/formE?id=${ErpRecNew.id}">入库<shiro:hasPermission name="rec:erpRec:edit">${not empty erpRec.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="rec:erpRec:edit">查看</shiro:lacksPermission></a></li>
	    <li><a href="${ctx}/rec/erpRec/erpRecQuery">入库查询</a></li>
	    <li><a href="${ctx}/rec/erpRec/erpRecReport">入库统计</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="erpRec" action="${ctx}/rec/erpRec/save" method="post" class="form-horizontal">
		<form:hidden path="id" />
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">单据编号：</label>
			<div class="controls">
				<form:input path="no" id="no" htmlEscape="false" maxlength="50" class="input-xlarge required"/>
				<span id="val_no" style="color:#F00" class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">部门：</label>
			<div class="controls">
				<%-- <form:input path="dep" id="dep" htmlEscape="false" maxlength="50" class="input-xlarge required"/>--%>
				<form:select path="dep" class="input-medium">
				    <form:option value="">请选择入库部门...</form:option>
					<form:options items="${erpDepartmentslist}" itemLabel="departmentDesc" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span id="val_dep" style="color:#F00" class="help-inline"><font color="red">*</font> </span> 
				
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">供货商：</label>
			<div class="controls">
				<%-- <form:input path="vendor" id="vendor" htmlEscape="false" maxlength="20" class="input-xlarge required"/> --%>
				<form:select path="vendor" class="input-medium">
				    <form:option value="">请选择供货商...</form:option>
					<form:options items="${erpVendorlist}" itemLabel="vendorDesc" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span id="val_vendor" style="color:#F00" class="help-inline"><font color="red">*</font> </span>
				
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" id="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
			<%-- <div class="control-group">
				<label class="control-label">erp_recdetail：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>产品</th>
								<th>单位</th>
								<th>数量</th>
								<th>价格</th>
								<th>备注信息</th>
								<shiro:hasPermission name="rec:erpRec:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="erpRecdetailList">
						</tbody>
						<shiro:hasPermission name="rec:erpRec:edit"><tfoot>
							<tr><td colspan="7"><a href="javascript:" onclick="addRow('#erpRecdetailList', erpRecdetailRowIdx, erpRecdetailTpl);erpRecdetailRowIdx = erpRecdetailRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="erpRecdetailTpl">//<!--
						<tr id="erpRecdetailList{{idx}}">
							<td class="hide">
								<input id="erpRecdetailList{{idx}}_id" name="erpRecdetailList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="erpRecdetailList{{idx}}_delFlag" name="erpRecdetailList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="erpRecdetailList{{idx}}_item" name="erpRecdetailList[{{idx}}].item" type="text" value="{{row.item}}" maxlength="50" class="input-small "/>
							</td>
							<td>
								<input id="erpRecdetailList{{idx}}_uom" name="erpRecdetailList[{{idx}}].uom" type="text" value="{{row.uom}}" maxlength="64" class="input-small "/>
							</td>
							<td>
								<input id="erpRecdetailList{{idx}}_qty" name="erpRecdetailList[{{idx}}].qty" type="text" value="{{row.qty}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="erpRecdetailList{{idx}}_sp" name="erpRecdetailList[{{idx}}].sp" type="text" value="{{row.sp}}" class="input-small "/>
							</td>
							<td>
								<textarea id="erpRecdetailList{{idx}}_remarks" name="erpRecdetailList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
							<shiro:hasPermission name="rec:erpRec:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#erpRecdetailList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var erpRecdetailRowIdx = 0, erpRecdetailTpl = $("#erpRecdetailTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						
						$(document).ready(function() {
							var data = ${fns:toJson(erpRec.erpRecdetailList)};
							for (var i=0; i<data.length; i++){
								addRow('#erpRecdetailList', erpRecdetailRowIdx, erpRecdetailTpl, data[i]);
								erpRecdetailRowIdx = erpRecdetailRowIdx + 1;
							} 
						
						});
						
					</script>
				</div>
			</div> --%>
			<!-- jqGrid加载入库明细 -->
		<div class="control-group">
				<label class="control-label">明细信息:</label>
				<div class="controls">
					<table id="jqGrid-recDetail" class="table table-bordered table-condensed">
					</table>
					<div id="grid-pagerDetail" class="scroll"></div>
		        </div>
		 </div>	
		
			
		<div class="form-actions">
			<%-- <shiro:hasPermission name="rec:erpRec:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission> --%>
			<shiro:hasPermission name="rec:erpRec:edit"><input id="btnsave" class="btn btn-primary" onclick="Save()" type="button" value="提交"/>&nbsp;</shiro:hasPermission>
			<!-- <input id="btnAjax" class="btn btn-primary" onclick="AjaxData1()" type="button" value="Ajax提交"/>&nbsp; -->
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		
		<script>
		
		var grid_data=[]

		var detail_data = [
		                  {id: 1,isNewRecord:false,itemNo: "001",itemDesc: "log",itemSp:"1"},
		                  {id: 2,isNewRecord:false,itemNo: "002",itemDesc: "log1",itemSp:"1"},
		                  {id: 3,isNewRecord:false,itemNo: "003",itemDesc: "log1",itemSp:"1"}
		                  ];
		//fns:toJson  见tlds  fns.tld对象转换JSON字符串
		$(document).ready(function() {
			/* var data = ${fns:toJson(erpRec.erpRecdetailList)};
			for (var i=0; i<data.length; i++){
				addRow('#erpRecdetailList', erpRecdetailRowIdx, erpRecdetailTpl, data[i]);
				erpRecdetailRowIdx = erpRecdetailRowIdx + 1;
			} */
			//表格宽度自适应
			$(function(){
			      $(window).resize(function(){
			         $("#jqGrid").setGridWidth($(window).width());
			      });
			})
		     //加载jqGrid明细
		     var id = $("#id").val();

			  var lastrow;  //最后修改行号先定义一个全局变量
			  var lastcell; //
			  var lastsel;
			 $("#jqGrid-recDetail").jqGrid({
                 //data: ${fns:toJson(erpRec.erpRecdetailList)},//当 datatype 为"local" 时需填写  
                 url: "${ctx}/rec/erpRec/GetDetailList?id="+id, // 获取数据的地址
		         datatype: "json",//数据来源，本地数据（local，json,jsonp,xml等）
                 height:200,//高度，表格高度。可为数值、百分比或'auto'
                 //mtype:"GET",//提交方式
                 cellEdit: true,
                 cellsubmit: "clientArray",  //'clientArray',remote代表每次编辑提交后进行服务器保存，clientArray只保存到数据表格不保存到服务器
                 colNames: ['ID', 'Flag','项目','dr', '单位','uomcode','数量','价格','备注','',''],
                 colModel: [{
                     name: 'id',  
                     index: 'id',//索引。其和后台交互的参数为sidx
                     key: true,//当从服务器端返回的数据中没有id时，将此作为唯一rowid使用只有一个列可以做这项设置。如果设置多于一个，那么只选取第一个，其他被忽略
                     width: 20,
                     editable: false,
                     hidden:true
                 },{
                     name: 'isNewRecord',
                     index: 'isNewRecord',
                     width: 30,
                     hidden:true,
                 },{
                     name: 'item.itemDesc',
                     index: 'item.itemDesc',
                     width: 30
                 },{
                     name: 'item.id',
                     index: 'item.id',
                     width: 30,
                     hidden:true,
                 },{
                     name: 'item.erpUom.erpUomdesc',
                     index: 'item.erpUom.erpUomdesc',
                     width: 30
                 },{
                     name: 'item.erpUom.erpUomcode',
                     index: 'item.erpUom.erpUomcode',
                     width: 30,
                     hidden:true
                 },{
                     name: 'qty',
                     index: 'qty',
                     width: 30,
                     editable: true
                 },{
                     name: 'sp',
                     index: 'sp',
                     width: 30
                 },{
                     name: 'remarks',
                     index: 'remarks',
                     width: 30
                 },{
                     name: 'delFlag',
                     index: 'delFlag',
                     width: 30,
                     hidden:true,
                 },{
                     name: 'operation',
                     index: 'operation',
                     width: 30,
                     formatter: function (value, grid, rows, state) { 
                         return '<a id="a_'+rows.id+ '" onclick="modfly(\''+rows.id+ '\');">&times;</a>';
                     } 
                 } ],
                 vviewrecords: true,//是否在浏览导航栏显示记录总数
                 footerrow:true,
                 rowNum: 10,//每页显示记录数row
                 rowList: [10, 20, 30],//用于改变显示行数的下拉列表框的元素数组。
                 onSelectRow : function(id) {
                     if (id && id !== lastsel) {
                       jQuery('#jqGrid-recDetail').jqGrid('restoreRow', lastsel);
                       //jQuery('#jqGrid-recDetail').jqGrid('editRow', id, true);
                       lastsel = id;
                     }
                     
                   },
                 pager: "#grid-pagerDetail",//分页、按钮所在的浏览导航栏
                 altRows: false,//设置为交替行表格,默认为false
                 sortname:'id',//默认的排序列名
                 sortorder:'asc',//默认的排序方式（asc升序，desc降序）
                 autowidth: true,//自动宽,
                 shrinkToFit: true,//是否列宽度自适应。true=适应 false=不适应
                 jsonReader : {
                     page: "page",
                     records: "records",
                     total: "total",
                     root:"root",
                 },
                 gridComplete: function(){  
                     //alert("加载成功！"); 
                 },
             	/*  beforeEditCell : function(rowid,name,val,iRow,iCol){
           	 		lastrow = iRow;
           	 		lastcell = iCol;
           	 	    //layer.msg("beforeEditCell:"+val);
           	 	 },*/
           	     afterEditCell:function(rowid,name,val,iRow,iCol){
           	    	
                     //layer.msg("afterEditCell:"+val+" "+name);
           	     },
           	     beforeSaveCell:function(rowid, cellname, value, iRow, iCol){
           	    	 
           	    	createFuzzySearchCom();
                 }
           	     /*
           	     afterSaveCell:function(rowid,name,val,iRow,iCol){
           	         //layer.msg("afterSaveCell:"+val);   
           	     }   */  
           });
		        //jqGrid单元格编辑事件笔记
  			    //事件调用堆栈
				//根据您的cellSubmit设置设置为“remote”或“clientArray”，将按以下顺序触发以下事件：
				
				//cellSubmit设置'remote'
				//formatCell（rowid，cellname，value，iRow，iCol）：您可以在此处更改将在编辑模式中使用的单元格值
				//beforeEditCell（rowid，cellname，value，iRow，iCol）：在单元格跳转到编辑模式之前，此事件被触发
				//afterEditCell（rowid，cellname，value，iRow，iCol）：在创建输入元素之后，将触发此事件
				//beforeSaveCell（rowid，cellname，value，iRow，iCol）：在保存单元格之前触发，您可以保存此处发送给服务器的值。
				//beforeSubmitCell（rowid，cellname，value，iRow，iCol）：在将值发送到服务器之前触发，可以通过返回数组在此处向请求添加额外参数
				//afterSubmitCell（serverresponse，rowid，cellname，value，iRow，iCol）：仅当保存单元格成功时才触发，您可以在此处返回一条错误消息，该消息会导致与消息对话
				//afterSaveCell（rowid，cellname，value，iRow，iCol）：保存单元格值时触发
				//errorCell（serverresponse，status）：发生服务器错误时触发（如：403,404,500等）
				//onSelectCell（rowid，celname，value，iRow，iCol）：当单元格不可编辑时触发
				
				
				//cellSubmit设置'clientArray'
				//1:formatCell（rowid，cellname，value，iRow，iCol）：您可以在此处更改将在编辑模式中使用的单元格值
				//2:beforeEditCell（rowid，cellname，value，iRow，iCol）：在单元格跳转到编辑模式之前，此事件被触发
				//3:afterEditCell（rowid，cellname，value，iRow，iCol）：在创建输入元素之后，将触发此事件
				//4:beforeSaveCell（rowid，cellname，value，iRow，iCol）：在用户保存单元格之前触发
				//5:beforeSubmitCell（rowid，cellname，value，iRow，iCol）：你可以在这里保存值
				//6:afterSaveCell（rowid，cellname，value，iRow，iCol）：在beforeSubmitCell成功保存单元格的值时触发
				//7:onSelectCell（rowid，celname，value，iRow，iCol）：当单元格不可编辑时触发
			
		        //设置导航栏按钮是否可见
		        //$("#jqGrid-recDetail").removeClass('ui-state-disabled'); //Disable 按钮灰掉不可用
                //$("#jqGrid-recDetail").addClass('ui-state-disabled'); //Enable 按钮可用
			 jQuery("#jqGrid-recDetail").jqGrid('navGrid', "#grid-pagerDetail", {edit : false,add : false, del : false});
		     
			 jQuery("#jqGrid-recDetail").navButtonAdd("#grid-pagerDetail",{
				   caption:"添加", 
				   buttonicon:"ui-icon-add", //图标
				   title:"添加新项目",       //tooltip
				   id:"additem",
				   onClickButton: function(){ 
				      add();   
				   }, 
				   position:"first"
				});
			 jQuery("#jqGrid-recDetail").navButtonAdd("#grid-pagerDetail",{
				   caption:"添加1", 
				   buttonicon:"ui-icon-add", //图标
				   title:"添加新项目1",       //tooltip
				   id:"additem1",
				   onClickButton: function(){ 
					   addjqGridRownew();   
				   }, 
				   position:"first"
				});
			 function getVal(){
					var originNameVal = "";
					var i = 0;
					
					return "";

			 }
			 function createFuzzySearchCom(val){
				 $("#detail").jqGrid({
						//data: detail_data,//当 datatype 为"local" 时需填写  
		                //datatype: "local", //数据来源，本地数据（local，json,jsonp,xml等）
						url: "${ctx}/rec/erpRec/getListjqGrid", // 获取数据的地址
				        datatype: "json", // 从服务器端返回的数据类型，默认xml。可选类型：xml，local，json，jsonnp，script，xmlstring，jsonstring，clientside
				        //mtype: "POST", // 提交方式，默认为GET
		                height:"auto",//高度，表格高度。可为数值、百分比或'auto'
		                colNames: ['项目1','编码1','项目1','单位1','uomcode1','售价1'],
		                colModel: [{
		                    name: 'id',  
		                    index: 'id',//索引。其和后台交互的参数为sidx
		                    key: true,//当从服务器端返回的数据中没有id时，将此作为唯一rowid使用只有一个列可以做这项设置。如果设置多于一个，那么只选取第一个，其他被忽略
		                    width: 100,
		                    hidden:true
		                },{
		                    name: 'itemNo',
		                    index: 'itemNo',
		                    width: 150
		                },{
		                    name: 'itemDesc',
		                    index: 'itemDesc',
		                    width:300
		                },{
		                    name: 'erpUom.erpUomdesc',
		                    index: 'erpUom.erpUomdesc',
		                    width: 100
		                },{
		                    name: 'erpUom.erpUomcode',
		                    index: 'erpUom.erpUomcode',
		                    width: 100,
		                    hidden:true
		                },{
		                    name: 'itemSp',
		                    index: 'itemSp',
		                    width: 100
		                }],
		                viewrecords: true,//是否在浏览导航栏显示记录总数
		                rowNum: 6,//每页显示记录数
		                rowList: [10, 20, 30],//用于改变显示行数的下拉列表框的元素数组。
		                pager: "#detail-pager",//分页、按钮所在的浏览导航栏
		                altRows: true,//设置为交替行表格,默认为false
		                //toppager: true,//是否在上面显示浏览导航栏
		                pagerpos: 'left',
		                multiselect: true,//是否多选
		                //multikey: "ctrlKey",//是否只能用Ctrl按键多选
		                multiboxonly: true,//是否只能点击复选框多选*/
		                //autowidth: true,//自动宽, */
		                repeatitems: false,
		                jsonReader : {
		                        page: "page",
		                        records: "records",
		                        total: "total",
		                        root:"root",
		                },
		                ondblClickRow:function(row){                                //双击选择
		                	var id=$("#detail" ).jqGrid("getGridParam","selrow");   //选择行ID
		                	if(id!=null){
		                		var rowData = $("#detail").jqGrid("getRowData",id);
		                		addjqGridRow(rowData,id);
		                	}
		                	 $("#dialog").dialog( "close" );
		            	}
					});				 
			 }
			 
			 
			 function EditSelectRow(id)
			 {
				 /* var rowData = $("#jqGrid-recDetail").jqGrid("getRowData",id);
		         //输入内容并且检验不是数字弹出提示
				  if(($('#'+id+"_qty").val()!=null)&&(!ValidateTvalue($('#'+id+"_qty").val()))){
					 //layer.alert("非数字！");
					 return;
				 } 
			     var oldSelectRowId = $("#selectRowId").val();
			     //if (oldSelectRowId != null && oldSelectRowId != "" && oldSelectRowId.length > 0) {
			         $("#jqGrid-recDetail").jqGrid('saveRow', oldSelectRowId);//保存上一行
			     //}
			     //当前选中行
			     $("#selectRowId").val(id);//临时存储当前选中行
			     //$("#fieldGrid").jqGrid('editRow', id);
			     $("#jqGrid-recDetail").jqGrid('editRow', id, { keys: true, focusField: 1 }); */
			     
			     if (id && id !== lastsel) {
			            jQuery('#jqGrid-recDetail').jqGrid('restoreRow', lastsel);
			            jQuery('#jqGrid-recDetail').jqGrid('editRow', id, true);
			            lastsel = id;
			          }
			 }
			 function ValidateTvalue(value,name) {
			        //#region 验证是否为数值
			        var regu = "";
			        //var regu = "/^\+?(\d*\.\d{2})$/";
			        var re = new RegExp(regu);
			        if (!(/^([1-9][0-9]*|-[1-9][0-9]*)$/.test(value))) {
			            return false;						        
			        }else {
			            return true;
			        }
			}
		});
		
		


	 function add(){
		
		 $("#detail").jqGrid({
				//data: detail_data,//当 datatype 为"local" 时需填写  
                //datatype: "local", //数据来源，本地数据（local，json,jsonp,xml等）
				url: "${ctx}/rec/erpRec/getListjqGrid", // 获取数据的地址
		        datatype: "json", // 从服务器端返回的数据类型，默认xml。可选类型：xml，local，json，jsonnp，script，xmlstring，jsonstring，clientside
		        //mtype: "POST", // 提交方式，默认为GET
                height:"auto",//高度，表格高度。可为数值、百分比或'auto'
                colNames: ['项目ID','编码','项目','单位','uomcode','售价'],
                colModel: [{
                    name: 'id',  
                    index: 'id',//索引。其和后台交互的参数为sidx
                    key: true,//当从服务器端返回的数据中没有id时，将此作为唯一rowid使用只有一个列可以做这项设置。如果设置多于一个，那么只选取第一个，其他被忽略
                    width: 100,
                    hidden:true
                },{
                    name: 'itemNo',
                    index: 'itemNo',
                    width: 150
                },{
                    name: 'itemDesc',
                    index: 'itemDesc',
                    width:300
                },{
                    name: 'erpUom.erpUomdesc',
                    index: 'erpUom.erpUomdesc',
                    width: 100
                },{
                    name: 'erpUom.erpUomcode',
                    index: 'erpUom.erpUomcode',
                    width: 100,
                    hidden:true
                },{
                    name: 'itemSp',
                    index: 'itemSp',
                    width: 100
                }],
                viewrecords: true,//是否在浏览导航栏显示记录总数
                rowNum: 6,//每页显示记录数
                rowList: [10, 20, 30],//用于改变显示行数的下拉列表框的元素数组。
                pager: "#detail-pager",//分页、按钮所在的浏览导航栏
                altRows: true,//设置为交替行表格,默认为false
                //toppager: true,//是否在上面显示浏览导航栏
                pagerpos: 'left',
                multiselect: true,//是否多选
                //multikey: "ctrlKey",//是否只能用Ctrl按键多选
                multiboxonly: true,//是否只能点击复选框多选*/
                //autowidth: true,//自动宽, */
                repeatitems: false,
                jsonReader : {
                        page: "page",
                        records: "records",
                        total: "total",
                        root:"root",
                },
                ondblClickRow:function(row){                                //双击选择
                	var id=$("#detail" ).jqGrid("getGridParam","selrow");   //选择行ID
                	if(id!=null){
                		var rowData = $("#detail").jqGrid("getRowData",id);
                		addjqGridRow(rowData,id);
                	}
                	 $("#dialog").dialog( "close" );
            	}
			});
		 
		 $( "#dialog" ).dialog({
			  height: 420,
		      width: 830,
		      modal: true,
		      buttons: {
		               选择: function() {
                    	 var id=$("#detail" ).jqGrid("getGridParam","selrow");   //选择行ID
                    	 var ids=$("#detail").jqGrid("getGridParam","selarrrow"); //多选时选择行的ID
                    	 if (ids.length>0){
		                    	 for (var i = 0; i < ids.length; i++) {
		                    		 var rowData = $("#detail").jqGrid("getRowData",ids[i]);
		                    		 addjqGridRow(rowData,ids[i]);
		                    		 $("#jqGrid-recDetail").editCell($("#jqGrid-recDetail").getGridParam("reccount")+1, 5, true);
		                    	 }
		                 }else{
		                    	     layer.alert("请选择项目....");
		                 }

		            $( this ).dialog( "close" );
		          }
		        }
		    });
		}
	 //jgGrid新增行
	 
	
	 function addjqGridRow(rowData,selrow){
		 
		    var id=rowData.id;
		    var itemNo=rowData.itemNo;
            var itemDesc=rowData.itemDesc;
            var itemUom="";
            var itemSp=rowData.itemSp;
            
            var uom=$("#detail").jqGrid("getCell",selrow,"erpUom.erpUomdesc")  //selrow 行 erpUom.erpUomdesc 列 行列决定单元格
            var uomcode=$("#detail").jqGrid("getCell",selrow,"erpUom.erpUomcode")
            
           // alert("新增数据为："+itemNo+"   "+itemDesc+"    "+rowData.itemUom)  //调用添加行函数
           //要添加的jqgrid中的行数据
            var dataRow = {
                "item.id" : id,
                "isNewRecord":true,
                "item.itemDesc" : itemDesc,
                "item.erpUom.erpUomdesc" : uom,
                "item.erpUom.erpUomcode" : uomcode,
                "qty" : null,
                "sp":itemSp,
                "remarks" : "",
                "delFlag":0
            };
            //使用addRowData方法把dataRow添加到表格中
            //jqGrid 当前总行数   $("#jqGrid").getGridParam("reccount")
            $("#jqGrid-recDetail").jqGrid("addRowData", $("#jqGrid-recDetail").getGridParam("reccount")+1, dataRow, "last"); 
            
           
           
	 }
	 
	 function addjqGridRownew(rowData,selrow){
		 
		
        //要添加的jqgrid中的行数据
         var dataRow = {
             "item.id" : "",
             "isNewRecord": "",
             "item.itemDesc" :  "",
             "item.erpUom.erpUomdesc" :  "",
             "item.erpUom.erpUomcode" :  "",
             "qty" :  "",
             "sp": "",
             "remarks" : "",
             "delFlag":0
         };
         //使用addRowData方法把dataRow添加到表格中
         //jqGrid 当前总行数   $("#jqGrid").getGridParam("reccount")
         $("#jqGrid-recDetail").jqGrid("addRowData", $("#jqGrid-recDetail").getGridParam("reccount")+1, dataRow, "last"); 
         
        
        
	 }
 
	    //Ajax提交
	    function AjaxData(){
	    	var detail=[];
	    	var rec = new Object();
        	rec.id = $("#id").val();
        	rec.dep =  $("#dep").val();
        	rec.vendor =  $("#vendor").val();
        	rec.remarks= $("#remarks").val();
        	
        	var ids = $("#jqGrid-recDetail").jqGrid("getDataIDs");   //jqGrid所有ID
        	for(var i = 0; i < ids.length; i++){ 
        		var rowData = $("#jqGrid-recDetail").jqGrid('getRowData',ids[i]);
        		detail.push(rowData);
        	}  
        	//测试json
	        var test=[{
	        	"id": " 80722ac1495347328ab06e1b07f3a396",
	        	"no": " R00003",
	        	"dep": " 库房",
	        	"vendor": " 供货商A",
	        	"erpRecdetailList": [{
	        			"recid": " 80722ac1495347328ab06e1b07f3a396",
	        			"id": " 1283b29a08394c6289068b1ebdc382f0",
	        			"item": " 打印机",
	        			"qty": "123",
	        			"uom": "台",
	        			"sp": "300"
	        		},
	        		{
	        			"ErpRec": "",
	        			"id": " ",
	        			"item": " 电脑",
	        			"qty": "321",
	        			"uom": "台",
	        			"sp": "5000"
	        		}
	        	]
	        }]
	        
	        var news='[{"id": "80722ac1495347328ab06e1b07f3a396","no": " R00003","dep": " 库房","vendor": " 供货商A","erpRecdetailList": [{"recid": "80722ac1495347328ab06e1b07f3a396","id": " 1283b29a08394c6289068b1ebdc382f0","item": " 打印机","qty": "123","uom": "台","sp": "300"},{"recid": "80722ac1495347328ab06e1b07f3a396","id": " ","item": " 电脑","qty": "321","uom": "台","sp": "5000"}]}]'
		
            $.ajax({
				type : "post",
				url : "${ctx}/rec/erpRec/Ajax",
				data: news, //,
                processData:false,
                contentType:false,
                success:function(data){
                    //window.clearInterval(timer);
                    console.log("over..");
                }
			});
            
        }
        
	    
	    function Save() {

			var str;
			var sumamt=0;
			var arr = new Array();
			var ids = $("#jqGrid-recDetail").jqGrid("getDataIDs"); //jqGrid所有ID
			var sum = $("#jqGrid-recDetail").getGridParam("reccount"); //jqGrid总行数
			//arr idata = $("#jqGrid").getRowData();  // 获取jqgrid数据
			for (var i = 0; i < ids.length; i++) {
				var rowData = $("#jqGrid-recDetail").jqGrid('getRowData', ids[i]);
				id=rowData.id
				
				sp=rowData.sp;
				qty = $('#' + ids[i] + "_qty").val();      //编辑状态下获取数量
			
				if (!qty) {                                //qty非编辑状态下获取数量
					qty = rowData.qty;
				}
				
				
				if((rowData.qty=="")||($('#' + ids[i] + "_qty").val()=="")){
					layer.msg("【"+rowData.item+"】数量不能为空");
					return;
				}
				
			 
			    sumamt=sumamt+sp*qty;
			    
			    var itemdesc=$("#jqGrid-recDetail").jqGrid("getCell",ids[i],"item.itemDesc")
			    var itemid=$("#jqGrid-recDetail").jqGrid("getCell",ids[i],"item.id")
	
				var itemstr='{"id":"' + itemid + '","itemDesc":"' + itemdesc + '"}';
				
				
				
				var uomcode=$("#jqGrid-recDetail").jqGrid("getCell",ids[i],"item.erpUom.erpUomcode")
	
				if (rowData.isNewRecord=="true"){                 //新增
	               id="";
	               var result = '{ "recid":"' + ""
					+ '","id":"' + ""
					+ '","item":' + itemstr
					+ ',"qty":"' + qty + '","uom":"'
					+ uomcode + '","delFlag":"'
					+ rowData.delFlag + '","sp":"' + rowData.sp
					+ '"}';
				}else{                                       //修改:如果是修改子表的ErpRec需要是主表对象
					var id=$("#id").val();    //主表id
					var result = '{ "recid":"' + id+ '","id":"' + rowData.id
					+ '","item":' + itemstr
					+ ',"qty":"' + qty + '","uom":"'
					+ uomcode + '","delFlag":"'
					+ rowData.delFlag + '","sp":"' + rowData.sp
					+ '"}';
				}
			
				
				
				//   逻辑处理：根据id是否有值判断是原有记录还是新增记录   
				//   子表如果为原有记录  id:为原来id  recid:主表id
				//   子表如果为新增记录 id：""   recid:""
				

				if (str == null) {
					str = result;
				} else {
					str = str + "," + result;
				}
			}
			//var str1='{"id": "","no": " 1","dep": " 1","vendor": " 1","erpRecdetailList": [{"recid": "","id": "","item":{"id": "02af7d3ce3654fceae47757777bc3787","itemNo": "T001","itemDesc": "门锁","itemSpec":"联想","itemSp":"3000"},"qty": "1","uom": {"id":"d05b84b37a4643dbb96ed196b4321607","value":"台"},"delFlag": "0","sp": "500"}]}'
				
			var str = "[" + str + "]" //子表串
            var id= $.trim($("#id").val());
			var no = $.trim($("#no").val());
			if(no==""){
				//layer.msg("单号不能为空");
				$('#val_no').html("单号不能为空!");
				//document.getElementById('val_no').innerText="span的文本";
				return;
			}
			var dep = $.trim($("#dep").val());
			//alert("dep："+dep)
			if(dep==""){
				$('#val_dep').html("部门不能为空");
				return;
			}
			var vendor = $.trim($("#vendor").val());
			if(vendor==""){
				$('#val_vendor').html("供应商不能为空");
				return;
			}
			
		   
			
			
			//alert("sumamt:"+sumamt);
			//实体类定义此属性为自定义而非String所以应该穿进去对象
			var depid='{"id":"' + dep + '"}';
			var vendorid='{"id":"' + vendor + '"}';
			
	        if (id!=null){  
	        	var main = '{ "id":"' + id + '","no":"'      //隐藏元素id(主表id)有值,则为修改
				   + no + '","dep":' + depid + ',"vendor":' + vendorid
				   + ',"amtrp":' + sumamt
				   + ',"amtsp":' + sumamt
				   + ',"erpRecdetailList":'; //主表串
	        }else{                                               //隐藏元素id(主表id)无值,则为新增
	        	var main = '{ "no":" ' + no + '","dep":'
				   + depid + ',"vendor":' + vendorid
				   + ',"amtrp":' + sumamt
				   + ',"amtsp":' + sumamt
				   + ',"erpRecdetailList":'; //主表串
	        }
            
	        var json =main + str + "}"; //终结串
			//alert(json);
			$.ajax({
						type : "post",
						url : "${ctx}/rec/erpRec/SaveListjqGridItem",
						data : json, //str,
						contentType : "application/json;charset=utf-8",
						dataType : "text",
						success:function(data) {
							layer.msg("保存成功！", { offset: '100px' })
						},
						error : function() {
							layer.msg("保存失败！", { offset: '100px' })
						}
					});

		}
		</script>
		
		
	</form:form>
	
	     <!-- 弹出选择框 -->
		 <div id="dialog" title="项目选择">
			     <table id="detail"  >
			     </table>
			     <div id="detail-pager" class="scroll"></div>
		  </div>
		
</body>
</html>