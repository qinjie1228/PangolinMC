<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ include file="/page/common/page-include.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>评语查看</title>

</head>
<style>
.comment-form{
min-height:600px;
}
</style>
<body>   
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">前台</li>
	  <li class="active">个人中心</li>
	  <li id="commentNameShow" class="active">已发布评语</li>
	</ol>
	
	<div class="comment-form">
	<input type="hidden" value="${comment.commentState}" id="commentState">
		<fieldset>
        	<legend>评语详情</legend>
            <div class="">
				<label class=" ">帖子标题</label>
				<input type="text" class=" form-right" style="float:right;margin-right:100px;width:470px;" value="${comment.postTitle }"  placeholder="帖子标题" disabled="true">
		  	</div>
		  <br>
		   	<div class="">
				<label class=" ">评语内容</label>
				<div style="float:right;width:94%;">${comment.commentContent }</div>
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
	case 1:
		$("#commentNameShow").html("已发布评语");
        break;
	case 2:
		$("#commentNameShow").html("过期评语");
        break;
	}
});


function confirm(){
	var commentState=$("#commentState").val();
	art.dialog(
	        {
	            content:'确定离开？',
	            style:'succeed noClose'
	        },
	        function(){
	        	window.location.href="<%=basePath%>comment/toGetAllComment.do?commentState="+commentState+"&url=page/forehead/mypage/my-comment";
	        },
	        function(){
	            ;
	        }
	);
}



			  
</script>
  
  
  
</html>
