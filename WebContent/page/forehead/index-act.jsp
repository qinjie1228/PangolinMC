<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ include file="/page/common/index-include.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>穿山甲登山俱乐部</title>
</head>
<style>
.act{
	height:850px;
}
.act-one{
	font-size:15px;
	height:27px;
}
</style>
<body>
<%@ include file="/page/common/user-include.jsp"%>
<div id ="main">
	<div id="index_all">
		<%@ include file="/page/common/head-include.jsp"%>
		<!--网站主体部分开始-->
		<div id="index_body">
			<!--活动开始-->
			<div class="act">
				<!--头部开始-->
				<div >
					<img src="<%=basePath%>images/act.png" style="width: 20px;" /> <span>俱乐部活动</span>
				</div>
				<!--头部结束-->
				<!--活动展示-->
				<div id="actBody">
				</div>
				<!--活动展示结束-->
				
				<ul class="pagination" id="example"> 
		    		<li><a href="#">&laquo;</a></li> 
				    <li class="active"><a href="#">1</a></li> 
				    <li ><a href="#">2</a></li> 
				    <li><a href="#">3</a></li> 
				    <li><a href="#">4</a></li> 
				    <li><a href="#">5</a></li> 
				    <li><a href="#">&raquo;</a></li> 
			    </ul>
				
			</div>
			<!--活动结束-->
		</div>
		<!--网站主体部分结束-->
	</div>

</div>
</body>

<script>

$(function(){
	loadAct();
});

function loadAct(){
	var pageSize = 9;
	var actState = 2;
	var action ="doGetAllAct.do";
	var userNo = $("#userNo").val();
	var imgPathBefore = "/upload/act/";
	$.ajax({
		type:"post",
		url:"<%=basePath%>act/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&actState="+actState, 
		dataType:"json",
		success:function(data){
			$("#actBody").html("");
			var str = "<br>";  
			$(data.data).each(function(i,act){ 
				str += "<div class='actone'><div class='actone_pic'><a href='" + basePath + "act/findActIndexByActNo.do?actNo=" + act.actNo + "'><img src='" + imgPathBefore + act.actPic + "' style='width:100%; height:180px;'/></a></div>" +
						"<div style='float:left;' class='actone_title' onClick='window.location.href=\"" + basePath + 'act/findActIndexByActNo.do?actNo=' + act.actNo + "\"'>";
				var actTitle = act.actTitle;
				if(actTitle.length > 10){
					actTitle = actTitle.substring(0,10) + "...";
				}
				str += actTitle + "(<span class='color-red "+act.actNo+"'>" + act.actNum + "</span>)</div> <div style='float:right;' class='actone_do'> " +
						"<input id='"+act.actNo+"' type='button' value='预约' onclick='resAct(\""+act.actNo+"\""+",\""+userNo+"\");' onMouseOver='checkMact(\""+act.actNo+"\""+",\""+userNo+"\");'></div></div>";
			});
			$("#actBody").append(str);		 
			var options = {
				bootstrapMajorVersion: 3, //版本
			    currentPage: data.page, //当前页数
			    totalPages: data.pageCount, //总页数
			    visiblePageLinks:5, //显示的最多分页链接数
			    itemTexts: function (type, page, current) {
				    switch (type) {
					    case "first":
					    return "首页";
					    case "prev":
					    return "上一页";
					    case "next":
					    return "下一页";
					    case "last":
					    return "末页";
					    case "page":
					    return page;
				    }
				},
			    onPageClicked: function (event, originalEvent, type, page) {
			    	$.ajax({
			        type:"post",
			        url:"<%=basePath%>act/"+action,
			        data:"pageNow="+page+"&pageSize="+pageSize+"&actState="+actState, 
			        dataType:"json",
			        success: function (msg) {
			        	var str1 = "<br>"; 
			            $(msg.data).each(function(i,act1){ 
			            	str1 += "<div class='actone'><div class='actone_pic'><a href='" + basePath + "act/findActIndexByActNo.do?actNo=" + act1.actNo + "'><img src='" + imgPathBefore + act1.actPic + "' style='width:100%; height:180px;'/></a></div>" +
									"<div style='float:left;' class='actone_title' onClick='window.location.href=\"" + basePath + 'act/findActIndexByActNo.do?actNo=' + act1.actNo + "\"'>";
						var actTitle1 = act1.actTitle;
						if(actTitle1.length > 10){
							actTitle1 = actTitle1.substring(0,10) + "...";
						}
						str1 += actTitle1 + "(<span class='color-red "+act1.actNo+"'>" + act1.actNum + "</span>)</div> <div style='float:right;' class='actone_do'> " +
								"<input id='"+act1.actNo+"' type='button' value='预约' onclick='resAct(\""+act1.actNo+"\""+",\""+userNo+"\");' onMouseOver='checkMact(\""+act1.actNo+"\""+",\""+userNo+"\");'></div></div>";
					});
			        $("#actBody").html("");
			        $("#actBody").append(str1); 
			     }
			    
			 });
			}
			};
			$('#example').bootstrapPaginator(options);
		}
			      
	});
}

window.onload=function(){ 
	//自适当前应屏幕分辨率
	var windowHeight = window.screen.height;
	var windowWidth = window.screen.width;
	var main = document.getElementById("main"); 
	main.style.height = windowHeight*0.9 + "px";
	main.style.width = windowWidth*0.9 + "px";
}; 
</script>

</html>
