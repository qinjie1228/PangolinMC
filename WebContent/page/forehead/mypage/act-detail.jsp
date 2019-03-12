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
    <title>活动修改</title>
	<script type="text/javascript" src="<%=basePath%>js/back/actlist-back.js"></script>

</head>
<body>   
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">前台</li>
	  <li class="active">个人中心</li>
	  <li id="actNameShow" class="active">已发布活动</li>
	</ol>
	
	

	
	<form class="form-inline" action="<%=basePath%>act/doAlterAct.do?url=index" method="post" enctype="multipart/form-data">
	<input type="hidden" value="${act.actState}" id="actState" name="actState">
	<input type="hidden" value="${act.actNo}" name="actNo">
	<input type="hidden" value="${currentUser.currentNo}" name="userNo">
		<fieldset>
        	<legend>活动详情</legend>
            <div class="">
				<label class=" ">活动标题</label>
				<input type="text" class=" form-right" style="float:right;margin-right:100px;width:470px;" value="${act.actTitle }"  placeholder="活动标题" name="actTitle" id="actTitle">
		  	</div>
		  <br>
		  	<div class="">
				<label class=" ">活动图片</label>
				 <input type="file" id="actAlertUp" name="file" style="float:right;margin-right:100px;width:470px; "/>
				 <div style="margin-left:82px;"><img id="actAlertPic" src="/upload/act/${act.actPic }" width="150" height="120" /></div> 
				 <input type="hidden" name="actPic" id="kactPic"/>
		  	</div>
		  
		   	<div class="">
				<label class=" ">活动内容</label>
				<div style="float:right;width:94%;"><div id="simple-editor">${act.actContent }</div></div>
				<input type="hidden" name="actContent" id="aactContent"/>
				<button id="leave" type="button" style="float:right;margin-right:50px;" class="btn btn-default" onclick="cancelActAlertTo();">取消</button> 
				<button type="submit" style="float:right;margin-right:10px;" class="btn btn-primary" onclick="return valueToAlertInput();">确认修改</button>
	 	 		<input type="hidden" name="actContent" id="addActContent"/>  
		  	</div>
		
		</fieldset>
		
	</form>	
</div>
</body>
  
  
 <script type="text/javascript">
$(document).ready(function(){
	$('.date_picker').date_input();
	$("#actAlertUp").uploadPreview({ Img: "actAlertPic", Width: 150, Height: 120 });
	
});

$('#simple-editor').trumbowyg();
$.trumbowyg.btnsGrps.test = ['bold', 'link'];
$.extend(true, $.trumbowyg.langs, {
    fr: {
        align: 'Alignement',
        image: 'Image'
    }
});



function valueToAlertInput(){
	$("#aactContent").val($("#simple-editor").html());
	if($("#actAlertUp").val()==null||$("#actAlertUp").val()==""){
		$("#kactPic").val("fail");
	}else{
		$("#kactPic").val("success");
	}
	return true;
}

function cancelActAlertTo(){
	
	art.dialog(
	        {
	            content:'确定离开？',
	            style:'succeed noClose'
	        },
	        function(){
	        	window.location.href="<%=basePath%>act/toGetAllAct.do?actState=2&url=page/forehead/mypage/my-act";
	        },
	        function(){
	            ;
	        }
	);
}



			  
</script>
  
  
  
</html>
