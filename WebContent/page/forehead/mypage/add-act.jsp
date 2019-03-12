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
    <title>活动申请</title>
	<script type="text/javascript" src="<%=basePath%>js/back/actlist-back.js"></script>

</head>
<body>   
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">前台</li>
	  <li class="active">个人中心</li>
	  <li id="actNameShow" class="active">待审核活动</li>
	</ol>
	
	

	
	<form class="form-inline" action="<%=basePath%>act/actApply.do" method="post" enctype="multipart/form-data">
	<input type="hidden" value="${currentUser.currentNo}" name="userNo">
		<fieldset>
        	<legend>添加活动</legend>
            <div class="">
				<label class=" ">活动标题</label>
				<input type="text" class=" form-right" style="float:right;margin-right:100px;width:470px;" placeholder="活动标题" name="actTitle" id="actTitle">
		  	</div>
		  <br>
		  	<div class="">
				<label class=" ">活动图片</label>
				 <input type="file" id="addActUp" name="file" style="float:right;margin-right:100px;width:470px; "/>
				 <div style="margin-left:82px;"><img id="addActPic" width="150" height="120" /></div> 
		  	</div>
		  
		   	<div class="">
				<label class=" ">活动内容</label>
				<div style="float:right;width:94%;"><div id="add-editor"></div></div>
				<button id="leave" type="button" style="float:right;margin-right:50px;" class="btn btn-default" onclick="cancelActApplyTo();">取消</button> 
				<button type="submit" style="float:right;margin-right:10px;" class="btn btn-primary" onclick="return valueToAddInput();">确认添加</button>
	 	 		<input type="hidden" name="actContent" id="addActContent"/>  
		  	</div>
		
		</fieldset>
		
	</form>	
</div>
</body>
  
  
 <script type="text/javascript">
$(document).ready(function(){
	$('.date_picker').date_input();
	$("#addActUp").uploadPreview({ Img: "addActPic", Width: 150, Height: 120 });
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
	$("#addActContent").val($("#add-editor").html());
	
	if($("#actTitle").val() == null || $("#actTitle").val() ==""){
		art.dialog({
			follow: document.getElementById('actTitle'),
			content: '标题不能为空！'
		});
		$("#actTitle").focus();
		return false; 
	}
	
	if(forMatTitle.test($("#actTitle").val()) != true){
		art.dialog({
			follow: document.getElementById('actTitle'),
			content: '标题格式不正确！'
		});
		$("#actTitle").focus();
		return false;
	}
	
	if($("#addActUp").val()==null||$("#addActUp").val()==""){
		art.dialog({
			follow: document.getElementById('addActUp'),
			content: '请上活动图片！'
		});
		$("#addActUp").focus();
		return false; 
	}else{
		return true;
	}
	
}
	
function cancelActApplyTo(){
	
	art.dialog(
	        {
	            content:'确定离开？',
	            style:'succeed noClose'
	        },
	        function(){
	        	window.location.href="<%=basePath%>act/toGetAllAct.do?actState=1&url=page/forehead/mypage/my-act";
	        },
	        function(){
	            ;
	        }
	);
}
</script>
  
  
  
</html>
