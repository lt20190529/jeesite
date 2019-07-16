<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<c:set var="ctx" value="${pageContext.request.contextPath}${fns:getAdminPath()}"/>
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static"/>


<html>
<head>
	<title>测试</title>
	<meta name="decorator" content="default"/>

	<script src="${pageContext.request.contextPath}/static/module/common.js"></script>
	
	<script type="text/javascript">
	 var editRow="";  ///当前编辑行索引
        //********************************XXXXX******************************
       
        var UIDivWindow = function(tarobj, input, width, height,fn){
			this.input = input;
			this.tarobj = tarobj;
			this.width = width;
			this.height = height;
			this.fn = fn;
			}
        var ListComponent = function(id, columns, url, option){
         	this.id = id;
        	this.url = url;
        	this.option = option;
        	this.columns = columns;
        }

        ListComponent.prototype.Init = function(){
        	var option = {
        		url : this.url,
        		fit : true,
        		striped : true, //是否显示斑马线效果
        		columns : this.columns,
        		pageSize : 6,
        		pageList : [6,12,18],
        		loadMsg : '正在加载信息...',
        		rownumbers : true, //行号
        		fitColumns : true,
        		singleSelect : false,
        		pagination : true,
        		bordr : false,
        		onBeforeLoad : function(param){
        			var thisrows=$("#dg1").datagrid("getRows").length;
        			if (thisrows<=0){
        				$("#dg1").datagrid('loadData',{total:0,rows:[]});
        			}
        		},
        		onLoadSuccess:function(data){
        			$("#dg1").datagrid('loadData',{total:0,rows:[]});
        			///提示信息
            		//LoadCellTip("");
        		} 
        	}
        	$('#'+this.id).datagrid($.extend(option,this.option));
        }
		UIDivWindow.prototype.init=function(){
				var fn = this.fn;
				
				//定义columns
				var columns=[[
				    {field:'id',title:'ID',width:220,hidden:'true'},
					{field:'itemNo',title:'编码',width:80},
					{field:'itemDesc',title:'名称',width:200},
					{field:'itemSp',title:'价格',width:80}
				]];
				
				/**
				 * 定义datagrid
				 */ 
				var option = {
					//title:'药品明细',
					
					singleSelect : true,
					onLoadSuccess:function(data) {
						$("#mydiv").datagrid("selectRow",0);
					},
				    onDblClickRow: function (rowIndex, rowData) {
						var rowData = $('#mydiv').datagrid('getSelected');
						RemoveMyDiv();
						fn(rowData);
			        }
				};
		
				///创建弹出窗体
				$(document.body).append('<div id="win" style="width:'+ this.width +';height:300px;border:1px solid #E6F1FA;position:absolute;z-index:9999;background-color:#ffa8a8;"></div>') 
				$("#win").append('<div id="mydiv"></div>');	
				$("#win").show();
				$("#win").css("left",this.tarobj.offset().left);
				$("#win").css("top",this.tarobj.offset().top+ this.tarobj.outerHeight());
				
				//var utilUrl = 'dhcpha.clinical.action.csp?action=QueryStockDetail&Input='+ this.input +'&HospID="1"';
				var utilUrl = "${ctx}/lxt/test/getListnewBy?input="+ this.input;
				
				var stockItemComponent = new ListComponent('mydiv', columns, utilUrl, option);
				stockItemComponent.Init();
				//initScroll("#mydiv");//初始化显示横向滚动条
				
				//设置分页控件
				var pag = $("#mydiv").datagrid('getPager');
				//设置分页控件 
			   
				$(pag).pagination({
					pageSize : 6,
					pageList : [6,12,18],
			        beforePageText: '第',//页数文本框前显示的汉字 
			        afterPageText: '页    共 {pages} 页', 
			        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
					buttons: [{
						text:'关闭',
						handler:function(){
							RemoveMyDiv();
						    fn('');
						}
					}]
				});
				
			    $("#mydiv").datagrid('getPanel').panel('panel').attr("tabindex",0);
			    $("#mydiv").datagrid('getPanel').panel('panel').focus();
			
				var opt=$("#dg1").datagrid('options');
				opt.onClickRow=function(rowIndex, rowData){
					 RemoveMyDiv();
					 fn(rowData);
					 return;
				}
				
			    $("#mydiv").datagrid('getPanel').panel('panel').bind('keydown', function (e){
			        switch (e.keyCode){
			        	case 13: // enter
					   		var rowData = $('#mydiv').datagrid('getSelected');
					   		RemoveMyDiv();
					   		fn(rowData);
					   		break ;
			        	case 27:  //Esc
					   		RemoveMyDiv();
					   		//fn('');
					   		break;
					   	case 33:  //Page Up
					   		var rowData = $('#mydiv').datagrid('getSelected');
					   		var currRowIndex = $('#mydiv').datagrid('getRowIndex',rowData);
					   		if (currRowIndex - 1 >= 0){
					   			$("#mydiv").datagrid("selectRow",currRowIndex - 1);
					   		}
					   		break;
					   	case 34:  //Page Down
					   		var rows = $('#mydiv').datagrid('getRows');
					   	    var rowData = $('#mydiv').datagrid('getSelected');
					   		var currRowIndex = $('#mydiv').datagrid('getRowIndex',rowData);
					   		if (currRowIndex + 1 <= rows.length){
					   			$("#mydiv").datagrid("selectRow",currRowIndex + 1);
					   		}
					   		break;
					    case 38:  //Page Up
					   		var rowData = $('#mydiv').datagrid('getSelected');
					   		var currRowIndex = $('#mydiv').datagrid('getRowIndex',rowData);
					   		if (currRowIndex - 1 >= 0){
					   			$("#mydiv").datagrid("selectRow",currRowIndex - 1);
					   		}
					   		break;
					   	case 40:  //Page Down
					   		var rows = $('#mydiv').datagrid('getRows');
					   	    var rowData = $('#mydiv').datagrid('getSelected');
					   		var currRowIndex = $('#mydiv').datagrid('getRowIndex',rowData);
					   		if (currRowIndex + 1 <= rows.length){
					   			$("#mydiv").datagrid("selectRow",currRowIndex + 1);
					   		}
					   		break;
					}
				})
				
				  //删除弹窗
				  function RemoveMyDiv(){
					if($("#mydiv").length>0){
					   $("#mydiv").remove(); 
				   	   $("#win").remove(); 
					}
				  } 
		}
		function setCurrEditRowCellVal(rowObj){
			///品名
			var ed=$("#dg1").datagrid('getEditor',{index:editRow, field:'itemNo'});		
			$(ed.target).val(rowObj.itemNo);
			///规格
			var ed=$("#dg1").datagrid('getEditor',{index:editRow, field:'itemDesc'});		
			$(ed.target).val(rowObj.itemDesc);
			
			var editors = $('#dg1').datagrid('getEditors',editRow);
			var workRateEditor = editors[3];
			workRateEditor.target.focus();  ///设置焦点
		}
		/// 给datagrid绑定回车事件
		function dataGridBindEnterEvent(rowIndex){
			var editors = $('#dg1').datagrid('getEditors', rowIndex);
			var workRateEditor = editors[2];
			workRateEditor.target.focus();  ///设置焦点
			workRateEditor.target.bind('keydown', function(e){
				if (e.keyCode == 13) {
					var ed=$("#dg1").datagrid('getEditor',{index:rowIndex, field:'itemDesc'});		
					var input = $(ed.target).val();
					var mydiv = new UIDivWindow($(ed.target), input,500,500, setCurrEditRowCellVal);   //liyarong 2016-09-28
				    //var mydiv = new UIDivWindow($("#consPatMedNo"));
		            mydiv.init();
				}
			}); 
		}
        //*******************************************************************
	    var DescName = undefined;
		$(document).ready(function() {
			
			test();
			
			
			$('#dg').datagrid({
				width:950,
				height:400,
                delay: 600,
                mode: 'remote',
                fitColumns: true,
                toolbar:'#tb',
                striped:true,
                singleSelect:'true',
                onClickRow: onClickRow,
               
                url: "${ctx}/lxt/test/getListnew",
                idField: 'id',
                textField: 'itemDesc',
        		onEndEdit : function(index,row){
        			if(DescName != undefined){
        				$("#dg").datagrid('getRows')[index]['itemDesc'] = DescName;
        			}
        			DescName= undefined;
        		},

        	    columns:[[
                    {field:'id',title:'id',width:200,hidden:'true',
                    	editor:{
							type: 'text'
					            }
                    },
                    {field:'itemNo',title:'编码',width:150,
                    	editor:{ 
                    		   type:'textReadonly'
                    		   }
                    },
                    {field:'itemSp',title:'价格',width:200,
						editor:{
							   type: 'numberbox',
							   options : {    
	                                   editable:false 
	                                  } 
					         }
					},
					{field:'itemDesc',title:'项目',width:300,						
						editor:{
							type:'combogrid',
							options:{
								panelWidth:450,
								idField:'id',
								textField:'itemDesc',
								url:'${ctx}/lxt/test/getListnew',
								columns:[[
									{field:'id',title:'id',width:60},
									{field:'itemDesc',title:'itemDesc',width:100},
									{field:'itemSpec',title:'itemSpec',width:100},
									{field:'itemSp',title:'itemSp',width:100},
									{field:'erpUom',title:'erpUom',width:100}
								]],
								onSelect: function (index, row) {
									                var grid = $('#dg');
	                                                var rowIndex= grid.datagrid('getRowIndex',grid.datagrid('getSelected'));
					                                grid.datagrid('beginEdit', rowIndex);
					                               
					                                var sp,selId,selNo;
					                                sp = grid.datagrid('getEditor', { index: rowIndex, field: 'itemSp' });
					                                selId = grid.datagrid('getEditor', { index: rowIndex, field: 'id' });
					                                selNo = grid.datagrid('getEditor', { index: rowIndex, field: 'itemNo' });
					                                $(selId.target).val(row.id);
					                                $(selNo.target).val(row.itemNo);
					                                $(sp.target).numberbox('setValue',row.itemSp);
					                                DescName=row.itemDesc;
								                    }
								}
						}
					},
					{field:'itemQty',title:'数量',width:300,
						editor:{
							type: 'numberbox'
					            }
					},
					{field:'itemUom',title:'单位',width:200,
						formatter:fmuomDesc,
                        editor : {    
                            type : 'combobox',    
                            options : {
                                valueField:'id' ,   
                                textField:'erpUomdesc',  
                                data:GetUomList(),
                                //editable:false     //下拉框是否可以输入控制
                            }    
                        }
					},
					{field:'itemExpDate',title:'效期',width:200,
						editor : {
							type: 'datebox'
                        }
					}
				]]
			});
		});
		
	    var comboboxData = "";	    
        function GetUomList()
        {
            $.ajax({
                url: "${ctx}/lxt/test/getListuom",
                type: 'get',
                async: false,//此处必须是同步
                dataTye: 'json',
                success: function (data) {
                    comboboxData = data;
                }
            })
            return comboboxData;
        }
 
        function fmuomDesc(value, row) {
            console.log(comboboxData);
            for (var i = 0; i < comboboxData.length; i++) {
                if (comboboxData[i].id == value) {
                    return comboboxData[i].erpUomdesc;
                }
            }
            return "";
        }

        //判读是否存在编辑行
		var editIndex = undefined;
        function endEditing(){
            if (editIndex == undefined){return true}
            if ($('#dg').datagrid('validateRow', editIndex)){
                $('#dg').datagrid('endEdit', editIndex);  //结束编辑
                editIndex = undefined;
                return true;
            } else {
                return false;
            }
        }

		function onClickRow(index){
			            if (editIndex != index){
			                if (endEditing()){
			                    $('#dg').datagrid('selectRow', index)
			                            .datagrid('beginEdit', index); //开始启用编辑
			                            
			                    editIndex = index;   //将正在编辑的行号赋值给变量
			                } else {
			                    $('#dg').datagrid('selectRow', editIndex);
			                }
			            }
		}

		
		
	
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
                    console.info(value);
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

		
		//添加一行
         function append() {
	       if (endEditing()){
				 $('#dg').datagrid('appendRow', { });
			 editIndex = $('#dg').datagrid('getRows').length - 1;
				 $('#dg').datagrid('selectRow', editIndex)
			 .datagrid('beginEdit', editIndex);
					      }
			}
	   //移除一行
	   function remove(){
		   if (editIndex == undefined){return}
		           $('#dg').datagrid('cancelEdit', editIndex)
		                   .datagrid('deleteRow', editIndex);
		           editIndex = undefined;
	   }

	   //保存数据
       function SaveData(){
    		var rows = $("#dg").datagrid("getRows"); 
    		for(var i=0;i<rows.length;i++){
    			alert(rows[i].itemDesc);
    		}

       }
      
       function test(){
    	   $('#dg1').datagrid({
				width:950,
				height:200,
               delay: 600,
               mode: 'remote',
               fitColumns: true,
               toolbar:'#tb',
               striped:true,
               singleSelect:true,
               //onClickRow: onClickRow,
		       pagination : false,
		       onBeginEdit : function(rowIndex, rowData){
		    	    var editors = $('#dg1').datagrid('getEditors', rowIndex);
					var workRateEditor = editors[2];
					var workRateEditor1 = editors[3];
					var workRateEditor2 = editors[4];
					var workRateEditor3 = editors[5];
					workRateEditor.target.focus();  ///设置焦点
					workRateEditor.target.bind('keydown', function(e){
						if (e.keyCode == 13) {
							var ed=$("#dg1").datagrid('getEditor',{index:rowIndex, field:'itemDesc'});		
							var input = $(ed.target).val();
							var mydiv = new UIDivWindow($(ed.target), input,500,500, setCurrEditRowCellVal);   //liyarong 2016-09-28
						    //var mydiv = new UIDivWindow($("#consPatMedNo"));
				            mydiv.init();
						}
					}); 
					workRateEditor1.target.bind('change', function(e){
						workRateEditor2.target.focus();  ///设置焦点
					});
					workRateEditor2.target.bind('change', function(e){
						workRateEditor3.target.focus();  ///设置焦点
					});
					workRateEditor3.target.bind('change', function(e){
						append1();
					});
		       },
              /*  onDblClickRow: function (rowIndex, rowData) {
            	   if ((editRow != "")||(editRow == "0")) { 
                       $("#dg1").datagrid('endEdit', editRow); 
                   } 
                   $("#dg1").datagrid('beginEdit', rowIndex); 
                   dataGridBindEnterEvent(rowIndex);  //设置回车事件
                   editRow = rowIndex;
               }, */
               url:"", //"${ctx}/lxt/test/getListnew",
               idField: 'id',
               textField: 'itemDesc',
       		   onEndEdit : function(index,row){
       			if(DescName != undefined){
       				$("#dg").datagrid('getRows')[index]['itemDesc'] = DescName;
       			}
       			DescName= undefined;
       		},

       	    columns:[[
                   {field:'id',title:'id',width:200,hidden:'true',
                   	editor:{
							type: 'textReadonly'
					            }
                   },
                   {field:'itemNo',title:'编码',width:150,
                   	editor:{ 
                   		   type:'textReadonly'
                   		   }
                   },
				   {field:'itemDesc',title:'项目',width:300,						
						editor:{
							type:'text'
						}
				   },
				   {field:'qty',title:'数量',width:300,						
						editor:{
							type:'text'
						}
				   },
				   {field:'batno',title:'批号',width:300,						
						editor:{
							type:'text'
						}
				   },
				   {field:'invno',title:'发票',width:300,						
						editor:{
							type:'text'
						}
				   }
				]]
			});
      }
       
     //添加一行
      function endEditing1(){
            if (editIndex == undefined){return true;}
            //var qty = $('#dg1').datagrid('getEditor', { index: editIndex, field: 'qty' });  //新增行时焦点设置
            $('#dg1').datagrid("endEdit", editIndex)
            		return true;
  
        }
     
       function append1() {
	       if (endEditing1()){
				 $('#dg1').datagrid('appendRow', { });
			 editIndex = $('#dg1').datagrid('getRows').length - 1;
				 $('#dg1').datagrid('selectRow', editIndex)
			 .datagrid('beginEdit', editIndex);
					      }
	       editRow = editIndex;   //给全局变量editRow = rowIndex赋值
			}
       function remove1(){
		   if (editIndex == undefined){return}
		           $('#dg1').datagrid('cancelEdit', editIndex)
		                   .datagrid('deleteRow', editIndex);
		           editIndex = undefined;
	   }
	</script>
