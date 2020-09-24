<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>入库管理</title>
	<meta name="decorator" content="default"/>
    <style>
        .sel_btn{
            color: red;
        }
    </style>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
		$(document).ready(function() {
			
			//导出功能
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出用户数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/rec/erpRec/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
		});
		function Audit(id){
			$.ajax({
				type : "post",
				url : "${ctx}/rec/erpRec/erpRecAudit", 
				dataType : 'json',
		    	data: {
		    	   id:id						//传值，多个值之间用逗号隔开，最后一个不用写逗号
		    	},
		    	success:function(data){
   	               if(data.result=="Y"){
   		                  layer.msg("审核成功");
   		           }else{
   		                  layer.msg("审核失败,失败原因【"+data.result+"】");
   		           }
		    	},
                error:function(data){
   		             alert(data.result);
                }
			});
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/rec/erpRec/">入库<shiro:hasPermission name="rec:erpRec:Audit">审核</shiro:hasPermission></a></li>
		
	</ul><br/>
	<form:form id="searchForm" modelAttribute="erpRec" action="${ctx}/rec/erpRec/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>单据编号：</label>
				<form:input path="no" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>部门：</label>
				<form:input path="depdesc" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>供货商：</label>
				<form:input path="vendordesc" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="btns"><input id="btnExport" class="btn btn-primary" type="button" value="导出"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>主键</th>
				<th>单据编号</th>
				<th>部门</th>
				<th>供货商</th>
				<th>进价金额</th>
				<th>售价金额</th>
				<th>创建者</th>
				<th>创建时间</th>
				<th>审核人</th>
				<th>审核时间</th>
				<th>更新者</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<th>是否审核</th>
				<th>标识</th>
				<shiro:hasPermission name="rec:erpRec:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="ErpRec">
			<tr>
				<td>
					${ErpRec.id}
				</td>
				<td>
				  <c:choose>
                        <c:when test="${ErpRec.auditFlag=='N'}">
                            <a class="blue" href="${ctx}/rec/erpRec/formE?id=${ErpRec.id}">
                                    ${ErpRec.no}
                            </a>
                        </c:when>
                        <c:otherwise>
                            ${ErpRec.no}
                        </c:otherwise>
                  </c:choose>
                </td>
				<td>
				   <c:choose>
                        <c:when test="${ErpRec.auditFlag=='N'}">
                            <a  color:"#FF0000" href="${ctx}/rec/erpRec/formE?id=${ErpRec.id}">
                                    ${ErpRec.depdesc}
                            </a>
                        </c:when>
                        <c:otherwise>
                            ${ErpRec.depdesc}
                        </c:otherwise>
                  </c:choose>
                </td>
				<td>
					${ErpRec.vendordesc}
				</td>
				<td>
					${ErpRec.amtrp}
				</td>
				<td>
					${ErpRec.amtsp}
				</td>
				<td>
					${ErpRec.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${ErpRec.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${ErpRec.auditBy.id}
				</td>
				<td>
					<fmt:formatDate value="${ErpRec.auditDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${ErpRec.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${ErpRec.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${ErpRec.remarks}
				</td>
				<td>
					${fns:getDictLabel(ErpRec.delFlag, 'del_flag', '')}
				</td>
				<td>
					${ErpRec.auditFlag eq "Y"?"已审":"待审"}
				</td>
				
				<shiro:hasPermission name="rec:erpRec:edit"><td>
				      <c:choose>
                        <c:when test="${ErpRec.auditFlag=='N'}">
                            <a  class="sel_btn" onclick="Audit('${ErpRec.id}')">审核</a>
		    				<a  class="sel_btn" href="${ctx}/rec/erpRec/form?id=${ErpRec.id}">修改</a>
		    				<a  class="sel_btn" href="${ctx}/rec/erpRec/delete?id=${ErpRec.id}" onclick="return confirmx('确认要删除该入库吗？', this.href)">删除</a>
                        </c:when>
                        <c:otherwise>
                            <a>审核</a>
		    				<a>修改</a>
		    				<a>删除</a>
                        </c:otherwise>
                    </c:choose>
					
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	
</body>
</html>