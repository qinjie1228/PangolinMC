<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma","no-cache"); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台主页</title>
<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath%>css/bootstrap-theme.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath%>css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bootstrap-paginator.js"></script>
<script type="text/javascript" src="<%=basePath%>js/back/back.js"></script>
</head>

<style>
.waiting-item{
	width:100%;
	height:50px;
	background: #f5f5f5;
}
.waiting-item-span{
	margin:15px 0px 15px 70px;
	width:200px;
}
.count-span{
	margin:15px 50px 15px 150px;
	color:red;
}
.cutLine{
	width:100%;
	height:2px;
	background-color:#c0c0c0;
}

.center{
	width:50%;
	height:500px;
	background-color:#f0eeee;
	margin-left:25%;
	margin-top:5%;
}
.center-cutLine{
/* 	width:100%;
	height:2px;
	background-color:#c0c0c0; */
}
.center-head{
}
.head-pic{
}
.head-name{
}
.head-name-right{
s}
 */
</style>
<body id="body">
	<!-- Nav tabs -->
	<ul class="nav nav-tabs" role="tablist">
		<li role="presentation" class="active"><a href="#waiting-do" onclick="count();" role="tab"data-toggle="tab">待办事项</a></li>
		<li role="presentation"><a href="#today-count" role="tab" onclick="sysCount();" data-toggle="tab">今日统计</a></li>
		<li role="presentation"><a href="#personal-center" onclick="perCenter('${currentUser.currentNo}');" role="tab" data-toggle="tab">个人中心</a></li>
	</ul>

	<!-- Tab panes -->
	<div class="tab-content">
		<!--待办事项开始-->
		<div role="tabpanel" class="tab-pane active" id="waiting-do">
		
			<div class="waiting-item"><span class="waiting-item-span"><a href="<%=basePath%>act/toGetAllAct.do?actState=1&url=page/background/act-list" target="menuFrame">待审核活动</a></span><span class ="count-span" id="actCount">0</span></div><div class="cutLine"></div>
			<div class="waiting-item"><span class="waiting-item-span"><a href="<%=basePath%>mact/toGetAllMact.do?actResState=1&url=page/background/mact-list" target="menuFrame">待审核预约</a></span><span class ="count-span" id="mactCount">0</span></div><div class="cutLine"></div>
			<div class="waiting-item"><span class="waiting-item-span"><a href="<%=basePath%>order/toGetAllOrder.do?orderState=1&url=page/background/order-list" target="menuFrame">待审核订单</a></span><span class ="count-span" id="orderCheckCount">0</span></div><div class="cutLine"></div>
			<div class="waiting-item"><span class="waiting-item-span"><a href="<%=basePath%>order/toGetAllOrder.do?orderState=2&url=page/background/order-list" target="menuFrame">待发货订单</a></span><span class ="count-span" id="orderSendCount">0</span></div><div class="cutLine"></div>
			<div class="waiting-item"><span class="waiting-item-span"><a href="<%=basePath%>post/toGetAllPost.do?postState=6&url=page/background/post-list" target="menuFrame">待审核帖子</a></span><span class ="count-span" id="postCount">0</span></div><div class="cutLine"></div>
			<div class="waiting-item"><span class="waiting-item-span"><a href="<%=basePath%>pic/toGetAllPic.do?picState=3&url=page/background/pic-list" target="menuFrame">待审核照片</a></span><span class ="count-span" id="picCount">0</span></div><div class="cutLine"></div>
		
		</div>
		<!--待办事项结束-->
		
		
		<!--今日统计开始-->
		<div role="tabpanel" class="tab-pane" id="today-count">
		

		
		</div>
		<!--今日统计结束-->
		
			
		
		<!--个人中心开始-->
		<div role="tabpanel" class="tab-pane" id="personal-center">
		
		<div class="center">
				<div class="center-head">
					<div class="head-pic"><img id="userPicShow" width="120" height="120" /></div>
					<div class="head-name">
						<span class="head-name-right" id="userNameShow"></span>
						<span class="head-name-right" id="userRealNameShow"></span>
						<span class="head-name-right" id="userStateShow"></span>
					</div>
				</div>
				<div class="center-cutLine"></div>
				<div class="center-content">
					<div class="center-content-inner">
						<div class="center-content-inner-one">年龄<span class="inner-one-span" id="userAgeShow"></span></div>
						<div class="center-content-inner-one">性别<span class="inner-one-span" id="userSexShow"></span></div>
						<div class="center-content-inner-one">邮件<span class="inner-one-span" id="userEmailShow"></span></div>
						<div class="center-content-inner-one">地址<span class="inner-one-span" id="userAddressShow"></span></div>
					</div>
				</div>
		</div>
		
		<input type="button" value="修改">
		<input type="button" value="确定">
		</div>
		<!--个人中心结束-->
	</div>
</body>
</html>