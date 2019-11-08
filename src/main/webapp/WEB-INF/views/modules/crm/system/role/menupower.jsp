<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}${fns:getAdminPath()}" />
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static" />
<html>
<head>
    <title>Title1</title>
    <link rel="stylesheet" href="${ctxStatic}/zTree_v3/css/demo.css" type="text/css">
    <link rel="stylesheet" href="${ctxStatic}/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script src="${ctxStatic}/zTree_v3/js/jquery-1.4.4.min.js" type="text/javascript"></script>
    <script src="${ctxStatic}/zTree_v3/js/jquery.ztree.core.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctxStatic}/zTree_v3/js/jquery.ztree.excheck.js"></script>
    <script type="text/javascript">

        var setting = {

            view: {
                isSimpleData : true,
                //autoCancelSelected: true,
                selectedMulti: true, //设置是否能够同时选中多个节点
                showIcon: true, //设置是否显示节点图标
                showLine: true, //设置是否显示节点与节点之间的连线
                showTitle: true, //设置是否显示节点的title提示信息
                fontCss: {'font-weight':'bold','color': ''}//统一设置样式
            },
            data: {
                key: {
                    checked: "isChecked",
                },
                simpleData: {
                    enable: true,
                    idKey: "id",
                    pIdKey: "pId",
                    rootPId: 0
                }
            },
            check:{
                chkboxType: { "Y": "p", "N": "s" },
                chkStyle: "checkbox",//复选框类型
                enable: true //每个节点上是否显示 CheckBox
            },
        };


        var menuNodes=[
            <c:forEach items="${menuList}" var="menu">
                {
                    enable:true,
                    id:"${menu.id}",
                    pId:"${menu.parentIds}",
                    name:"${menu.name}"
                },
            </c:forEach>];


        $(document).ready(function(){
            zTreeObj = $.fn.zTree.init($("#menuTree"), setting, menuNodes);

            $("#count").click(function() {
                var zTree = $.fn.zTree.getZTreeObj("menuTree");
                var checkCount = zTree.getCheckedNodes(true).length;
                for (i=0;i<=checkCount;i++){
                var nodes = zTree.getCheckedNodes(true);
                  alert(nodes[i].id+":"+nodes[i].pId+":"+nodes[i].name);
                }
            });
        });

    </script>
</head>



<body>
<form:form id="inputForm" action="" method="post" class="form-horizontal">
    <div id="menuTree" class="ztree" style="padding:30px 60px;"></div>
    <hidden id="RoleMenuList"/>
</form:form>
</body>
</html>
