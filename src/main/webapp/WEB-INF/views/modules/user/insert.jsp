<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="ctx"
	value="${pageContext.request.contextPath}${fns:getAdminPath()}" />
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>用户管理</title>
<link
	href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	type="text/css" rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/static/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css"
	type="text/css" rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/static/bootstrapvalidator-master/dist/css/bootstrapValidator.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/bootstrap3-dialog-master/css/bootstrap-dialog.min.css" rel="stylesheet">

<link rel="stylesheet"
	href="${ctxStatic}/jquery-easyui/themes/default/easyui.css"
	type="text/css" />
	
	
	

<script src="${pageContext.request.contextPath}/static/bootstrap3-dialog-master//js/bootstrap-dialog.min.js"></script>
<script
	src="${pageContext.request.contextPath}/static/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
<script
	src="${pageContext.request.contextPath}/static/bootstrapvalidator-master/dist/js/bootstrapValidator.min.js"></script>
<script
	src="${pageContext.request.contextPath}/static/bootstrapvalidator-master/dist/js/language/zh_CN.js"></script>
<script
	src="${pageContext.request.contextPath}/static/sinoui/0.5.0/lib/validation/jquery.validate.min.js"></script>

<meta name="decorator" content="default" />
<style type="text/css">
 .form-horizontal .has-feedback .form-control-feedback {
            top: 0;
            right: -15px;
 }
 .vat {
     vertical-align: top
 }

 .container-fluid {
     padding-right: 10px;
     padding-left: 10px;
 }

 .row-fluid {
     padding-right: 30px;
     padding-left: 80px;
 }
