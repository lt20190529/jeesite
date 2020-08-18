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
     function submit(){
         $.ajax({
             type : "post",
             url : "${ctx}/lxt/test/requiredCookie",
             contentType : "application/text;charset=utf-8",
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
     function submit1(){
         $.ajax({
             type : "post",
             url : "${ctx}/lxt/test/session",
             contentType : "application/text;charset=utf-8",
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

	</script>
</head>
<>
<h1>测试界面</h1>
<input id="btnsave" class="btn btn-primary" onclick="submit()"
		 type="button" value="CookieValue" />
<input id="btnSession" class="btn btn-primary" onclick="submit1()"
	   type="button" value="Session" />

<input id="btnModelAttribute" class="btn btn-primary" onclick="submit2()"
	   type="button" value="ModelAttribute" />

<input  id="name" class="input-xlarge required" readonly="true" >
</body>
</html>
