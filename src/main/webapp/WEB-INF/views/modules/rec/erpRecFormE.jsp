<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<c:set var="ctx"
	value="${pageContext.request.contextPath}" />
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static" />

<html>
<head>
<title>测试</title>
<meta name="decorator" content="default" />
<!--引入4.0.0BootStrap-->
<link href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript"></script>



<script type="text/javascript">

	var UIDivWindow = function(tarobj, input, width, height, fn) {
		this.input = input;
		this.tarobj = tarobj;
		this.width = width;
		this.height = height;
		this.fn = fn;
	}
	var ListComponent = function(id, columns, url, option) {
		this.id = id;
		this.url = url;
		this.option = option;
		this.columns = columns;
	}

	ListComponent.prototype.Init = function() {
		var option = {
			url : this.url,
			fit : true,
			striped : true, //是否显示斑马线效果
			columns : this.columns,
			pageSize : 6,
			pageList : [ 6, 12, 18 ],
			loadMsg : '正在加载信息...',
			rownumbers : true, //行号
			fitColumns : true,
			singleSelect : false,
			pagination : true,
			bordr : false,
			onBeforeLoad : function(param) {
				var thisrows = $("#dg").datagrid("getRows").length;
				if (thisrows <= 0) {
					$("#dg").datagrid('loadData', {
						total : 0,
						rows : []
					});
				}
			},
			onLoadSuccess : function(data) {
				$("#dg").datagrid('loadData', {
					total : 0,
					rows : []
				});
				///提示信息
				//LoadCellTip("");
			}
		}
		$('#' + this.id).datagrid($.extend(option, this.option));
	}
	UIDivWindow.prototype.init = function() {
		var fn = this.fn;

		//定义columns
		//定义columns
		var columns = [ [ {
			field : 'id',
			title : 'ID',
			width : 220,
			hidden : 'true'
		}, {
			field : 'itemNo',
			title : '编码',
			width : 80
		}, {
			field : 'itemDesc',
			title : '名称',
			width : 200
		}, {
			field : 'itemSp',
			title : '价格',
			width : 80
		} ] ];

		/**
		 * 定义datagrid
		 */
		var option = {
			//title:'药品明细',
			pageSize : [ 15 ],
			pageList : [ 15, 30 ],
			singleSelect : true,
			onLoadSuccess : function(data) {
				$("#mydiv").datagrid("selectRow", 0);
			},
			onDblClickRow : function(rowIndex, rowData) {
				var rowData = $('#mydiv').datagrid('getSelected');
				RemoveMyDiv();
				fn(rowData);
			}
		};

		///创建弹出窗体
		$(document.body)
				.append(
						'<div id="win" style="width:'+ this.width +';height:300px;border:1px solid #E6F1FA;position:absolute;z-index:9999;background-color:#ffa8a8;"></div>')
		$("#win").append('<div id="mydiv"></div>');
		$("#win").show();
		$("#win").css("left", this.tarobj.offset().left);
		$("#win").css("top",
				this.tarobj.offset().top + this.tarobj.outerHeight());

		var utilUrl = "${ctx}/rec/erpRec/getListnewBy?input=" + this.input;
		var stockItemComponent = new ListComponent('mydiv', columns, utilUrl,option);
		stockItemComponent.Init();
		//initScroll("#mydiv");//初始化显示横向滚动条

		//设置分页控件
		var pag = $("#mydiv").datagrid('getPager');
		$(pag).pagination({
			buttons : [ {
				text : '关闭',
				handler : function() {
					RemoveMyDiv();
					//fn('');
				}
			} ]
		});

		$("#mydiv").datagrid('getPanel').panel('panel').attr("tabindex", 0);
		$("#mydiv").datagrid('getPanel').panel('panel').focus();

		var opt = $("#mydiv").datagrid('options');
		opt.onClickRow = function(rowIndex, rowData) {
			//RemoveMyDiv();
			//fn(rowData);
			//return;
		}

		$("#mydiv").datagrid('getPanel').panel('panel')
				.bind(
						'keydown',
						function(e) {
							switch (e.keyCode) {
							case 13: // enter
								var rowData = $('#mydiv').datagrid('getSelected');
								RemoveMyDiv();
								fn(rowData);
								break;
							case 27: //Esc
								RemoveMyDiv();
								//fn('');
								break;
							case 33: //Page Up
								var rowData = $('#mydiv').datagrid(
										'getSelected');
								var currRowIndex = $('#mydiv').datagrid(
										'getRowIndex', rowData);
								if (currRowIndex - 1 >= 0) {
									$("#mydiv").datagrid("selectRow",
											currRowIndex - 1);
								}
								break;
							case 34: //Page Down
								var rows = $('#mydiv').datagrid('getRows');
								var rowData = $('#mydiv').datagrid(
										'getSelected');
								var currRowIndex = $('#mydiv').datagrid(
										'getRowIndex', rowData);
								if (currRowIndex + 1 <= rows.length) {
									$("#mydiv").datagrid("selectRow",
											currRowIndex + 1);
								}
								break;
							case 38: //Page Up
								var rowData = $('#mydiv').datagrid(
										'getSelected');
								var currRowIndex = $('#mydiv').datagrid(
										'getRowIndex', rowData);
								if (currRowIndex - 1 >= 0) {
									$("#mydiv").datagrid("selectRow",
											currRowIndex - 1);
								}
								break;
							case 40: //Page Down
								var rows = $('#mydiv').datagrid('getRows');
								var rowData = $('#mydiv').datagrid(
										'getSelected');
								var currRowIndex = $('#mydiv').datagrid(
										'getRowIndex', rowData);
								if (currRowIndex + 1 <= rows.length) {
									$("#mydiv").datagrid("selectRow",
											currRowIndex + 1);
								}
								break;
							}
						})

		//删除弹窗
		function RemoveMyDiv() {
			if ($("#mydiv").length > 0) {
				$("#mydiv").remove();
				$("#win").remove();
			}
		}
	}

	$.extend(
					$.fn.datagrid.defaults.editors,
					{
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
						datebox : {
							init : function(container, options) {
								var input = $('<input type="text">').appendTo(
										container);
								input.datebox(options);
								return input;
							},
							destroy : function(target) {
								$(target).datebox('destroy');
							},
							getValue : function(target) {
								return $(target).datebox('getValue');//获得旧值
							},
							setValue : function(target, value) {
								$(target).datebox('setValue', value);//设置新值的日期格式
							},
							resize : function(target, width) {
								$(target).datebox('resize', width);
							}
						},
						textReadonly : {
							init : function(container, options) {
								var input = $(
										'<input type="text" readonly="readonly" style="height:31px" class="datagrid-editable-input">')
										.appendTo(container);
								return input;
							},
							getValue : function(target) {
								return $(target).val();
							},
							setValue : function(target, value) {
								$(target).val(value);
							},
							resize : function(target, width) {
								var input = $(target);
								if ($.boxModel == true) {
									input.width(width
											- (input.outerWidth() - input
													.width()));
								} else {
									input.width(width);
								}
							}
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

	$(document).ready(function() {

		var id = $.trim($("#id").val());
		if (id == "") { //id=""即新建入库单
			GetMaxNo(); //默认设置单据编号
		}
		initDetailGrid(); //初始化明细Grid

	});
	var editRow = ""; ///当前编辑行索引
	function initDetailGrid() {
		var id = $("#id").val();
		var DescName = undefined;

		$('#dg').datagrid(
						{   width : 1750,
							height : 400,
							delay : 600,
							mode : 'remote',
							fitColumns : true,
							toolbar : '#tb',
							striped : true,
							singleSelect : true,
							onClickRow : onClickRow,
							pagination : true,
							pageSize : [8],
							pageList : [ 8,16,24,32],
							showFooter : true,
							onLoadSuccess : function(data) {
								$(".note").tooltip({
									hideDelay:30,
									onShow : function() {
										$(this).tooltip('tip').css({
											width : '300',
											boxShadow : '1px 1px 3px #292929'
										});
									}
								});
							},
							url : "${ctx}/rec/erpRec/GetDetailListE?id=" + id,
							//idField: 'itemid',
							textField : 'itemDesc',
							onEndEdit : function(index, row) {
								if (DescName != undefined) {
									$("#dg").datagrid('getRows')[index]['itemdesc'] = DescName;
								}
								;
							},
							onBeginEdit : function(rowIndex, rowData) {
								var editors = $('#dg').datagrid('getEditors',
										rowIndex);
								var workRateEditor = editors[4]; //项目名称
								var workRateEditor1 = editors[7];
								var workRateEditor2 = editors[9];
								var workRateEditor3 = editors[6]; //厂家
								var workRateEditor4 = editors[8]; //单位
								//var workRateEditor2 = editors[4];
								//var workRateEditor3 = editors[5];

								var n1 = $(editors[7].target); //数量
								var n2 = $(editors[9].target); //进价
								var n3 = $(editors[10].target); //进价金额
								var n4 = $(editors[11].target); //售价
								var n5 = $(editors[12].target); //售价金额
								var n6 = $(editors[20].target); //发票金额
								var n7 = $(editors[21].target); //加成
								var n8 = $(editors[17].target); //效期
								var n9 = $(editors[6].target); //厂家
								var n10 = $(editors[8].target); //单位
								n1.numberbox({ //数量改变事件
									onChange : function() {
										var margin = 1;
										var rpamt = n1.numberbox('getValue')
												* n2.numberbox('getValue');
										var spamt = n1.numberbox('getValue')
												* n4.numberbox('getValue');
										//Math.ceil();向上舍入，比如Math.ceil(3/2)=2;
										//Math.floor();向下舍入，比如Math.floor(3/2)=1;
										//Math.round();四舍五入,比如Math.round(3/2)=2;Math.round(5/2)=2;
										//console.log(n4.numberbox('getValue'));

										if (n2.numberbox('getValue') != "") {
											margin = n4.numberbox('getValue')
													/ n2.numberbox('getValue');
										}
										n3.numberbox('setValue', rpamt);
										n5.numberbox('setValue', spamt);
										n7.numberbox('setValue', margin); //加成

										var uomid = $('#dg').datagrid(
												'getEditor', {
													index : editIndex,
													field : 'uomid'
												}); //单位获得焦点
										$(uomid.target).next().children()
												.focus(); 
									}
								})
								n2.numberbox({ //进价改变事件
									onChange : function() {
										var rpamt = n1.numberbox('getValue')
												* n2.numberbox('getValue');
										n3.numberbox('setValue', rpamt);
										n6.numberbox('setValue', rpamt); //发票金额
										var expdate = $('#dg').datagrid(
												'getEditor', {
													index : editIndex,
													field : 'expdate'
												}); //批号获得焦点
										$(expdate.target).next().children()
												.focus();
									}
								})
								/* n9.combobox({ //厂家改变事件()            //焦点事件问题待处理(选择完调至下一Cell)
											onChange : function(newValue,
													oldValue) {
												var qty = $('#dg').datagrid(
														'getEditor', {
															index : editIndex,
															field : 'qty'
														}); //数量获取焦点
												$(qty.target).next().children()
														.focus();
											}
										});
								n10.combobox({ //单位改变事件
									onSelect : function() {
										var rp = $('#dg').datagrid('getEditor',
												{
													index : editIndex,
													field : 'rp'
												}); //进价获取焦点
										$(rp.target).next().children().focus();
									},

								}); */

								//处理项目选择框

								workRateEditor.target.focus(); ///设置焦点

								workRateEditor.target.bind('keydown', function(
										e) {
									if (e.keyCode == 13) {
										var ed = $("#dg").datagrid('getEditor',
												{
													index : rowIndex,
													field : 'itemdesc'
												});
										var input = $(ed.target).val();
										var mydiv = new UIDivWindow(
												$(ed.target), input, 500, 500,
												setCurrEditRowCellVal); //liyarong 2016-09-28
										//var mydiv = new UIDivWindow($("#consPatMedNo"));
										mydiv.init();
									}
								});
								workRateEditor1.target.bind('change', function(
										e) {
									if (e.keyCode == 13) {
										workRateEditor2.target.focus(); ///设置焦点
									}
								});
								/*workRateEditor3.target.bind('change', function(e){
									append()();          //最后一格回车新增一行
								}); */
							},

							columns : [ [ {
								field : 'id',
								title : 'id',
								width : 100,
								hidden : 'true',
								editor : {
									type : 'textReadonly'
								}
							}, {
								field : 'isNewRecord',
								title : '标识',
								width : 100,
								hidden : 'true',
								editor : {
									type : 'textReadonly'
								}
							}, {
								field : 'itemid',
								title : 'itemID',
								width : 100,
								hidden : 'true',
								halign : "center",

								editor : {
									type : 'textReadonly'
								}
							}, {
								field : 'itemno',
								title : '编码',
								width : 200,
								align : "left",
								halign : "center",

								editor : {
									type : 'textReadonly'
								}
							}, {
								field : 'itemdesc',
								title : '项目',
								width : 350,
								align : "left",
								halign : "center",
								editor : {
									type : 'text'
								}
							}, {
								field : 'itemspec',
								title : '规格',
								width : 200,
								align : "left",
								halign : "center",
								editor : {
									type : 'textReadonly'
								}
							}, {
								field : 'manfid',
								title : '厂家',
								width : 400,
								halign : "center",
								formatter : fmmanfDesc,

								editor : {
									type : 'combobox',
									required : true,
									options : {
										valueField : 'id',
										textField : 'manfDesc',
										data : GetManfList(),
									//editable:false     //下拉框是否可以输入控制
									}
								}
							}, {
								field : 'qty',
								title : '数量',
								width : 200,
								align : "right",
								halign : "center",

								editor : {
									type : 'numberbox',
									options : {
										required : true,
										precision : 2
									}

								}
							}, {
								field : 'uomid',
								title : '单位',
								width : 200,
								align : "left",
								halign : "center",
								formatter : fmuomDesc,
								editor : {
									type : 'combobox',
									options : {
										required : true,
										valueField : 'id',
										textField : 'erpUomdesc',
										data : GetUomList(),
									//editable:false     //下拉框是否可以输入控制
									}

								}
							}, {
								field : 'rp',
								title : '进价',
								width : 200,
								align : "right",
								halign : "center",
								editor : {
									type : 'numberbox',
									options : {
										required : true,
										precision : 2
									}
								}
							}, {
								field : 'rpamt',
								title : '金额(进)',
								width : 200,
								align : "right",
								halign : "center",
								editor : {
									type : 'numberbox',
									options : {
										required : true,
										precision : 2
									}
								}
							}, {
								field : 'sp',
								title : '售价',
								width : 200,
								align : "right",
								halign : "center",
								editor : {
									type : 'numberbox',
									options : {
										required : true,
										precision : 2
									}
								}
							}, {
								field : 'spamt',
								title : '金额(售)',
								width : 200,
								align : "right",
								halign : "center",
								editor : {
									type : 'numberbox',
									options : {
										required : true,
										precision : 2
									}
								}
							}, {
								field : 'depid',
								title : '部门ID',
								width : 100,
								hidden : 'true',
								halign : "center",
								editor : {
									type : 'text'
								}
							}, {
								field : 'batno',
								title : '批号',
								width : 300,
								align : "right",
								halign : "center",
								editor : {
									type : 'text',
									options : {
										required : true,
										precision : 2
									}
								}
							}, {
								field : 'itemlbdr',
								title : '批次',
								width : 300,
								hidden : 'true',
								halign : "center",
								editor : {
									type : 'text'
								}
							}, {
								field : 'itemibdr',
								title : '部门批次',
								width : 300,
								hidden : 'true',
								halign : "center",
								editor : {
									type : 'text'
								}
							}, {
								field : 'expdate',
								title : '效期',
								width : 300,
								align : "right",
								halign : "center",
								editor : {
									type : 'datebox',
									options : {
										required : true,
										precision : 2
									}
								}
							}, {
								field : 'invno',
								title : '发票',
								width : 300,
								align : "right",
								halign : "center",
								editor : {
									type : 'text'
								}
							}, {
								field : 'invdate',
								title : '发票日期',
								width : 300,
								align : "right",
								halign : "center",
								editor : {
									type : 'datebox'
								}
							}, {
								field : 'invamt',
								title : '金额(发票)',
								width : 300,
								align : "right",
								halign : "center",
								editor : {
									type : 'numberbox',
									options : {
										precision : 2, //显示在小数点后面的最大精度。
										decimalSeparator : ".", //分隔数字的整数部分和小数部分的分隔字符。默认  “.”
										prefix : "¥", //	前缀字符串
										suffix : "" //	后缀字符串
									}
								}
							}, {
								field : 'margin',
								title : '加成',
								width : 200,
								align : "right",
								halign : "center",

								editor : {
									type : 'numberbox',
									options : {
										required : true,
										precision : 2, //显示在小数点后面的最大精度。
										decimalSeparator : ".", //分隔数字的整数部分和小数部分的分隔字符。默认  “.”
										prefix : "", //	前缀字符串
										suffix : "" //	后缀字符串
									}
								}
							}, {
								field : 'subid',
								title : 'subid',
								width : 300,
								align : "right",
								halign : "center",
								editor : {
									type : 'text'
								}
							} ] ]
						});
	}
	//处理单位下拉框
	var comboboxData = "";
	function GetUomList() {
		$.ajax({
			url : "${ctx}/rec/erpRec/getUomListuom",
			type : 'get',
			async : false,//此处必须是同步
			dataTye : 'json',
			success : function(data) {
				comboboxData = data;
			}
		})
		return comboboxData;
	}

	function fmuomDesc(value, row) {
		if (value == undefined) { //新增行返回空
			return "";
		}
	 
		if (value.length == 32) { //长度为64说明为id,需要转换为名称
			for (var i = 0; i < comboboxData.length; i++) {
				if (comboboxData[i].id == value) {
					return comboboxData[i].erpUomdesc;
				}
			}
		}
		
	}

	//处理厂家下拉框
	var comboboxmanfData = "";
	function GetManfList() {
		$.ajax({
			url : "${ctx}/rec/erpRec/getListManf",
			type : 'get',
			async : false,//此处必须是同步
			dataTye : 'json',
			success : function(data) {
				comboboxmanfData = data;
			}
		})
		return comboboxmanfData;
	}
	//此处和单位处理不同，单位根据id
	function fmmanfDesc(value, row) {
		var uu = ""; //加载已有数据value为单位描述
		for (var i = 0; i < comboboxmanfData.length; i++) {
			if (comboboxmanfData[i].id == value) {
				uu = comboboxmanfData[i].manfDesc;
			}
		}
		if (uu == "") {
			uu = value;
		}
		//名称太长显示前4个字符，鼠标指针悬浮显示全名
		if (uu != undefined) {
			if (uu.length >= 6) {
				abValue = uu.substring(0, 4) + "......";
			} else {
				abValue = uu;
			}
		} else {
			abValue = uu;
		}
		var content = '<a href="#" title="' + uu + '" class="note">' + abValue
				+ '</a>';
		return content; //return uu;

	}

	var editIndex = undefined;
	function endEditing() {
		if (editIndex == undefined) {
			return true;
		}
		if ($('#dg').datagrid('validateRow', editIndex)) {

			$('#dg').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			var qty = $('#dg').datagrid('getEditor', {
				index : editIndex,
				field : 'qty'
			}); //新增行时焦点设置
			$(qty.target).next().children().focus();
			return false;
		}
	}

	function onClickRow(index) {
		if (editIndex != index) {
			if (endEditing()) {
				var rows = $("#dg").datagrid("getRows");
				//var row=rows[index];  //行对象
				$('#dg').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex = index;

			} else {
				$('#dg').datagrid('selectRow', editIndex);
			}
		}
	}

	function setCurrEditRowCellVal(rowObj) {
		var rowData = $('#dg').datagrid('getSelected');
        var currRowIndex = $('#dg').datagrid('getRowIndex', rowData);
		//itemID
		var itemID = $("#dg").datagrid('getEditor', {
			index : currRowIndex,
			field : 'itemid'
		});
		$(itemID.target).val(rowObj.id);
		///编码
		var itemno = $("#dg").datagrid('getEditor', {
			index : currRowIndex,
			field : 'itemno'
		});
		$(itemno.target).val(rowObj.itemNo);
		///项目名称
		var itemdesc = $("#dg").datagrid('getEditor', {
			index : currRowIndex,
			field : 'itemdesc'
		});
		$(itemdesc.target).val(rowObj.itemDesc);
		///售价
		var sp = $("#dg").datagrid('getEditor', {
			index : currRowIndex,
			field : 'sp'
		});
		$(sp.target).numberbox("setValue", rowObj.itemSp);
		//规格
		var itemSpec = $("#dg").datagrid('getEditor', {
			index : currRowIndex,
			field : 'itemspec'
		});
		$(itemSpec.target).val(rowObj.itemSpec);
		//数量列获得焦点
		var qty = $('#dg').datagrid('getEditor', {
			index : editIndex,
			field : 'manfid'
		});
		$(qty.target).next().children().focus();
	}
	
	//添加一行
	function append() {
		if (endEditing()) {     //如果存在编辑行不能新加行
			var depid = $.trim($("#depid").val());
			if (depid == "") {
				$('#val_dep').html("请选择入库部门");
				return;
			}
			var vendorid = $.trim($("#vendorid").val());
			if (vendorid == "") {
				$('#val_vendor').html("请选择入库科室");
				return;
			}
			var grid = $('#dg');
			if (editIndex != undefined){
			    $('#dg').datagrid("endEdit", editIndex)  //如果存在编辑行    结束编辑 editIndex公共变量
			}
			grid.datagrid('appendRow', {});
			editIndex = $('#dg').datagrid('getRows').length - 1;
			grid.datagrid('selectRow', editIndex).datagrid('beginEdit',editIndex);
			editRow = editIndex; //给全局变量editRow = rowIndex赋值
			
	
			//设置新增行某些字段默认值
			if (editIndex > 0) {
				var rows = grid.datagrid('getRows'); // get current page rows
				var row = rows[editIndex - 1]; // your row data
				expdate = grid.datagrid('getEditor', {
					index : editIndex,
					field : 'expdate'
				});
				invno = grid.datagrid('getEditor', {
					index : editIndex,
					field : 'invno'
				});
				invdate = grid.datagrid('getEditor', {
					index : editIndex,
					field : 'invdate'
				});
				batno = grid.datagrid('getEditor', {
					index : editIndex,
					field : 'batno'
				});
				$(batno.target).val(row.batno);
				$(invno.target).val(row.invno);
				$(expdate.target).datebox("setValue", row.expdate);
				$(invdate.target).datebox("setValue", row.invdate);
			}
	
			subid = grid.datagrid('getEditor', {
				index : editIndex,
				field : 'subid'
			});
			$(subid.target).val(grid.datagrid('getRows').length); // subid设置
			var itemdesc = grid.datagrid('getEditor', {
				index : editIndex,
				field : 'itemdesc'
			}); //新增行时焦点设置
			//$(itemdesc.target).next().children().focus();         //api上是直接ed.target,发现没反映,需要把ed.target下一个元素的第一个子元素设置成focus才行
			$($(itemdesc.target).next().children()[0]).focus(); //如果上面的不行用这个 
		}
	}
	//移除一行
	function remove() {
		if (editIndex == undefined) {
			return;
		}
		var row = $('#dg').datagrid('getSelected');
		var detailid = row.id;

		if ((detailid == undefined) || (detailid == "")) { //新增行的删除
			$('#dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
					editIndex);
			editIndex = undefined;
		} else { //原有数据的删除
			layer.confirm('确定删除此条明细吗？', {
				btn : [ '确定', '取消' ]
			//按钮
			}, function() { //点击确定执行
				layer.close();
				$.ajax({
					type : "post",
					url : "${ctx}/rec/erpRec/DeleteRecDetailByid",
					dataType : 'text',
					data : {
						detailid : detailid
					}, //传值，多个值之间用逗号隔开，最后一个不用写逗号
					success : function(data) {
						$('#dg').datagrid('reload', {}); //重新加载
						layer.msg("删除成功！", {
							time : 0.5 * 1000,
							offset : '100px'
						});
					},
					error : function() {
						layer.msg("删除失败！", {
							offset : '100px'
						});
					}
				});
			}, function() { //点击取消执行
			});
		}
		editRow = editIndex; //给全局变量editRow = rowIndex赋值
	}

	//保存数据
	function SaveData() {
		if (endEditing()) {
			var content = $("#dg").datagrid("getRows");
			if (content.length == 0) {
				layer.msg("明细数据不能为空！", {
					time : 0.5 * 1000,
					offset : '100px'
				});
				return;
			}

			var id = $.trim($("#id").val());
			var no = $.trim($("#no").val());
			if (no == "") {
				$('#val_no').html("单号不能为空!");
				return;
			}

			var params = {};// 参数对象
			params.id = id;
			params.no = no;
			params.depid = $.trim($("#depid").val());
			params.vendorid = $.trim($("#vendorid").val());
			params.erpRecdetailNewList = content;

			//入库主表合计
			var rows = $('#dg').datagrid('getRows')//获取当前的数据行
			var rptotal = 0, sptotal = 0;//统计unitcost的总和
			for (var i = 0; i < rows.length; i++) {
				rptotal = rptotal + parseFloat(rows[i]['rpamt']);
				sptotal = sptotal + parseFloat(rows[i]['spamt']);
			}
			params.amtrp = rptotal;
			params.amtsp = sptotal;
			$.ajax({
				type : "post",
				url : "${ctx}/rec/erpRec/SaveListjqGridItemE",
				data : JSON.stringify(params),
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
	}

	function show_dep(v) {
		if (v != null) {
			$('#val_dep').html("");
		}
	}
	function show_vendor(v) {
		if (v != null) {
			$('#val_vendor').html("");
		}
	}
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a
			href="${ctx}/rec/erpRec/formE?id=${ErpRecNew.id}">入库<shiro:hasPermission
					name="rec:erpRec:view">${not empty erpRec.id?'修改':'添加'}</shiro:hasPermission>
		</a></li>
	</ul>
	<br />

	<form:form id="inputForm" modelAttribute="erpRecNew"
		action="${ctx}/rec/erpRec/save" method="post" >
		<form:hidden path="id" />
		<sys:message content="${message}" />
		
		<div class="container">
		   <div class="row">
		      <div class="col-xs-4 col-sm-4">
						单据编号：<form:input path="no" id="no"  class="required" readonly="true" />
		      </div>
		      
		     
		      <div class="col-xs-4 col-sm-4">
	                                    部门：
						<form:select path="depid" class="input-medium"
							onchange="show_dep(this.options[this.options.selectedIndex].value)">
							<form:option value="">请选择入库部门...</form:option>
							<form:options items="${erpDepartmentslist}"
								itemLabel="departmentDesc" itemValue="id" htmlEscape="false" />
							<span id="val_dep" style="color:#F00" class="help-inline"><font
					        color="red">*</font> </span>
						</form:select>
		      </div>
		      <div class="col-xs-4 col-sm-4">
						供货商：
						<form:select path="vendorid" class="input-medium"
							onchange="show_vendor(this.options[this.options.selectedIndex].value)">
							<form:option value="">请选择供货商...</form:option>
							<form:options items="${erpVendorlist}" itemLabel="vendorDesc"
								itemValue="id" htmlEscape="false" />
						</form:select>
		      </div>
		   </div>

		   <br>
		   
		   <div class="row">
		      <div class="col-xs-12 col-sm-12">
	                                    备注信息：
						<form:textarea path="remarks" id="remarks" htmlEscape="false"
					     maxlength="255" class="input-xxlarge " />
		      </div>
		   </div>		
		</div>
					
		
		<br>
		
        <div>
			<div class="controls">
				<table id="dg" class="easyui-datagrid"
					style="width:550px;height:250px">
				</table>
			</div>
			<div id="tb">
				<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true"
					onclick="append()">添加</a> <a href="#" class="easyui-linkbutton"
					iconCls="icon-remove" plain="true" onclick="remove()">移除</a>
			</div>
			<div class="form-actions">
				<shiro:hasPermission name="rec:erpRec:edit">
					<input id="btnsave" class="btn btn-primary" onclick="SaveData()"
						type="button" value="提交" />&nbsp;</shiro:hasPermission>
				<input id="btnCancel" class="btn" type="button" value="返 回"
					onclick="history.go(-1)" />
			</div>
		
		</div>
		    <%-- <img src="${ctxStatic}/images/1.jpg" width="100px" hight="100px"  alt="提示文字"> --%>
	</form:form>
</body>
</html>
