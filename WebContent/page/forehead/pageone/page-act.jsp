<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ include file="/page/common/index-include.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>穿山甲登山俱乐部</title>
</head>
<style>
.act{
	min-height:800px;
}
.act-title{
	text-align:center;
}
</style>
<body>
<%@ include file="/page/common/user-include.jsp"%>
<div id ="main">
	<div id="index_all">
		<%@ include file="/page/common/head-include.jsp"%>
		<!--网站主体部分开始-->
		<div id="index_body">
			<div class="act">
				<ol class="breadcrumb">
				  <li class="active"><a href="<%=basePath%>index/toIndexAct.do">活动</a></li>
				  <li class="active">活动详情</li>
				</ol>
				<br>
				<div class="act-title">${act.actTitle }</div><br>
				<div class="act-content" id="actContent">${act.actContent }</div>
				<br><br><br>
			</div>
		</div>
		<!--网站主体部分结束-->
	</div>


</div>
</body>
<script type="text/javascript">
changeContentImgSize('actContent');
</script>
</html>
