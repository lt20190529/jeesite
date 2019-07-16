<%@tag pageEncoding="utf-8"%>
<%@attribute name="paginator" type="com.github.miemiedev.mybatis.paginator.domain.Paginator" required="true" %>
<%@attribute name="formId" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    //未取得分页信息时不显示分页标签
    if(paginator == null){
        return;
    } 
%>
<ul class="pager col-sm-9" style="margin-top: -10px;">
    <c:choose>
        <c:when test="${paginator.hasPrePage}">
            <li class="previous"><a href="javascript:void(0);" pageParam="?page=1">首页</a></li>
            <li class="previous"><a href="javascript:void(0);" pageParam="?page=${paginator.page-1}">上一页</a></li>
        </c:when>
        <c:otherwise>
            <li class="previous disabled"><a href="javascript:void(0);">首页</a></li>
            <li class='previous disabled'><a href="javascript:void(0);">上一页</a></li>
        </c:otherwise>
    </c:choose>

    <c:choose>
        <c:when test="${paginator.hasNextPage}">
            <li class="previous"><a href="javascript:void(0);" pageParam="?page=${paginator.page+1}">下一页</a></li>
            <li class="previous"><a href="javascript:void(0);" pageParam="?page=${paginator.totalPages}">尾页</a></li>
        </c:when>
        <c:otherwise>
            <li class='previous disabled'><a href="javascript:void(0);">下一页</a></li>
            <li class='previous disabled'><a href="javascript:void(0);">尾页</a></li>
        </c:otherwise>
    </c:choose>

    <li class="disabled">
        <a>&nbsp;第${paginator.page}页/共${paginator.totalPages}页/共${paginator.totalCount}条记录</a>
    </li>
</ul>
<script>
    $(function(){
       
        $("ul.pager li:not(.disabled) a").bind("click",function(){
            var pageParam = $(this).attr("pageParam");
            var formId = "${formId}";
            if (formId == "") {
                formId = "queryParamsForm";
            }
            var $queryParamForm = $('#' + formId);
            //获取调用页面的form对应的action
            var action = $queryParamForm.attr('action');
            $queryParamForm.attr('action',action + pageParam).submit();
        })
    })
</script>