</style>
<script type="text/javascript">

	$(function() {
		
		$('#startDate').datetimepicker({
			format : 'yyyy-mm-dd',
			minView : 'month',
			language : 'zh-CN',
			autoclose : true,
			pickerPosition : 'bottom-left', //位置：相对图标而言
			//initialDate:new Date(),
			todayHighlight : true //当天高亮显
		}).on("click", function() {

		});
		$('#endDate').datetimepicker({
			format : 'yyyy-mm-dd',
			minView : 'month',
			language : 'zh-CN',
			autoclose : true,
			pickerPosition : 'bottom-left', //位置：相对图标而言
			//initialDate:new Date(),
			todayHighlight : true //当天高亮显示
		}).on("click", function() {
			
		});

		
		$('#loginName').focus();   //聚焦第一个input

		 
		
		//BootStrap表单校验
		$('#userInsert').bootstrapValidator({
			//excluded:[":disabled"],                              //关键配置，表示只对于禁用域不进行验证，其他的表单元素都要验证“隐藏域（:hidden）、禁用域（:disabled）、那啥域（:not(visible)）”是不进行验证的。
	        message: 'This value is not valid',                    // 为每个字段指定通用错误提示语
	        feedbackIcons: {                                       //验证时显示的图标
	            //valid: 'glyphicon glyphicon-ok',                 //正确图标
	            //invalid: 'glyphicon glyphicon-remove',           //错误图标
	            //validating: 'glyphicon glyphicon-refresh'        //正在更新图标
	        },
  
	        fields: {                                              //要验证哪些字段
		            loginName: {                                   //与表单里input的name属性对应
		                message: '登录名不能为空',                  //验证错误时的信息，当然这里是可以使用中文的
		                validators: {
		                    notEmpty: {                            //非空判断
		                        message: '登录名不能为空'           //验证错误时的信息，
		                    },
		                    stringLength: {                        //长度校验
	                            min: 6,
	                            max: 18,
	                            message: '用户名长度必须在6到18位之间'
	                        },
	                        regexp: {                                      //格式校验(正则表达式)
	                            regexp: /^[a-zA-Z0-9_]+$/,
	                            message: '用户名只能包含大写、小写、数字和下划线'   
	                        },
		                    remote: { 
		                        url: "${ctx}/sysmgr/user/checkLoginName",       //ajax验证。server result:{"valid",true or false}
		                        message: '用户名已存在,请重新输入',
		                        //delay: 2000,                                  //ajax刷新的时间是1秒一次
		                        type: 'POST',
		                        data: function() {                               //自定义提交数据，默认值提交当前input value
		                        		return {
		                        			loginName : $("input[name=loginName]").val(), //后台Controller校验入参
		                                   // method : "checkUserName"//UserServlet判断调用方法关键字。
		                             };
		                         }
		                    }
		                }
		            },
		            displayName:{
		            	validators:{
		            		notEmpty:{
		            			message:'用户名不能为空'
		            		}
		            	}
		            },
		            employeeNumber:{
		            	validators:{
		            		notEmpty:{
		            			message:'用户名不能为空'
		            		}
		            	}
		            },
		            email: {
		                validators: {
		                    notEmpty: {
		                        message: '邮箱不能为空'
		                    },
		                    emailAddress: {                                             //是不是正确的email格式
		                        message: '邮箱格式不正确'             
		                    }
		                }
		            },
		            mobile:{
		            	validators: {
		                    notEmpty: {
		                        message: '手机号码不能为空'
		                    },
							stringLength : {
								min : 11,
								max : 11,
								message : '请输入11位手机号码'
							},
							regexp : {
								regexp : /^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$/,
								message : '请输入正确的手机号码'
							}
		                }
		            },
		            qq:{
		            	validators: {
		                    notEmpty: {
		                        message: 'QQ不能为空'
		                    },
		                    digits: {
		                        message: '该值只能包含数字。'     //纯数字校验
		                    }
		                }
		            },
		            startDate: {
						trigger:'change',                            // 日期改变时触发验证，不然选择日期后不验证
						validators: {
							notEmpty: {
								message: '生效日期不能为空'
							}
						}
					},
		            endDate: {
						trigger:'change',                            // 日期改变时触发验证，不然选择日期后不验证
						validators: {
							notEmpty: {
								message: '失效日期不能为空'
							}
						}
					},
					userType: {
		                validators: {
		                    notEmpty: {
		                        message: '用户类型不能为空'
		                    }
		                }
		            }
	        }
	        
	       
	    })
	   
		.on('success.form.bv', function(e) {//点击提交之后
	       /*   // Prevent form submission
	         e.preventDefault();
	         var $form = $(e.target);
	         // Get the BootstrapValidator instance
	         var bv = $form.data('bootstrapValidator'); */
		});
		$('#userInsert').bootstrapValidator('addField', 'roleList', { 
			validators: { 
				choice: {
                    min: 2,
                    max: 4,
                    message: '至少选择 %s - %s 个角色'
                }
			}
	    });
		
		//hidden 隐藏元素的验证需要excluded:[":disabled"]一起使用
		
		/* $('#userInsert').bootstrapValidator('addField',$("#companyId"),{ 
			validators: { 
				notEmpty: {
                    message: 'The company is required'
                }
			}
	    }); 
		*/
		
		//非隐藏元素可以直接验证 $("#companyName")为元素对象
	     $('#userInsert').bootstrapValidator('addField',$("#primaryGroupID"),{ 
			validators: { 
				notEmpty: {
                    message: '请选择组别'
                }
			}
	    }); 
		
	
		
		 $('#userInsert').bootstrapValidator('addField',$("#companyID"),{ 
				validators: { 
					notEmpty: {
	                    message: '请选择公司'
	                }
				}
		    });
		
		//提交
		$('#userInsert').submit(function() {
			
			
			var startDate = $("#startDate").val();
			var endDate = $("#endDate").val();
			if (startDate>=endDate){
				layer.alert("失效日期要晚于生效日期!");
				return false;
			}

			//alert($("#userInsert").data("bootstrapValidator").isValid());    //校验是否通过

		});
		
		 //事例
		 //保存 手动验证表单，当是普通按钮时。
		 /*
         function save() {
        
	        
	        $('form').data('bootstrapValidator').validate();
	        if(!$('form').data('bootstrapValidator').isValid()){
	            return ;
	        }
	        
	        document.getElementById("dataForm").submit();
	        $("#zhongxin").hide();
	        $("#zhongxin2").show();
        }
		*/

	});
</script>

</head>

