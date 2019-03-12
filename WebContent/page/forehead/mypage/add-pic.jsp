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
    <title>上传照片</title>

</head>
<body>   
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">前台</li>
	  <li class="active">个人中心</li>
	  <li class="active">普通照片</li>
	</ol>
	
	<form class="form-inline" action="<%=basePath%>pic/addPic.do?url=index" method="post" enctype="multipart/form-data">
	<input type="hidden" value="${currentUser.currentNo}" name="userNo">
	<input type="hidden" value="1" name="picState">
		<fieldset>
        	<legend>上传照片</legend>
        	<div class="form-group">
			 </div>
		  	<div class="">
				<label class=" ">照片</label>
				 <input type="file" id="addPicUp" name="file" style="float:right;margin-right:100px;width:470px; "/>
				 <div style="margin-left:100px;"><img id="addPicPic" width="150" height="120" /></div> 
		  	</div><br><br>
		  	
		   	<div class="">
				<label class=" ">照片描述</label>
				<input type="text" class=" form-right" style="float:right;margin-right:100px;width:470px;" placeholder="照片描述" name="picDes" id="picDes">
				<br><br>
				<button id="leave" type="button" style="float:right;margin-right:50px;" class="btn btn-default" onclick="cancelPicAlterTo();">取消</button> 
				<button type="submit" style="float:right;margin-right:10px;" class="btn btn-primary" onclick="return valueToAlertInput();">立即上传</button>
		  	</div>
		
		</fieldset>
		
	</form>	
</div>
</body>
  
  
 <script type="text/javascript">
$(document).ready(function(){
	$("#addPicUp").uploadPreview({ Img: "addPicPic", Width: 120, Height: 120 });
});

function valueToAddInput(){
	if($("#addPicUp").val()==null||$("#addPicUp").val()==""){
		alert("请上活动图片！");
		return false; 
	}else{
		return true;
	}
}

function cancelPicAddTo(){
	var picState=$("#picState").val();
	art.dialog(
	        {
	            content:'确定离开？',
	            style:'succeed noClose'
	        },
	        function(){
	        	window.location.href="<%=basePath%>pic/toGetAllPic.do?picState=1&url=page/forehead/mypage/my-pic";
	        },
	        function(){
	            ;
	        }
	);
}



			  
</script>
  
  
  
</html>
