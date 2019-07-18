<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<c:set var="ctx" value="${pageContext.request.contextPath}${fns:getAdminPath()}"/>
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static"/>

<!-- layui插件 -->
<script type="text/javascript">var ctx = '${ctx}', ctxStatic='${ctxStatic}';</script>
<link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"  media="all">
<script src="${ctxStatic}/layui/layui.js" charset="utf-8"></script>

<html>
<head>
	<title>基础数据--通用字典</title>
	<script type="text/javascript">
			layui.use('layer', function(){
				  var layer = layui.layer;
				  layer.msg("使用Layui!");

				});  
	</script>
</head>
<body>
<h1>测试界面</h1>
<div class="layui-tab">
 
</div>
      
</body>
</html>
