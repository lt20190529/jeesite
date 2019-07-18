<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>入库管理--入库查询</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
    
    
    
    
	//学员职务统计图
	function postChart(){
		//这个echarts对象应该是在echarts-all.js文件里面初始化好的，所以直接拿来用，
		var myChart = echarts.init(document.getElementById('echarts_post')); 
		var option = {
		    title : {
		        text: '入库汇总(饼状)',
		    },
		    tooltip : {
		        trigger: 'axis'
		    },
		    legend: {
		        data:["财务部","后勤部","行政部","开发部"]
		    },
		  
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            data : ["财务部","后勤部","行政部","开发部"],
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    series : [
		        {
		            name:'人数',
		            type:'pie',
		            data:[13,9,5,4],
		        },
		        
		    ]
		};
		myChart.setOption(option); 
	}

	//学员职务统计图
	function postChart1(){
		//这个echarts对象应该是在echarts-all.js文件里面初始化好的，所以直接拿来用，
		var myChart = echarts.init(document.getElementById('echarts_post1')); 
		option = {
				title : {
			        text: '入库汇总(柱状)',
			    },
			    tooltip: {
			        trigger: 'axis',
			        axisPointer: {
			            type: 'cross',
			            crossStyle: {
			                color: '#999'
			            }
			        }
			    },
			    toolbox: {
			        feature: {
			            dataView: {show: true, readOnly: false},
			            magicType: {show: true, type: ['line', 'bar']},
			            restore: {show: true},
			            saveAsImage: {show: true}
			        }
			    },
			    legend: {
			        data:['蒸发量','降水量','平均温度']
			    },
			    xAxis: [
			        {
			            type: 'category',
			            data: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],
			            axisPointer: {
			                type: 'shadow'
			            }
			        }
			    ],
			    yAxis: [
			        {
			            type: 'value',
			            name: '水量',
			            min: 0,
			            max: 250,
			            interval: 50,
			            axisLabel: {
			                formatter: '{value} ml'
			            }
			        },
			        {
			            type: 'value',
			            name: '温度',
			            min: 0,
			            max: 25,
			            interval: 5,
			            axisLabel: {
			                formatter: '{value} °C'
			            }
			        }
			    ],
			    series: [
			        {
			            name:'蒸发量',
			            type:'bar',
			            data:[2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3]
			        },
			        {
			            name:'降水量',
			            type:'bar',
			            data:[2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3]
			        },
			        {
			            name:'平均温度',
			            type:'line',
			            yAxisIndex: 1,
			            data:[2.0, 2.2, 3.3, 4.5, 6.3, 10.2, 20.3, 23.4, 23.0, 16.5, 12.0, 6.2]
			        }
			    ]
			};

		myChart.setOption(option); 
	}
    
	$(document).ready(function() {

		//
		postChart1();
		//统计图
		postChart();

	});

	

</script>
</head>

<body>
	<ul class="nav nav-tabs">
	    <li class="active"><a href="${ctx}/rec/erpRec/erpRecReport">入库统计</a></li>
	</ul>
	<br />
	<form:form id="searchForm" modelAttribute="erpRec"
		action="${ctx}/rec/erpRec/query" method="post"
		class="breadcrumb form-search">
		<ul class="ul-form">
			<li><label>单号：</label> <form:input path="no" htmlEscape="false"
					maxlength="50" class="input-medium" /></li>
			<li><label>库房：</label> <form:input path="dep" htmlEscape="false"
					maxlength="50" class="input-medium" /></li>
			<li><label>供货商：</label> <form:input path="vendor"
					htmlEscape="false" maxlength="20" class="input-medium" /></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary"
				onclick="modify()" value="查询" /></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<div class="control-group">
	    <div id="echarts_post" style="width:600px;height:500px;float:left;"></div>
	    <div id="echarts_post1" style="width:600px;height:500px;float:left;"></div>
    </div>
    
   
    </br>

</body>

</html>
