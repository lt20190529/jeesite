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
                        <li class="active"><span><i class="fa fa-gear"></i>  用户检索</span></li>
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
                <div class="col-md-3 form-inline">
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
                        <th style="text-align:center;">状态</th>
                        <th style="text-align:center;">操作</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
                <sys:pagination paginator="${roleListPaginator}" formId="rolelist" />
            </div>
        </div>
    </div>

</form:form>
</body>
</html>