</head>
<body>
<h1>测试界面</h1>
<div class="layui-tab">
  

 <!-- <table id="dg" title="明细信息" 
        class="easyui-datagrid" 
        style="width:550px;height:250px">    
</table> -->
<br>
 <table id="dg1" title="明细信息" 
        class="easyui-datagrid" 
        style="width:550px;height:250px">    
</table>
<div id="tb">
	<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="append()">添加</a>
	<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="remove()">移除</a>	
	
		<a data-toggle="modal" href="#addMenuModal">演示模态框</a>
</div>

</div>
<br>  
<br>


       <div class="layui-form-item">
           <label for="" class="layui-form-label">测试</label>
           <div class="layui-input-block">
               <input type="text" id="tree" lay-filter="tree" class="layui-input">
           </div>
       </div> 
             
<input id="btnsave" class="btn btn-primary" onclick="SaveData()" type="button" value="提交"/>

<!-- 新增的模态框-->
		<div class="modal fade" id="addMenuModal" tabindex="-1" role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header" style="height:60px">
						<h4>新增菜单</h4>
					</div>


					<div class="modal-body" style="width:100%; height:400px; z-index:1">
						<form id="addMenuForm" action="/Maven_Project/Menu/add"
							method="post" class="form-horizontal">
							aaaaaaaaaaaaa
						</form>
					</div>
					<div class="modal-footer">
						<button type="submit" id="conf" class="btn btn-default"
							onclick="addMenu()">确定</button>
						<button type="button" class="btn btn-default" data-dismiss="modal"
							onclick="">取消</button>
					</div>
				</div>
			</div>
		</div>
<script type="text/javascript">

layui.use(['treeSelect','form'], function () {
    var treeSelect= layui.treeSelect;

    treeSelect.render({        
        elem: '#tree',        // 选择器
        data: '',   // 数据       
        type: 'get',    // 异步加载方式：get/post，默认get       
        placeholder: '修改默认提示信息',   // 占位符       
        search: true,          // 是否开启搜索功能：true/false，默认false        
        click: function(d){
            console.log(d);     // 点击回调
        },
       
        success: function (d) {   // 加载完成后的回调函数
            console.log(d);
        }
    });
});

</script>
</body>
</html>
