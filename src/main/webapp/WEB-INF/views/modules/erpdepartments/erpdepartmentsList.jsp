<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
  <head>
   <title>部门维护管理</title>
	<meta name="decorator" content="default"/>
    <link href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
      <link rel="stylesheet" href="${pageContext.request.contextPath}/static/vue/grid/style.css">
    <script src="${pageContext.request.contextPath}/static/vue/dist/vue.js" type="text/javascript"></script>
	<script type="text/javascript">
        alert(22)
		$(document).ready(function() {



		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
      <%--vue-grid測試--%>
    <script type="text/x-template" id="grid-template">
          <table v-if="filteredData.length">
              <thead>
              <tr>
                  <th v-for="key in columns"
                      @click="sortBy(key)"
                      :class="{ active: sortKey == key }">
                      {{ key | capitalize }}
                      <span class="arrow" :class="sortOrders[key] > 0 ? 'asc' : 'dsc'">
              </span>
                  </th>
              </tr>
              </thead>
              <tbody>
              <tr v-for="entry in filteredData">
                  <td v-for="key in columns">
                      {{entry[key]}}
                  </td>
              </tr>
              </tbody>
          </table>
          <p v-else>No matches found.</p>
      </script>
  </head>
  
  <body>
    <ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/erpdepartments/departments/">部门维护列表</a></li>
		<shiro:hasPermission name="erpdepartments:departments:edit"><li><a href="${ctx}/erpdepartments/departments/form">部门维护添加</a></li></shiro:hasPermission>
	</ul>
	
	
	<form:form id="searchForm" modelAttribute="erpDepartments" action="${ctx}/erpdepartments/departments/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>部门编码：</label>
				<form:input path="departmentCode" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>部门描述：</label>
				<form:input path="departmentDesc" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>部门编码</th>
				<th>部门商描述</th>
				<th>部门商电话</th>
				<th>部门联系人</th>

				<th>创建者</th>
				<th>创建时间</th>
				<th>更新者</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<th>删除标记</th>
				<shiro:hasPermission name="erpdepartments:departments:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="ErpDepartments">
			<tr>
				
				<td><a href="${ctx}/erpdepartments/departments/form?id=${ErpDepartments.id}">
					${ErpDepartments.departmentCode}
				</a></td>
				<td>
					${ErpDepartments.departmentDesc}
				</td>
				<td>
					${ErpDepartments.departmentTel}
				</td>
				<td>
					${ErpDepartments.departmentMan}
				</td>
				<td>
					${ErpDepartments.createBy.id}
				</td>
				<td>
				    <fmt:formatDate value="${ErpDepartments.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${ErpDepartments.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${ErpDepartments.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${ErpDepartments.remarks}
				</td>
				<td>
					${fns:getDictLabel(ErpDepartments.delFlag, 'del_flag', '')}
				</td>
				
				<shiro:hasPermission name="erpdepartments:departments:edit"><td>
    				<a href="${ctx}/erpdepartments/departments/form?id=${ErpDepartments.id}">修改</a>
					<a href="${ctx}/erpdepartments/departments/delete?id=${ErpDepartments.id}" onclick="return confirmx('确认要删除该部门吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
    <br>
    <h5>xxx</h5>
    <br>
    <!-- demo root element -->
    <div id="demo">
        <demo-grid
                :data="gridData"
                :columns="gridColumns"
                :filter-key="searchQuery">
        </demo-grid>
    </div>

    <script>
        Vue.component('demo-grid', {
            template: '#grid-template',
            replace: true,
            props: {
                data: Array,
                columns: Array,
                filterKey: String
            },
            data: function () {
                var sortOrders = {}
                this.columns.forEach(function (key) {
                    sortOrders[key] = 1
                })
                return {
                    sortKey: '',
                    sortOrders: sortOrders
                }
            },
            computed: {
                filteredData: function () {
                    var sortKey = this.sortKey
                    var filterKey = this.filterKey && this.filterKey.toLowerCase()
                    var order = this.sortOrders[sortKey] || 1
                    var data = this.data
                    alert(this.data)
                    if (filterKey) {
                        data = data.filter(function (row) {
                            return Object.keys(row).some(function (key) {
                                return String(row[key]).toLowerCase().indexOf(filterKey) > -1
                            })
                        })
                    }
                    if (sortKey) {
                        data = data.slice().sort(function (a, b) {
                            a = a[sortKey]
                            b = b[sortKey]
                            return (a === b ? 0 : a > b ? 1 : -1) * order
                        })
                    }
                    return data
                }
            },
            filters: {
                capitalize: function (str) {
                    return str.charAt(0).toUpperCase() + str.slice(1)
                }
            },
            methods: {
                sortBy: function (key) {
                    this.sortKey = key
                    this.sortOrders[key] = this.sortOrders[key] * -1
                }
            }
        })
        // bootstrap the demo
        var demo = new Vue({
            el: '#demo',
            data: {
                searchQuery: '',
                gridColumns: ['name12', 'power'],
                gridData: [
                    { name12: '张三AA', power: 100 },
                    { name12: 'Bruce Lee', power: 9000 },
                    { name12: 'Jackie Chan', power: 7000 }
                ]
            }
        })
    </script>
    <script src="${pageContext.request.contextPath}/static/vue/grid/grid.js" type="text/javascript"></script>
  </body>
</html>
