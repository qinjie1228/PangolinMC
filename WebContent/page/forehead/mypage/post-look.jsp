<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/page/common/page-include.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>帖子查看</title>

</head>
<style>
.post-form{
min-height:800px;
}
</style>
<body>   
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">前台</li>
	  <li class="active">个人中心</li>
	  <li id="postNameShow" class="active">精品帖子</li>
	</ol>
	
	<div class="post-form">
	<input type="hidden" value="${post.postState}" id="postState" name="postState">
		<fieldset>
        	<legend>帖子详情</legend>
        	<div class="form-group">
			 <label>帖子类别</label>
				<select type="select" style="float:right;margin-right:100px;width:470px;" id="postCategory" name="postCategory" disabled="true">
					<c:if test='${post.postCategory eq "主题帖"}'>
						<option value="主题帖"  selected>主题帖</option>
						<option value="交友贴">交友贴</option>
						<option value="投诉建议贴">投诉建议贴</option>
					</c:if>
 					<c:if test='${post.postCategory eq "交友贴"}'>
						<option value="主题帖">主题帖</option>
						<option value="交友贴"  selected>交友贴</option>
						<option value="投诉建议贴">投诉建议贴</option>
					</c:if>
					<c:if test='${post.postCategory eq "投诉建议贴"}'>
						<option value="主题帖">主题帖</option>
						<option value="交友贴">交友贴</option>
						<option value="投诉建议贴"  selected>投诉建议贴</option>
					</c:if> 
					
				</select>
			 </div>
            <div class="">
				<label class=" ">帖子标题</label>
				<input type="text" class=" form-right" style="float:right;margin-right:100px;width:470px;" value="${post.postTitle }"  placeholder="帖子标题" disabled="true">
		  	</div>
		  <br>
		  	<div class="">
				<label class=" ">帖子图片</label>
				 <input type="file" id="postAlertUp" name="file" style="float:right;margin-right:100px;width:470px;" disabled="true"/>
				 <div style="margin-left:82px;"><img src="/upload/post/${post.postPic }" width="150" height="120" /></div> 
		  	</div>
		  
		   	<div class="">
				<label class=" ">帖子内容</label>
				<div style="float:right;width:94%;">${post.postContent }</div>
				<button style="float:right;margin-right:10px;margin-top:30px;" class="btn btn-primary" onclick="return confirm();">确认</button>
		  	</div>
		
		</fieldset>
		
	</div>	
</div>
</body>
  
  
 <script type="text/javascript">
$(document).ready(function(){

	var postState=$("#postState").val();
	switch(Number(postState)){
	case 6:
		$("#postNameShow").html("待审核精品帖子");
        break;
	case 2:
		$("#postNameShow").html("精品帖子");
        break;
	case 4:
		$("#postNameShow").html("置顶帖子");
        break;
	case 5:
		$("#postNameShow").html("过期帖子");
        break;
	}
	
});


function confirm(){
	var postState=$("#postState").val();
	art.dialog(
	        {
	            content:'确定离开？',
	            style:'succeed noClose'
	        },
	        function(){
	        	window.location.href="<%=basePath%>post/toGetAllPost.do?postState="+postState+"&url=page/forehead/mypage/my-post";
	        },
	        function(){
	            ;
	        }
	);
}



			  
</script>
  
  
  
</html>
