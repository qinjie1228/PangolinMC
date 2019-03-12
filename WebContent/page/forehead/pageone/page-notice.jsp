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
<title>公告详情</title>
</head>
<style>
.notice{
	min-height:800px;
}
.notice-title{
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
			<div class="notice">
				<ol class="breadcrumb">
				  <li class="active"><a href="<%=basePath%>index/toIndexNotice.do">公告</a></li>
				  <li class="active">公告详情</li>
				</ol>
				<br>
				<div class="notice-title">${notice.noticeTitle }</div>
				<div class="notice-content">${notice.noticeContent }</div>
				<br><br><br>
			</div>
		</div>
		<!--网站主体部分结束-->
	</div>


</div>
</body>
</html>
