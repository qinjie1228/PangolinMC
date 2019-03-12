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
</head>

<style>
.center{
	width:50%;
	height:500px;
	background-color:#f0eeee;
	margin-left:25%;
	margin-top:5%;
}
</style>
<body id="body" style="width:90%;">
<input id="userNo" type="hidden" value="${currentUser.currentNo }">
<input id="userName" type="hidden" value="${currentUser.currentName }">
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
		
		<input style="margin-left:160px;" type="button" value="修改">
		<input style="margin-left:50px;" type="button" value="确定">
</body>
<script>
$(function(){
	var userNo = $("#userNo").val();
	perCenter(userNo);
});

function perCenter(userNo) {
	$.ajax({
		type : "post",
		url : "<%=basePath%>" + "user/findUserByUserNo.do",
		data : "userNo="+userNo,
		success : function(data) {
			$("#userNameShow").html(data.userName); 
			$("#userRealNameShow").html(data.userRealName);
			switch(Number(data.userState)){
			case 4:
				$("#userStateShow").html("管理员");
			case 5:
				$("#userStateShow").html("系统管理员");
			}
			$("#userAgeShow").html(data.userAge);
			$("#userSexShow").html(data.userSex);
			$("#userEmailShow").html(data.userEmail);
			$("#userAddressShow").html(data.userAddress);
			$("#userPicShow").attr('src', '/upload/user/'+data.userPic);
		}
	});
}
</script>
</html>