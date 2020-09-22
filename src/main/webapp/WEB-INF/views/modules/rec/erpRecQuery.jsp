<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>入库管理--入库查询</title>
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
           

	$.extend($.fn.datagrid.defaults.editors, {
		combogrid : {
			init : function(container, options) {
				var input = $(
						'<inputtype="text" class="datagrid-editable-input">')
						.appendTo(container);
				input.combogrid(options);
				return input;
			},
			destroy : function(target) {
				$(target).combogrid('destroy');
			},
			getValue : function(target) {
				return $(target).combogrid('getValue');
			},
			setValue : function(target, value) {
				$(target).combogrid('setValue', value);
			},
			resize : function(target, width) {
				$(target).combogrid('resize', width);
			},
		},
	    datebox: {
	        init: function (container, options) {
	            var input = $('<input type="text">').appendTo(container);
	            input.datebox(options);
	            return input;
	        },
	        destroy: function (target) {
	            $(target).datebox('destroy');
	        },
	        getValue: function (target) {
	            return $(target).datebox('getValue');//获得旧值
	        },
	        setValue: function (target, value) {
	            $(target).datebox('setValue', value);//设置新值的日期格式
	        },
	        resize: function (target, width) {
	            $(target).datebox('resize', width);
	        }
	    },
	    textReadonly: {
	        init: function (container, options) {
	            var input = $('<input type="text" readonly="readonly" style="height:31px" class="datagrid-editable-input">').appendTo(container);
	            return input;
	        },
	        getValue: function (target) {
	            return $(target).val();
	        },
	        setValue: function (target, value) {
	            $(target).val(value);
	        },
	        resize: function (target, width) {
	            var input = $(target);
	            if ($.boxModel == true) {
	                input.width(width - (input.outerWidth() - input.width()));
	            } else {
	                input.width(width);
	            }
	        }
	    }
	    
	});    
    
	//合计
	function onLoadSuccess() {
	            //添加“合计”列
	            $('#dg').datagrid('appendRow', {
	                no: '<span class="subtotal">合计</span>',
	                amtrp: '<span class="subtotal">' + compute("amtrp") + '</span>',
	                amtsp: '<span class="subtotal">' + compute("amtsp") + '</span>',
	             });
	        }
           function onLoadSuccessdgDetail() {
    		            //添加“合计”列
    		            $('#dgDetail').datagrid('appendRow', {
    		                uomdesc: '<span class="subtotal">合计</span>',
    		                rpamt: '<span class="subtotal">' + computedgDetail("rpamt") + '</span>',
    		                spamt: '<span class="subtotal">' + computedgDetail("spamt") + '</span>',
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
			function computedgDetail(colName) {
		            var rows = $('#dgDetail').datagrid('getRows');
		            var total = 0;
		            for (var i = 0; i < rows.length; i++) {
		                total += parseFloat(rows[i][colName]);
		            }
		            return total;
		        }
			
	
	function initMainGrid(){
		$('#dg').datagrid({
			width:1550,
			height:270,
	        delay: 600,
	        mode: 'remote',
	        fitColumns: true,
	        //toolbar:'#tb',
	        striped:true,
	        singleSelect:'true',
	        onClickRow: onClickRow,
	        showFooter: true,
	        pagination : true,
			pageSize : [6],
			pageList : [ 6,12,18,24], 
	        onLoadSuccess:function(data){
	            $(".note").tooltip(
	                    {
	                        onShow: function(){
	                            $(this).tooltip('tip').css({
	                                width:'300',
	                                backgroundColor: '#FFFFCC',
	                                borderColor: '#33300',
	                                boxShadow: '1px 1px 3px #292929'
	                            });
	                        }
	                    }
	            );
	            onLoadSuccess();
	        },
	        url : "", // 获取数据的地址
	        //idField: 'itemid',
	        textField: 'itemDesc',
			onEndEdit : function(index,row){
			},
			onBeginEdit:function(rowIndex){	        
		    },
		    columns:[[
	            {field:'id',title:'id',width:100,hidden:'true',
	            	editor:{
						type: 'textReadonly'
				            }
	            },
	            {field:'no',title:'单号',width:260,                   	
	            	editor:{ 
	            		   type:'textReadonly'
	            		   }
	            },
	            {field:'depdesc',title:'部门',width:200,halign:"center",
	              	editor:{ 
	            		   type:'textReadonly'
	            		   }
	            },
	            {field:'vendordesc',title:'供货商',width:300,align:"left",halign:"center",
	            	formatter: function(value, row, index) {
	                    var abValue = value;
	                    if ((value!=undefined)&&(value.length>=2)) {
	                        abValue = value.substring(0,4) + "...";
	                    }else{
	                    	abValue="";
	                    }
	                    var content = '<a href="#" title="' + value + '" class="note">' + abValue + '</a>';
	                    return content;
	            	},
	            	editor:{ 
	            		   type:'textReadonly'
	            		   }
	            },
	            {field:'amtrp',title:'金额(进价)',width:200,align:"left",halign:"center",	 
	            	editor:{ 
	            		   type:'textReadonly'
	            		   }
	            },
	            {field:'amtsp',title:'金额(售价)',width:200,align:"left",halign:"center",	 
	            	editor:{ 
	            		   type:'textReadonly'
	            		   }
	            },
				{field:'createDate',title:'制单日期',width:220,align:"left",halign:"center",
					editor:{
					}
				},
				{field:'remarks',title:'备注',width:240,align:"left",halign:"center",
					editor:{
					}
				},
				{field:'auditFlag',title:'审核',width:200,align:"left",halign:"center",
					formatter:function(value,row){
						if (value!= undefined){
							if (row.auditFlag=="Y"){
		                        return "审核"; //--值用于显示
						    }else{
						    	return "待审"; //--值用于显示
						    };
						}else{
							return "";
						}
	                },
					editor:{
					}
				},
				{field:'createBy',title:'制单',width:200,align:"left",halign:"center",
					formatter:function(value,row){ 
						if (value!= undefined){
	                      return row.createBy.loginName; //--值用于显示
						}else{
					    	return ""; //--值用于显示
					    };
	                },
					editor:{
					}
				},
				{field:'auditBy',title:'审核',width:200,align:"left",halign:"center",
					formatter:function(value,row){ 
	                    if (value!= undefined){
	                    	return row.auditBy.loginName;
					    }else{
					    	return ""; //--值用于显示
					    };
	                }, 
					editor:{
					}
				},
				{field:'updateBy',title:'更新',width:200,align:"left",halign:"center",
					formatter:function(value,row){
						if (value!= undefined){
	                      return row.updateBy.loginName; //--值用于显示
						}else{
					    	return ""; //--值用于显示
					    };
	                }, 
					editor:{
					}
				},
				{field:'updateDate',title:'更新日期',width:200,align:"left",halign:"center",
					editor : {
						type: 'textReadonly'
	                }
				}
			]]
		});
	}
	function initDetailGrid(){
		$('#dgDetail').datagrid({
			width:1550,
			height:280,
	        delay: 600,
	        mode: 'remote',
	        fitColumns: true,
	        striped:true,
	        singleSelect:'true',
	        showFooter: true,
	        onLoadSuccess:function(data){
	            $(".note").tooltip(
	                    {
	                        onShow: function(){
	                            $(this).tooltip('tip').css({
	                                width:'300',
	                                boxShadow: '1px 1px 3px #292929'
	                            });
	                        }
	                    }
	            );
	            onLoadSuccessdgDetail();
	        },
	        url : "", // 获取数据的地址
			onEndEdit : function(index,row){
			},
			onBeginEdit:function(rowIndex){	        
		    },
		    columns:[[
	            {field:'id',title:'id',width:100,hidden:'true',
	            	editor:{
						type: 'textReadonly'
				            }
	            },
	            {field:'subid',title:'序号',width:50,                   	
	            	editor:{ 
	            		   type:'textReadonly'
	            		   }
	            },
	            {field:'itemid',title:'itemid',width:260,hidden:'true',                   	
	            	editor:{ 
	            		   type:'textReadonly'
	            		   }
	            },
	            {field:'itemno',title:'商品编码',width:150,                   	
	            	editor:{ 
	            		   type:'textReadonly'
	            		   }
	            },
	            {field:'itemdesc',title:'商品名称',width:300,halign:"center",
	              	editor:{ 
	            		   type:'textReadonly'
	            		   }
	            },
	            {field:'qty',title:'数量',width:100,align:"left",halign:"center",	 
	            	editor:{ 
	            		   type:'textReadonly'
	            		   }
	            },
	            {field:'uomdesc',title:'单位',width:150,align:"left",halign:"center",	 
	            	editor:{ 
	            		   type:'textReadonly'
	            		   }
	            },
	            {field:'rpamt',title:'金额(进价)',width:150,align:"left",halign:"center",	 
	            	editor:{ 
	            		   type:'textReadonly'
	            		   }
	            },
	            {field:'spamt',title:'金额(售价)',width:150,align:"left",halign:"center",	 
	            	editor:{ 
	            		   type:'textReadonly'
	            		   }
	            },
				{field:'manfdesc',title:'厂家',width:260,align:"left",halign:"center",
					editor:{
					}
				},
				{field:'batno',title:'批号',width:200,align:"left",halign:"center",
					editor:{
					}
				},
				{field:'expdate',title:'效期',width:200,align:"left",halign:"center",
					editor:{
					}
				},
				{field:'invnoamt',title:'发票金额',width:200,align:"left",halign:"center",
					editor:{
					}
				},
				{field:'invdate',title:'发票日期',width:200,align:"left",halign:"center",
					editor:{
					}
				},
				{field:'margin',title:'加成',width:200,align:"left",halign:"center",
					editor:{
					}
				}
			]]
		});
	}
	
	function modify() {
		
		var data = $('#searchForm').serializeJson(); //利用扩展函数表单序列化函数
		$('#dg').datagrid('load',data);
		$('#dg').datagrid({url:'${ctx}/rec/erpRec/getrecMainList'});
		//清空明细
		$('#dgDetail').datagrid('loadData',{total:0,rows:[]})
	}

	

	//单击行加载明细
	function onClickRow(index, row){
		 var id = row["id"];
		 $('#dgDetail').datagrid({url:"${ctx}/rec/erpRec/getListjqGridDetail?ids=" + id});
	};
	
	
	$(document).ready(function() {
		initMainGrid();   //EasyUI DataGrid版本
		initDetailGrid();  
	});
	
	

</script>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/rec/erpRecQuery/erpRecQuery">入库<shiro:hasPermission
					name="rec:erpRec:Query">查询</shiro:hasPermission></a></li>
		
	</ul>
	<br />
	<form:form id="searchForm" modelAttribute="erpRec"
		action="${ctx}/rec/erpRec/query" method="post"
		class="breadcrumb form-search">
		<ul class="ul-form">
			<li><label>单号：</label> <form:input path="no" htmlEscape="false"
					maxlength="50" class="input-medium" /></li>
									
			<li><label>库房：</label> 
				<form:select path="depid" class="input-medium">
					<form:option value="">请选择入库部门...</form:option>
					<form:options items="${erpDepartmentslist}"
						itemLabel="departmentDesc" itemValue="id" htmlEscape="false" />
				</form:select>	
			</li>
			
			<li><label>供货商：</label> 
			    <form:select path="vendorid" class="input-medium">
					<form:option value="">请选择供货商...</form:option>
					<form:options items="${erpVendorlist}" itemLabel="vendorDesc"
						itemValue="id" htmlEscape="false" />
				</form:select>	
			</li>

			<li class="btns"><input id="btnSubmit" class="btn btn-primary"
				onclick="modify()" value="查询" /></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>

	<div class="control-group">
			<label class="control-label">入库信息：</label>
			<div class="controls">
				<table id="dg" class="easyui-datagrid"
					style="width:550px;height:250px">
				</table>
			</div>
	</div>
	<br>
	<div class="control-group">
			<label class="control-label">明细信息：</label>
			<div class="controls">
				<table id="dgDetail" class="easyui-datagrid"
					style="width:550px;height:250px">
				</table>
			</div>
	</div>

</body>

</html>
