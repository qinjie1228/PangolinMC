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
.notice{
	height:700px;
}
.notice-one{
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
			<!--公告开始-->
			<div class="notice">
				<!--头部开始-->
				<div >
					<img src="<%=basePath%>images/notice.png" style="width: 20px;" /> <span>网站公告</span>
				</div>
				<!--头部结束-->
				<!--公告展示-->
				<div id="noticeBody">
<!-- 					<div class='notice-one'>
						<a style='color: black;' href='#'>公告标题公告标题公告标题公告标题公告标题公告标题公告标题公告标题公告标题公告标题公告标题</a>
						<span style='float: right;'>2017-12-20 12:20:20</span>
					</div>
					<div class='notice-one'>
						<a style='color: black;' href='#'>公告标题</a>
						<span style='float: right;'>2017-12-20 12:20:20</span>
					</div> -->
				</div>
				<!--公告展示结束-->
				
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
			<!--公告结束-->
		</div>
		<!--网站主体部分结束-->
	</div>

</div>
</body>

<script>

$(function(){
	loadNotice();
});

function loadNotice(){
	var pageSize = 20;
	var noticeState = 1;
	var action ="doGetAllNotice.do";
	$.ajax({
		type:"post",
		url:"<%=basePath%>notice/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&noticeState="+noticeState, 
		dataType:"json",
		success:function(data){
			$("#noticeBody").html("");
			 var str = "<br>";  
			 $(data.data).each(function(i,notice){ 
				 var noticeTitle = notice.noticeTitle;
				 if(noticeTitle.length > 40){
					 noticeTitle = noticeTitle.substring(0,40) + "...";
				 }
				 str += "<div class='notice-one'><a style='color: black;' href='" + basePath + "notice/findNoticeIndexByNoticeNo.do?noticeNo=" + notice.noticeNo + "'>" +
				 		noticeTitle + "</a> <span style='float: right;'>" + moment(notice.noticePubTime).format('YYYY-MM-DD HH:mm:ss') + "</span></div>";
	        });
			 $("#noticeBody").append(str);		 
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
			            	url:"<%=basePath%>notice/"+action,
			          		data:"pageNow="+page+"&pageSize="+pageSize+"&actState="+actState, 
			          		dataType:"json",
			                success: function (msg) {
			                	var str1 = "<br>"; 
			                	  $(msg.data).each(function(i,notice1){ 
			                		  	var noticeTitle1 = notice1.noticeTitle;
			         				 	if(noticeTitle1.length > 40){
			         				 		noticeTitle1 = noticeTitle1.substring(0,40) + "...";
			         				 	}
			                			str1 += "<div class='notice-one'><a style='color: black;' href='" + basePath + "notice/findNoticeIndexByNoticeNo.do?noticeNo=" + notice1.noticeNo + "'>" +
			                					noticeTitle1 + "</a> <span style='float: right;'>" + moment(notice1.noticePubTime).format('YYYY-MM-DD HH:mm:ss') + "</span></div>";
			                    });
			                	  $("#noticeBody").html("");
			                	  $("#noticeBody").append(str1); 
			                	 
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
