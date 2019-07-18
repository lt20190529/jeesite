<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>


<html>
  <head>
    <meta charset="utf-8"> 
    <meta name="decorator" content="default"/>
	<style type="text/css">
		.ztree {overflow:auto;margin:0;_margin-top:10px;padding:10px 0 0 10px;}
	</style>
    
	 <script src="${pageContext.request.contextPath}/static/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
	<link href="${pageContext.request.contextPath}/static/jquery-ztree/3.5.12/css/zTreeStyle/zTreeStyle.min.css" rel="stylesheet" type="text/css"/>
    <script src="${pageContext.request.contextPath}/static/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.min.js" type="text/javascript"></script> 


<script type="text/javascript">

</script>

  </head>
  
  <body>
  <div id="content" class="row-fluid">
        <div class="accordion-group">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="新增"/>
			&nbsp;&nbsp;<input id="btnCancel" class="btn btn-primary" type="button" value="保存" onclick="history.go(-1)"/>
			&nbsp;&nbsp;
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="删除"/>
			&nbsp;&nbsp;<input id="btnCancel" class="btn btn-primary" type="button" value="关闭" onclick="history.go(-1)"/>
		</div>
		
		<br>
		<div id="left" class="accordion-group">
		
			<div class="accordion-heading">
		    	<a class="accordion-toggle">组织机构<i class="icon-refresh pull-right" onclick="refreshTree();"></i></a>
		    </div>
			<div id="ztree" class="ztree"></div>
		</div>
		<div id="openClose" class="close">&nbsp;</div>
		<div id="right">
			<iframe id="officeContent" src="${ctx}/lt/test/form" width="100%" height="91%" frameborder="0">
			</iframe>
		</div>
	</div>
	<script type="text/javascript">
		
	   /* var setting = {data:{simpleData:{enable:true,idKey:"id",pIdKey:"pId",rootPId:'0'}},
			callback:{onClick:function(event, treeId, treeNode){
					var id = treeNode.pId == '0' ? '' :treeNode.pId;
					$('#officeContent').attr("src","${ctx}/lt/test/list?id="+id+"&parentIds="+treeNode.pIds);
				}
			}
		};
		
		function refreshTree(){
			$.getJSON("${ctx}/lt/test/treeData",function(data){
				$.fn.zTree.init($("#ztree"), setting, data).expandAll(true);
			});
		}
		refreshTree(); */
		var leftWidth = 240; // 左侧窗口大小
		var htmlObj = $("html"), mainObj = $("#main");
		var frameObj = $("#left, #openClose, #right, #right iframe");
		function wSize(){
			var strs = getWindowSize().toString().split(",");
			htmlObj.css({"overflow-x":"hidden", "overflow-y":"hidden"});
			mainObj.css("width","auto");
			frameObj.height(strs[0] - 5);
			var leftWidth = ($("#left").width() < 0 ? 0 : $("#left").width());
			$("#right").width($("#content").width()- leftWidth - $("#openClose").width() -5);
			$(".ztree").width(leftWidth - 10).height(frameObj.height() - 46);
		}
		var zOperateNodes;
		$.ajax({
			async : false,
			cache : false,
			type : 'POST',
			dataType : 'json',
			url : "${ctx}/lt/test/treeData",
			error : function() {
				alert('请求失败');
			},
			success : function(data) {
				zOperateNodes = data;
			}
		})
		

		var treesetting = {
			isSimpleData : true,
			treeNodeKey : "id",
			treeNodeParentKey : "pId",
			showLine : true,
			expandSpeed : "fast",//展开速度
			callback:{onClick:function(event, treeId, treeNode){
				var id = treeNode.pId == '0' ? '' :treeNode.pId;
				var pNode = treeNode.getParentNode();
				$('#officeContent').attr("src","${ctx}/lt/test/form?id="+treeNode.id+"&parentIds="+treeNode.pIds);
				if(!!pNode) {
					//alert(treeNode.getParentNode().name);
					var iframe=$("#officeContent")[0];
					//获取子页面中id属性值为b的元素对象
				    //var aa=$("#officeContent")[0].contentWindow.$("#code")[0].value =treeNode.getParentNode().name;
					
				}
				
			}},
			view: {
				selectedMulti: false,
				//fontCss: { 'color': 'blue', 'font-family': '微软雅黑'}
				fontCss : {"font-family": "微软雅黑", "font-size": "14px"}
			},
			data : {
				simpleData : {
					enable : true
				}
			},
			
		};
		function refreshTree(){
			$.fn.zTree.init($("#ztree"), treesetting, zOperateNodes);
			/* var treeObj = $.fn.zTree.getZTreeObj("ztree"); */
			$.fn.zTree.getZTreeObj("ztree").expandAll(true);   //默认全部展开
		}

		refreshTree();

	</script>
	<script src="${pageContext.request.contextPath}/static/common/wsize.min.js" type="text/javascript"></script>
  </body>
</html>
