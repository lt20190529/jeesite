<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>


<html>
  <head>
     <title>机构管理</title>
	<meta name="decorator" content="default"/>
	
	<!--引入4.0.0BootStrap-->
	<link href="${pageContext.request.contextPath}/static/bootstrap-4.0.0-dist/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
	<script src="${pageContext.request.contextPath}/static/bootstrap-4.0.0-dist/js/bootstrap.min.js" type="text/javascript"></script>
	
	
	<!-- layui -->
	<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css">
    <script src="${pageContext.request.contextPath}/static/layui/layui.js"></script> --%>
    <script src="${pageContext.request.contextPath}/static/layui/module/common.js"></script>
    <script src="${pageContext.request.contextPath}/static/layui/module/treeSelect/treeSelect.js"></script>
    
    
    
	<script type="text/javascript">
	  	
	</script>
	
	<!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
    <style type="text/css">
        .downpanel .layui-select-title span {
            line-height: 38px;
        }
 
        /*继承父类颜色*/
        .downpanel dl dd:hover {
            background-color: inherit;
        }
    </style>
    <style type="text/css">
        body {
            height: 100%;
            width: 100%;
            background-size: cover;
            margin: 0 auto;
        }
        td {
            font-size: 12px !important;
        }
 
        .layui-form-checkbox span {
            height: 30px;
        }
        .layui-field-title {
            border-top: 1px solid white;
        }
        table {
            width: 100% !important;
        }
 
    </style>
 
	
  </head>
  
  <body>
   
    <ul class="nav nav-tabs">
			<li class="active"><a href="${ctx}/sys/office/form?id=${office.id}&parent.id=${office.parent.id}">机构${not empty office.id?'修改':'添加'}查看</a></li>
	</ul>

	<form:form id="inputForm" modelAttribute="office"
		action="${ctx}/lt/test/save" method="post" class="form-horizontal">
		<form:hidden path="id" />
		<sys:message content="${message}" />


		<div class="container">

			<br>
			<div class="row">
				<div class="col-xs-4 col-sm-4">
					上级机构：
					<form:input path="parent.name" class="required" />
				</div>
			</div>
			<br>
			<div class="row">
				<div class="col-xs-4 col-sm-4">
					机构编码：
					<form:input path="code" class="required" />
				</div>
			</div>
			<br>
			<div class="row">
				<div class="col-xs-4 col-sm-4">
					机构描述：
					<form:input path="name" class="required" />
				</div>
			</div>

			<br>
			<div class="row">
				<div class="col-xs-4 col-sm-4">
					备注信息：
					<form:input path="remarks" />
				</div>
			</div>

			<br>
			<div class="row">
				<div class="col-xs-4 col-sm-4">
					是否可用：
					<form:select path="useable">
						<form:options items="${fns:getDictList('yes_no')}"
							itemLabel="label" itemValue="value"/>
					</form:select>
				</div>
			</div>
		</div>
        <br>
        <br>
       <label class="layui-form-label">文章栏目</label>
        <div class="layui-input-inline">
            <div class="layui-unselect layui-form-select downpanel">
                <div class="layui-select-title">
                    <span class="layui-input layui-unselect" id="treeclass">选择栏目</span>
                    <input type="hidden" name="selectID" value="0">
                    <i class="layui-edge"></i>
                </div>
                <dl class="layui-anim layui-anim-upbit">
                    <dd>
                        <ul id="classtree"></ul>
                    </dd>
                </dl>
            </div>
        </div>


	</form:form>
	
	<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script type="text/javascript">
    layui.use(['element', 'tree', 'layer', 'form', 'upload'], function () {
        var $ = layui.jquery, tree = layui.tree;
        tree({
            elem: "#classtree"
            ,
            nodes: [{
                name: '常用文件夹',
                id: 1,
                alias: 'changyong',
                children: [{name: '所有未读', id: 11, href: 'http://www.layui.com/', alias: 'weidu'}, {
                    name: '置顶邮件',
                    id: 12
                }, {name: '标签邮件', id: 13}]
            }, {
                name: '我的邮箱',
                id: 2,
                spread: true,
                children: [{
                    name: 'QQ邮箱',
                    id: 21,
                    spread: true,
                    children: [{
                        name: '收件箱',
                        id: 211,
                        children: [{name: '所有未读', id: 2111}, {name: '置顶邮件', id: 2112}, {name: '标签邮件', id: 2113}]
                    }, {name: '已发出的邮件', id: 212}, {name: '垃圾邮件', id: 213}]
                }, {
                    name: '阿里云邮',
                    id: 22,
                    children: [{name: '收件箱', id: 221}, {name: '已发出的邮件', id: 222}, {name: '垃圾邮件', id: 223}]
                }]
            }]
            ,
            click: function (node) {
                var $select = $($(this)[0].elem).parents(".layui-form-select");
                $select.removeClass("layui-form-selected").find(".layui-select-title span").html(node.name).end().find("input:hidden[name='selectID']").val(node.id);
            }
        });
        $(".downpanel").on("click", ".layui-select-title", function (e) {
            $(".layui-form-select").not($(this).parents(".layui-form-select")).removeClass("layui-form-selected");
            $(this).parents(".downpanel").toggleClass("layui-form-selected");
            layui.stope(e);
        }).on("click", "dl i", function (e) {
            layui.stope(e);
        });
        $(document).on("click", function (e) {
            $(".layui-form-select").removeClass("layui-form-selected");
        });
 
    });
</script>
</body>
</html>