<body>
    <sys:alertbar data="${alertInfo}"/>
	<form:form id="userInsert" method="post" modelAttribute="sysUser"
		class="form-horizontal" role="form" action="${ctx}/sysmgr/user/insert">
		<div class="container-fluid">
			<div class="row-fluid ">
				<div class="row">
					<div class="col-md-12">
						<ul class="nav nav-tabs-title">
			                <li class="active"><span><i class="fa fa-gear"></i>  新增用户</span></li>
			                
			            </ul>
					</div>
				</div>

				<br>
				<br>

				<div class="col-md-4 form-inline">
					<label class="col-sm-4">登录名：</label>
					<div class="col-sm-8">
						<form:input path="loginName" class="" required="true" />
					</div>
				</div>

				<div class="col-md-4 form-inline">
					<label class="col-sm-4">用户名：</label>
					<div class="col-sm-8">
						<form:input path="displayName" class="" required="true" />
					</div>
				</div>

				<div class="col-md-4 form-inline">
					<label class="col-sm-4">用户编码：</label>
					<div class="col-sm-8">
						<form:input path="employeeNumber" class="" required="true" />
					</div>
				</div>

				<br> <br>
				<br>

				<div class="col-md-4 form-inline">
					<label class="col-sm-4">Email：</label>
					<div class="col-sm-8">
						<form:input path="email" class="" required="true" />
					</div>
				</div>



				<div class="col-md-4 form-inline">
					<label class="col-sm-4">办公电话：</label>
					<div class="col-sm-8">
						<form:input path="officeTel" class="" />
					</div>
				</div>

				<div class="col-md-4 form-inline">
					<label class="col-sm-4">手机：</label>
					<div class="col-sm-8">
						<form:input path="mobile" class="" required="true"/>
					</div>
				</div>

				<br> <br>
				<br>
	


				<div class="col-md-4 form-inline">
					<label class="col-sm-4">QQ：</label>
					<div class="col-sm-8">
						<form:input path="qq" class="" required="true"/>
					</div>
				</div>

				<div class="col-md-4 form-inline">
					<label class="col-sm-4">传真：</label>
					<div class="col-sm-8">
						<form:input path="fax" class="" />
					</div>
				</div>

				<div class="col-md-4 form-inline">
					<label class="col-sm-4">用户类型：</label>
					<div class="col-sm-8">
						<select id="userType" name="userType"
							style="width:210px;height:26.96px">

							<c:forEach items="${USER_TYPE}" var="ut">
								<option value="${ut.code}">${ut.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>


				<br> <br>
				<br>

				<div class="col-md-4 form-inline">
					<label class="col-sm-4">生效日期：</label>
					<div class="col-sm-8">
						<div class='input-group date'>
							<form:input path="startDate"  class="form-control" required="true"
								style="width:170px;height:26.96px" /> <span
								class="input-group-addon"> <span
								class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
					</div>
				</div>



				<div class="col-md-4 form-inline">
					<label class="col-sm-4">失效日期：</label>
					<div class="col-sm-8">
						<div class='input-group date'>
							<form:input path="endDate" class="form-control" required="true"
								style="width:170px;height:26.96px" /> <span
								class="input-group-addon"> <span
								class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
					</div>
				</div>

				<div class="col-md-4 form-inline">
					<label class="col-sm-4">是否有效：</label>
					<div class="col-sm-8">
						<form:radiobuttons path="enabled" items="${userStatus}"
							delimiter="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
							labelCssClass="radio-inline" />
					</div>
				</div>

				<br> <br>
				<br>
               
				<hr>


				<div class="col-md-12 form-inline">
					<label class="col-sm-2" style="width:140.74px">所属公司：</label>
					<div class="col-sm-10" style="width:890px;height:26.96px">
						<div class='input-group date' id='companyD'>
							</label>
							<sys:treeselect id="companyID" name="companyID"
								value="companyID" labelName="company.name"
								labelValue="${user.office.name}" title="公司"
								url="/sys/office/treeData?type=1" cssClass="input-large"  cssStyle="width:675px;height:26.96px"
								hideBtn="true" smallBtn="true" allowClear="true"  isAll="true" 
								notAllowSelectParent="true" />

						</div>
					</div>
				</div>
                <br>
                <hr>
  
				<div class="col-md-12 form-inline">
					<label class="col-sm-2" style="width:140.74px">所属公司组别：</label>
					<div class="col-sm-10" >
						<div class='input-group date' id='officeD'>
							</label>
							<sys:treeselect id="officeID" name="officeID" value="officeID" labelName="office.name"
								labelValue="" title="组别"
								url="/sys/office/treeData?type=2" cssClass="input-large" cssStyle="width:675px;height:26.96px"
								hideBtn="true" smallBtn="true" allowClear="true"  isAll="true"
								notAllowSelectParent="true" />
						</div>
					</div>
				</div>

				<br> <br>

				<hr>
				<div class="col-md-12 form-inline">
					<label class="col-sm-1">角色：</label>
					<div class="col-sm-10 col-md-offset-0 text-left " style="">
						<c:forEach items="${roleList}" var="roleList" varStatus="status">
							<label style="vertical-align:middle;padding:0px 20px 0px 20px">
								<input id=${roleList.id } name="roleList" type="checkbox"
								class="vertical-align:middle" style="zoom:140%;"
								value=${roleList.id }>${roleList.name}
							</label>
						</c:forEach>
					</div>
				</div>

				<br>

				<hr>


				<div class="col-xs-12 col-sm-12 col-md-12">
					<div class="form-group sino-form-group-btn col-md-offset-0">
						<button type="submit" class="btn btn-warning col-md-offset-8">
							<i class="fa fa-floppy-o "></i>保 存
						</button>
						<a type="button" href="${ctx}/sysmgr/user/list?page=1"
							class="btn btn-default"><i class="fa fa-undo"></i>返回列表</a>
					</div>
				</div>

			</div>


		</div>
	</form:form>

</body>
</html>
