<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>库存管理--库存查询</title>
<meta name="decorator" content="default" />
 <style type="text/css">
        .subtotal { font-weight: bold; color:red}/*合计单元格样式*/
 </style>
<script type="text/javascript">

	$.fn.serializeJson=function(){  
		  var serializeObj={};  
		  var array=this.serializeArray();  
		  var str=this.serialize();  
		     $(array).each(function(){  
	          if(serializeObj[this.name]){               
	          	if($.isArray(serializeObj[this.name])){                       
	          		serializeObj[this.name].push(this.value);  
		      }else{  
		         serializeObj[this.name]=[serializeObj[this.name],this.value];  
		     }  
		   }else{                     serializeObj[this.name]=this.value;   
		      }  
		   });  
		   return serializeObj;  
		}; 
		
		//添加“合计”列
		function onLoadSuccess() {     
			            $('#dg').datagrid('appendRow', {
			                spamt: '<span class="subtotal">合计：' + compute("spamt") + '</span>',
			             });
			        }
		           
        //指定列求和
        function compute(colName) {
            var rows = $('#dg').datagrid('getRows');
            var total = 0;
            for (var i = 0; i < rows.length; i++) {
                total += parseFloat(rows[i][colName]);
            }
            return total;
        }
					
		
	$(document).ready(function() {
		initMainGrid(); //EasyUI DataGrid版本
	});

	function initMainGrid() {
		$('#dg').datagrid(
						{
							width : 1550,
							height : 580,
							delay : 600,
							mode : 'remote',
							fitColumns : true,
							//toolbar:'#tb',
							striped : true,
							singleSelect : 'true',
							//onClickRow : onClickRow,
							showFooter : true,
							pagination : true,
							pageSize : [ 6 ],
							pageList : [ 15,30, 60, 90, 120 ],
							url : "", // 获取数据的地址
							//idField: 'itemid',
							onLoadSuccess:function(data){
					            onLoadSuccess();
					        },
							textField : 'itemDesc',
							onEndEdit : function(index, row) {
							},
							onBeginEdit : function(rowIndex) {
							},
							columns : [ [
									{
										field : 'id',
										title : 'id',
										width : 100,
										hidden : 'true',
										editor : {
											type : 'textReadonly'
										}
									},
									{
										field : 'erpDepartments',
										title : '仓库',
										halign : "center",
										width : 80,
										formatter:function(value,row){ 
											if (value!= undefined){
						                      return row.erpDepartments.departmentDesc; //--值用于显示
											}else{
										    	return ""; //--值用于显示
										    };
						                },
										editor : {
											type : 'textReadonly'
										}
									},
									{
										field : 'itemNo',
										title : '项目编码',
										width : 70,
										align : "left",
										halign : "center",
										formatter:function(value,row){ 
											if (row.erpItem){
						                      return row.erpItem.itemNo; //--值用于显示
											}
						                },
										editor : {
											type : 'textReadonly'
										}
									}, {
										field : 'itemDesc',
										title : '项目名称',
										width : 130,
										align : "left",
										halign : "center",
										formatter:function(value,row){ 
											if (row.erpItem){
						                      return row.erpItem.itemDesc; //--值用于显示
											}else{
										    	return ""; //--值用于显示
										    };
						                },
										editor : {
											type : 'textReadonly'
										}
									}, {
										field : 'qty',
										title : '数量',
										width : 60,
										align : "right",
										halign : "center",
										editor : {
											type : 'textReadonly'
										}
									}, {
										field : 'erpuom',
										title : '单位',
										width : 60,
										align : "left",
										halign : "center",
										formatter:function(value,row){ 
											if (value!= undefined){
						                      return row.erpuom.erpUomdesc; //--值用于显示
											}else{
										    	return ""; //--值用于显示
										    };
						                },
										editor : {}
									}, {
										field : 'itemSp',
										title : '售价',
										width : 70,
										align : "right",
										halign : "center",
										formatter:function(value,row){ 
											if (row.erpItem){
						                      return row.erpItem.itemSp; //--值用于显示
											}else{
										    	return ""; //--值用于显示
										    };
						                },
										editor : {}
									},{
										field:'spamt',
										title:'金额(售价)',
										align : "right",
										width:70,
										editor : {
											type : 'textReadonly'
										}
									}, {
										field : 'itemSpec',
										title : '规格',
										width : 100,
										align : "left",
										halign : "center",
										formatter:function(value,row){ 
											if(row.erpItem){
											      return row.erpItem.itemSpec;
											}
						                },
										editor : {}
									}, {
										field : 'itemBrevitycode',
										title : '简码',
										width : 100,
										align : "left",
										halign : "center",
										formatter:function(value,row){ 
											if (row.erpItem){
						                      return row.erpItem.itemBrevitycode; //--值用于显示
											}else{
										    	return ""; //--值用于显示
										    };
						                },
										editor : {}
									}] ]
						});
	}
	//查询
	function modify() {
			
			var data = $('#StockQueryForm').serializeJson(); //利用扩展函数表单序列化函数
			$('#dg').datagrid('load',data);
			$('#dg').datagrid({url:'${ctx}/erp/StockManger/getDepStockInfo'});
			
		}
	

</script>
</head>
  
<body>
	<form:form id="StockQueryForm" modelAttribute="erpStock"
		action="${ctx}/erp/StockManger/erpRecQuery" method="post"
		class="breadcrumb form-search">
		<ul class="ul-form">
			
		    <li><label>商品编码：</label>
				<form:input path="erpItem.itemNo" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			
			<li><label>商品名称：</label>
				<form:input path="erpItem.itemDesc" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			
			<li><label>商品简码：</label>
				<form:input path="erpItem.itemBrevitycode" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			
							
			<li><label>库房：</label> 
				<form:select path="erpDepartments.id" class="input-medium">
					<form:option value="">请选择入库部门...</form:option>
					<form:options items="${erpDepartmentslist}"
						itemLabel="departmentDesc" itemValue="id" htmlEscape="false" />
				</form:select>	
			</li>
			
			
			<li class="btns"><input id="btnSubmit" class="btn btn-primary"
				onclick="modify()" value="查询" /></li>
			<li class="clearfix"></li> 
			
		</ul>
	</form:form>

	<div class="control-group">
			<div class="controls">
				<table id="dg" class="easyui-datagrid"
					style="width:550px;height:250px">
				</table>
			</div>
	</div>
	
  </body>
</html>
