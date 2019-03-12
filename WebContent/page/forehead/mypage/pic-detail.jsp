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
    <title>照片修改</title>

</head>
<body>   
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">前台</li>
	  <li class="active">个人中心</li>
	  <li id="picNameShow" class="active">普通照片</li>
	</ol>
	
	<form class="form-inline" action="<%=basePath%>pic/doAlterPic.do?url=index" method="post" enctype="multipart/form-data">
	<input type="hidden" value="${pic.picState}" id="picState" name="picState">
	<input type="hidden" value="${pic.picNo}" name="picNo">
	<input type="hidden" value="${currentUser.currentNo}" name="userNo">
		<fieldset>
        	<legend>照片详情</legend>
        	<div class="form-group">
			 </div>
		  	<div class="">
				<label class=" ">照片</label>
				 <input type="file" id="picAlertUp" name="file" style="float:right;margin-right:100px;width:470px; "/>
				 <div style="margin-left:100px;"><img id="picAlertPath" src="/upload/pic/${pic.picPath }" width="150" height="120" /></div> 
				 <input type="hidden" name="picPath" id="kpicPath"/>
		  	</div><br><br>
		  	
		   	<div class="">
				<label class=" ">照片描述</label>
				<input type="text" class=" form-right" style="float:right;margin-right:100px;width:470px;" value="${pic.picDes }"  placeholder="照片描述" name="picDes" id="picDes">
				<br><br>
				<button id="leave" type="button" style="float:right;margin-right:50px;" class="btn btn-default" onclick="cancelPicAlterTo();">取消</button> 
				<button type="submit" style="float:right;margin-right:10px;" class="btn btn-primary" onclick="return valueToAlertInput();">确认修改</button>
		  	</div>
		
		</fieldset>
		
	</form>	
</div>
</body>
  
  
 <script type="text/javascript">
$(document).ready(function(){
	$('.date_picker').date_input();
	$("#picAlertUp").uploadPreview({ Img: "picAlertPath", Width: 150, Height: 120 });

	var postState=$("#postState").val();
	switch(Number(postState)){
	case 1:
		$("#picNameShow").html("普通照片");
        break;
	case 2:
		$("#picNameShow").html("我喜欢的照片");
        break;
	case 3:
		$("#picNameShow").html("待审核精品照片");
        break;
	case 4:
		$("#picNameShow").html("精品照片");
        break;
	}
	
});

function valueToAlertInput(){
	if($("#picAlertUp").val()==null||$("#picAlertUp").val()==""){
		$("#kpicPath").val("fail");
	}else{
		$("#kpicPath").val("success");
	}
	return true;
}

function cancelPicAlterTo(){
	var picState=$("#picState").val();
	art.dialog(
	        {
	            content:'确定离开？',
	            style:'succeed noClose'
	        },
	        function(){
	        	window.location.href="<%=basePath%>pic/toGetAllPic.do?picState="+picState+"&url=page/forehead/mypage/my-pic";
	        },
	        function(){
	            ;
	        }
	);
}



			  
</script>
  
  
  
</html>
