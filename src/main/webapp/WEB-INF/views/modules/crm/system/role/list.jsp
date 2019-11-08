<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="ctx"
       value="${pageContext.request.contextPath}${fns:getAdminPath()}" />
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static" />


<html>
<head>
    <title>角色列表</title>

    <link
            href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            type="text/css" rel="stylesheet" />
    <meta name="decorator" content="default" />
    <style>
        .container-fluid {
            padding-right: 10px;
            padding-left: 10px;
        }
    </style>
</head>
<body>
<form:form id="rolelist" method="post" modelAttribute="roleQueryParams"
           class="form-horizontal" role="form" action="${ctx}/sysmgr/role/query">
    <div class="container-fluid">
        <div class="row-fluid ">
            <div class="row">
                <div class="col-md-12">
                    <ul class="nav nav-tabs-title">
                        <li class="active"><span><i class="fa fa-gear"></i>  角色检索</span></li>
                        <li class="buttons">
                            <button type="submit" class="btn btn-warning btn-sm">
                                <i class="fa fa-search"></i>&nbsp;&nbsp;查 询
                            </button>
                            <button type="button" class="btn btn-primary btn-sm">
                                <i class="fa fa-bug"></i>&nbsp;&nbsp;清 屏
                            </button>
                        </li>
                    </ul>
                </div>
            </div>

            <br>

            <div class="row">
                <div class="col-md-3 col-md-offset-3 form-inline">
                    角色名称：<input class="input-medium" type="text" name="drug.Drug_Code" />
                </div>
                <div class="col-md-3 form-inline">
                    是否启用：<input class="input-medium" type="text" name="drug.Drug_Desc" />
                </div>
            </div>


        </div>
    </div>

    <hr>
    <div class="container-fluid">
        <div class="row-fluid ">
            <div class="row">
                <div class="col-md-12">
                    <ul class="nav nav-tabs-title">
                        <li class="active"><span><i class="fa fa-bars"></i> 检索结果</span></li>
                        <li class="buttons"><a href="${ctx}/sysmgr/role/insert"
                                               class="btn btn-success btn-sm"><i class="fa fa-th-large"></i>&nbsp;&nbsp;添加</a></li>
                    </ul>
                </div>
            </div>
            <br>
            <br>
            <div class="row">
                <table class="table table-bordered table-striped table-hover">
                    <thead>
                    <tr>
                        <th style="text-align:center;">序号</th>
                        <th style="text-align:center;">角色编码</th>
                        <th style="text-align:center;">角色名称</th>
                        <th style="text-align:center;">角色描述</th>
                        <th style="text-align:center;">角色类型</th>
                        <th style="text-align:center;">系统角色</th>
                        <th style="text-align:center;">所属机构</th>
                        <th style="text-align:center;">状态</th>
                        <th style="text-align:center;">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${roleList}" var="roleList"
                               varStatus="status">
                        <tr>
                            <td style="text-align:center">${status.index + 1}</td>
                            <td style="text-align:center">${roleList.code}</td>
                            <td style="text-align:center">${roleList.name}</td>
                            <td style="text-align:center">${roleList.descript}</td>
                            <td style="text-align:center">${roleList.roletype}</td>
                            <td style="text-align:center">
                                <c:choose>
                                    <c:when test="${roleList.sysflag =='Y'}">是</c:when>
                                    <c:otherwise>否</c:otherwise>
                                </c:choose>
                            </td>
                            <td style="text-align:center">${roleList.office}</td>
                            <td style="text-align:center">
                                <c:choose>
                                    <c:when test="${roleList.reserved =='Y'}">启用</c:when>
                                    <c:otherwise>禁用</c:otherwise>
                                </c:choose>
                            </td>
                            <td style="text-align:center">
                                <%--<c:choose>--%>
                                    <%--<c:when test="${roleList.reserved=='true'}">--%>
                                            <a  onclick="show(${roleList.id})">
                                                <i class="fa fa-trash" aria-hidden="true"></i>&nbsp;权限设置
                                            </a>
                                            <a href="${ctx}/sysmgr/role/modify/${roleList.id}">
                                                <i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp;修改
                                            </a>
                                            <a href="${ctx}/sysmgr/role/delete/${roleList.id}">
                                                <i class="fa fa-trash" aria-hidden="true"></i>&nbsp;删除
                                            </a>

                                            <a href="${ctx}/sysmgr/role/toggleStatus/${roleList.id}">
                                                <c:choose>
                                                    <c:when test="${roleList.reserved =='Y'}">
                                                        <i class="fa fa-ban" aria-hidden="true"></i>&nbsp;禁用
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fa fa-sign-in" aria-hidden="true"></i>&nbsp;启用
                                                    </c:otherwise>
                                                </c:choose>
                                            </a>
                                    <%--</c:when>--%>
                                <%--</c:choose>--%>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <sys:pagination paginator="${roleListPaginator}" formId="rolelist" />

            </div>
        </div>
    </div>

</form:form>
<script>
    function show(roleId){
        $.jBox.open("iframe:${ctx}/sysmgr/role/maintain/"+roleId, "角色权限维护", 600, 600, {           //如果是修改，传个ID就行了

            buttons: {"确定": "ok", "关闭": true},submit: function (v, h, f) {
                if (v == "ok") {
                    var iframeName = h.children(0).attr("name");
                    var iframeHtml = window.frames[iframeName];               //获取子窗口的句柄
                    var tree =iframeHtml.zTreeObj.getCheckedNodes();
                    var param = [];
                    var ids=[];
                    for (var i = 0, j = tree.length; i < j; i++) {
                        ids[i] = [tree[i].id];  //ids[i] = [tree[i].id, tree[i].pId, tree[i].name]
                    }
                    saveOrUpdate(roleId,ids)
                    return false;
                }
            },

            loaded: function (h) {
                var ids="";
                $.ajax({
                    url:"${ctx}/sysmgr/role/GetMenuList",
                    type:"GET",
                    data:{"roleId":roleId},
                    dataType:"text",
                    success : function(data) {
                        var obj = JSON.parse(data);
                        if (obj.state="success") {
                            var ids =obj.list;
                            for(var i=0; i<ids.length; i++) {
                                var iframeName = h.children(0).attr("name");
                                var iframeHtml = window.frames[iframeName];               //获取子窗口的句柄
                                var tree =iframeHtml.zTreeObj;
                                var node = tree.getNodeByParam("id", ids[i]);
                                try{tree.checkNode(node, true, false);}
                                catch(e){
                                }
                                tree.expandAll(true);   // 默认展开全部节点
                            }
                        }
                    },
                    error : function() {
                        layer.alert("失败!");
                    }
                })



                $(".jbox-content", document).css("overflow-y", "hidden");
            }
        });
    };

    //保存角色菜单
    function saveOrUpdate(roleId,ids){
        $.ajax({
            url:"${ctx}/sysmgr/role/saveRoleMenu",
            type:"post",
            data:{"roleId":roleId,"ids":ids},
            dataType:"text",
            traditional: true,
            contentType : "application/x-www-form-urlencoded",
            dataType : "json",
            success : function(data) {
                if (data.state == "success") {
                    layer.alert("保存成功!")
                }
            },
            error : function() {
                layer.alert("保存失败!");
            }
        })

    };


</script>
</body>

</html>
