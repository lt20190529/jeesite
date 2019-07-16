<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>销售管理--销售审核</title>
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
	
	function Audit(id){
		$.ajax({
			type : "post",
			url : "${ctx}/sales/erpSales/erpSalesAuditBySalesId", 
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
		<li class="active"><a href="${ctx}/sales/erpSales/">销售<shiro:hasPermission name="sales:erpSales:Audit">审核</shiro:hasPermission></a></li>
	</ul>
	
	<br/>
	<form:form id="searchForm" modelAttribute="erpSales" action="${ctx}/sales/erpSales/erpSalesAudit" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>单据编号：</label>
				<form:input path="no" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>部门：</label>
				<form:input path="depdesc" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>买方：</label>
				<form:input path="buyername" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<!-- <th>主键</th> -->
				<th>出库单号</th>
				<th>部门</th>
				<th>买方</th>
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
				<shiro:hasPermission name="sales:erpSales:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="ErpSales">
			<tr>
				<%-- <td>
					${erpRec.id}
				</td> --%>
				<td>
				 <c:choose>
                        <c:when test="${ErpSales.auditFlag=='N'}">
                            <a class="blue" href="${ctx}/sales/erpSales/erpSalesForm?id=${ErpSales.id}">
                                    ${ErpSales.no}
                            </a>
                        </c:when>
                        <c:otherwise>
                            ${ErpSales.no}
                        </c:otherwise>
                  </c:choose>
                </td>
				<td>
				 <c:choose>
                        <c:when test="${ErpSales.auditFlag=='N'}">
                            <a class="blue" href="${ctx}/sales/erpSales/erpSalesForm?id=${ErpSales.id}">
                                    ${ErpSales.depdesc}
                            </a>
                        </c:when>
                        <c:otherwise>
                            ${ErpSales.depdesc}
                        </c:otherwise>
                  </c:choose>
				<td>
					${ErpSales.buyername}
				</td>
				<td>
					${ErpSales.amtrp}
				</td>
				<td>
					${ErpSales.amtsp}
				</td>
				<td>
					${ErpSales.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${ErpSales.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${ErpSales.auditBy.id}
				</td>
				<td>
					<fmt:formatDate value="${ErpSales.auditDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${ErpSales.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${ErpSales.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${ErpSales.remarks}
				</td>
				<td>
					${fns:getDictLabel(ErpSales.delFlag, 'del_flag', '')}
				</td>
				<td>
					${ErpSales.auditFlag eq "Y"?"已审":"待审"}
				</td>
				
				<shiro:hasPermission name="rec:erpRec:edit">
				    <td>
	    				<c:choose>
	                        <c:when test="${ErpSales.auditFlag=='N'}">
	                            <a class="sel_btn" href="${ctx}/sales/erpSales/erpSalesForm?id=${ErpSales.id}">修改</a>
			    				<a class="sel_btn" onclick="Audit('${ErpSales.id}')">审核</a>
								<a class="sel_btn" href="${ctx}/sales/erpSales/delete?id=${ErpSales.id}" onclick="return confirmx('确认要删除该入库吗？', this.href)">删除</a>
	                        </c:when>
	                        <c:otherwise>
	                            <a>修改</a>
			    				<a>审核</a>
								<a>删除</a>
	                        </c:otherwise>
	                    </c:choose>
			    	</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>