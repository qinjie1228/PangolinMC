<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/page/common/index-include.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>穿山甲登山俱乐部</title>
</head>
<style>
.post{
	min-height:800px;
}
.post-title{
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
			<div class="post">
				<ol class="breadcrumb">
				  <li class="active"><a href="<%=basePath%>index/toIndexPost.do">帖子</a></li>
				  <li class="active">帖子详情</li>
				</ol>
				<br>
				<div class="the-post">
					<div class="the-post-content">
						<div class="post-title">${post.postTitle }</div><br>
						<div class="post-content" id="postContent">${post.postContent }</div>
					</div>
					<br><br>
					<div class="content-bottom">
						<span style="margin-left:20px;">发布者：<span class="color-red">${currentUser.currentName }</span></span>
						<span style="margin-left:300px;">浏览量：<span class="color-red">${post.postScanNum }</span></span>
						<span style="margin-left:40px;">评论量：<span class="color-red">${post.postCommentNum }</span></span>
						<span style="margin-left:90px;"><a id="aComment" href="javascript:onTopClick();" style="text-decoration:none;out-line:none;color:#333;">我要评论</a></span>
					</div><br>
					<div style="margin:0px 10px 0px;height:2px;background-color:#cfcfcf;"></div>
					<div class="comment" style="margin:0px 10px 0px;">
						<br><span>评论详情</span><br><br>
						<c:forEach items="${commentList}" var="comment">
							<div class="the-comment-one" style="margin:0px 10px 0px;">
								<span class="comment-user"><span style="opacity:0.5;">${comment.userName }</span>：</span><br>
								<span class="comment-content">${comment.commentContent }</span>
							</div><br>
						</c:forEach>
					</div><br><br>
					<div id="toComment">
							<input type="hidden" id="commentPostNo" value="${post.postNo }">
							<span>评论：</span><br>
							<textarea id="commentContent" style="border:1px #ccc solid;" cols="110" rows="7" id="addComment"></textarea><br><br>
							<button style="float:right;margin-right:40px;" class="btn btn-primary" onclick="return addCommentConfirm();">提交</button><br><br><br><br>
					</div>
				</div>
			</div>
		</div>
		<!--网站主体部分结束-->
	</div>


</div>
</body>
<script type="text/javascript">
$(document).ready(function() {   
	$("#aComment").click(function() {     
		$("html, body").animate({       
			scrollTop: $("#toComment").offset().top }, {duration: 500,easing: "swing"});     
		return false;   });   
}); 

changeContentImgSize('postContent');

function addCommentConfirm(){
	var postNo = $("#commentPostNo").val();
	var commentContent = $("#commentContent").val();
	if(commentContent == ""){
		art.dialog.alert("请填写评语", function () {
			$("#commentContent").focus();
	    });
	}
	var userNo = $("#userNo").val();
	$.ajax({
		type : "post",
		url  : basePath + "comment/addComment.do",
		data : "postNo="+postNo+"&userNo="+userNo+"&commentContent="+commentContent, 
		success : function(data) {
			art.dialog.alert(data.addMsg, function () {
				window.location.reload();
		    });
		}
	});
	return true;
}
</script>
</html>
