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
     function uploadPhoto() {
         $("#photoFile").click();
     }

     function upload(){
         if ($("#photoFile").val() == '') {
             return;
         }

         var formData = new FormData();
         formData.append('photo', document.getElementById('photoFile').files[0]);
         alert(formData.get("phone"));

         $.ajax({
             type : "post",
             url : "${ctx}/lxt/test/photoUpload",
             data: formData,
             contentType: false,
             processData: false,
             success: function(data) {
                 if (data.type == "success") {

                     $("#preview_photo").attr("src", data.filepath+data.filename);
                     $("#path").attr("value", data.filepath+data.filename);
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
	</script>
</head>
<>
<h4>测试界面</h4>
<input id="btnsave" class="btn btn-primary" onclick="submit()"
		 type="button" value="CookieValue" />
<input id="btnSession" class="btn btn-primary" onclick="submit1()"
	   type="button" value="Session" />

<input id="btnModelAttribute" class="btn btn-primary" onclick="submit2()"
	   type="button" value="ModelAttribute" />

<input  id="name" class="input-xlarge required" readonly="true" >


<a href="${ctx}/lxt/test/form?id=23">修改</a>


<div>
	<a href="javascript:void(0)" onclick="uploadPhoto()">选择图片</a>
	<input type="file" id="photoFile"  onchange="upload()">
	<img id="preview_photo" src="" width="200px" height="200px">
	<input id="path">
</div>
<h4>${'明日科技'}</h4>
<h4>${"明日科技"}</h4>

${pageContext.out.bufferSize/1024}M

${pageContext.page}
11
${pageContext.servletContext.contextPath}
</body>

</html>
