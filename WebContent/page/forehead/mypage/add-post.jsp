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
    <title>添加帖子</title>

</head>
<body>   
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">前台</li>
	  <li class="active">个人中心</li>
	  <li class="active">添加帖子</li>
	</ol>

	
	<form class="form-inline" action="<%=basePath%>post/addPost.do?url=index" method="post" enctype="multipart/form-data">
	<input type="hidden" value="${currentUser.currentNo}" name="userNo">
	<input type="hidden" value="0" name="postScanNum">
	<input type="hidden" value="0" name="postCommentNum">
	<input type="hidden" value="1" name="postState">
		<fieldset>
        	<legend>添加帖子</legend>
        	<div class="form-group">
			 <label>帖子类别</label>
				<select type="select" style="float:right;margin-right:100px;width:470px;" id="postCategory" name="postCategory">
					<option value="主题帖"  selected>主题帖</option>
					<option value="交友贴">交友贴</option>
					<option value="投诉建议贴">投诉建议贴</option>
				</select>
			 </div>
        	
            <div class="">
				<label>帖子标题</label>
				<input type="text" class="form-right" style="float:right;margin-right:100px;width:470px;" placeholder="帖子标题" name="postTitle" id="postTitle">
		  	</div>
		  <br>
		  	<div class="">
				<label class=" ">帖子图片</label>
				 <input type="file" id="addPostUp" name="file" style="float:right;margin-right:100px;width:470px; "/>
				 <div style="margin-left:82px;"><img id="addPostPic" width="150" height="120" /></div> 
		  	</div>
		  	
		   	<div class=""><br>
				<label class=" ">帖子内容</label>
				<div style="float:right;width:94%;"><div id="add-editor"></div></div>
				<button id="leave" type="button" style="float:right;margin-right:50px;" class="btn btn-default" onclick="cancelPostAddTo();">取消</button> 
				<button type="submit" style="float:right;margin-right:10px;" class="btn btn-primary" onclick="return valueToAddInput();">确认添加</button>
	 	 		<input type="hidden" name="postContent" id="addPostContent"/>  
		  	</div>
		
		</fieldset>
		
	</form>	
</div>
</body>
  
  
 <script type="text/javascript">
$(document).ready(function(){
	$('.date_picker').date_input();
	$("#addPostUp").uploadPreview({ Img: "addPostPic", Width: 150, Height: 120 });
});

$('#add-editor').trumbowyg();
$.trumbowyg.btnsGrps.test = ['bold', 'link'];
$.extend(true, $.trumbowyg.langs, {
    fr: {
        align: 'Alignement',
        image: 'Image'
    }
});



function valueToAddInput(){
	$("#addPostContent").val($("#add-editor").html());
	
	if($("#postTitle").val() == null || $("#postTitle").val() ==""){
		art.dialog({
			follow: document.getElementById('postTitle'),
			content: '标题不能为空！'
		});
		$("#postTitle").focus();
		return false; 
	}
	
	if(forMatTitle.test($("#postTitle").val()) != true){
		art.dialog({
			follow: document.getElementById('postTitle'),
			content: '标题格式不正确！'
		});
		$("#postTitle").focus();
		return false;
	}
	
	if($("#addPostUp").val()==null||$("#addPostUp").val()==""){
		art.dialog({
			follow: document.getElementById('addPostUp'),
			content: '请上帖子图片！'
		});
		$("#addPostUp").focus();
		return false; 
	}else{
		return true;
	}
	
}


function cancelPostAddTo(){
	
	art.dialog(
	        {
	            content:'确定离开？',
	            style:'succeed noClose'
	        },
	        function(){
	        	window.location.href="<%=basePath%>act/toGetAllPost.do?postState=1&url=page/forehead/mypage/my-post";
	        },
	        function(){
	            ;
	        }
	);
}
		  
</script>
  
  
  
</html>
