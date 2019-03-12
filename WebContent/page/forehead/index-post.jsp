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
.post{
	height:800px;
}
</style>
<body>
<%@ include file="/page/common/user-include.jsp"%>
<div id ="main">
	<div id="index_all">
		<%@ include file="/page/common/head-include.jsp"%>
		<!--网站主体部分开始-->
		<div id="index_body">
			<!--论坛开始-->
			<div class="post">
				<!--头部开始-->
				<div >
					<img src="images/post.png" style="width: 20px;" /> <span>网站论坛</span>
				</div>
				<!--头部结束-->
				<!--论坛展示-->
				<div id="postBody">
						<ul class="nav nav-tabs" role="tablist">
							<li role="presentation" class="active"><a href="#postCommon" onclick="postCommonShow();" role="tab" data-toggle="tab">普通帖子</a></li>
							<li role="presentation"><a href="#postWellChosen" role="tab" onclick="postWellChosenShow();" data-toggle="tab">精品帖子</a></li>
						</ul>
						<div class="tab-content">
							<div role="tabpanel" class="tab-pane active" id="postCommon">
								<%-- <div class="postOne">
									<div class="post_one_Title">
										<span style="font-size:12px;">用户名用户名</span>
										<a href="#" style="margin-left:10px;opacity:0.5;" >帖子标题帖子标题帖子标题帖子标题帖子标题帖子标题帖子标题帖子标题帖子标题</a>
										<span style="float:right;">2017-12-22 19:32:20</span><span style="float:right;margin-right:10px;">点击:<span class="color-red">0</span></span>
									</div>
									<div class="post_one_content" style="height:57px;width:100%;">
										<div class="content_one" style="margin:5px 40px 3px;width:610px;float:left;font-size:16px;opacity:0.3;" onClick='window.location.href="#"'>
										帖子内容值得一说的是当时我还是比较幸运的去的时候我是下了很大决心的因为这钢琴一体机要两万多为这事我还跟老婆闹了个不愉快不过到了商场之后才婆闹了个不愉快不
										</div>
										<div class="pic_one" style="float:right;"><a href="#"><img style="width:100px;height:55px;margin-right:10px;" src="<%=basePath%>/images/index.jpg"></a></div>
									</div>
								</div> --%>
							</div>
							<div role="tabpanel" class="tab-pane" id="postWellChosen"></div>
						</div>
				</div>
				<!--论坛展示结束-->
				
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
			<!--论坛结束-->
		</div>
		<!--网站主体部分结束-->
	</div>


</div>
</body>

<script>

$(function(){
 	postCommonShow(); 
});

function postCommonShow(){
	var postKindId = "postCommon";
	var action ="doGetAllPostCommon.do";
	postShow(action,postKindId);
}

function postWellChosenShow(){
	var postKindId = "postWellChosen";
	var action ="doGetAllPostWellChosen.do";
	postShow(action,postKindId);
}


function postShow(action,postKindId){
	var pageSize = 8;
	var userNo = $("#userNo").val();
	$.ajax({
		type:"post",
		url:"<%=basePath%>post/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize, 
		dataType:"json",
		success:function(data){
			$("#"+postKindId).html("");
			var str = "<br>";
			var strTop ="";
			var strNoTop ="";
			$(data.data).each(function(i,post){
				if(post.postState == 4){
					strTop += setStr(post);
				}
				if(post.postState != 4){
					strNoTop += setStr(post);
				}
				/* str += "<div class='postOne'><div class='post_one_Title'><span style='font-size:12px;'>" + getUserName(post.userNo) + "</span>" +
						"<a style='margin-left:10px;opacity:0.5;' href='" + basePath + "post/findPostIndexByPostNo.do?postNo=" + post.postNo + "'>"; 
				var postTitle = post.postTitle;
				if(postTitle.length > 33){
					postTitle = postTitle.substring(0,33) + "...";
				}
				str += postTitle + "</a><span style='float:right;'>" + moment(post.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "</span><span style='float:right;margin-right:10px;'>点击：&nbsp;" +
						"<span class='color-red'>" + post.postScanNum +"</span></span></div><div class='post_one_content' style='height:57px;width:100%;'>" +
						"<div class='content_one' style='margin:5px 40px 3px;width:610px;float:left;font-size:16px;opacity:0.3;' onClick='window.location.href=\"" + basePath + 'post/findPostIndexByPostNo.do?postNo=' + post.postNo + "\"'>";
				str += getHtmlContent(post.postContent) + "</div><div class='pic_one' style='float:right;'><a href='" + basePath + "post/findPostIndexByPostNo.do?postNo=" + post.postNo + "'>" +
						"<img style='width:100px;height:55px;margin-right:10px;' src='" + imgPathBefore + post.postPic + "'</a></div></div></div>";  */
			});
			str += strTop + strNoTop;
			$("#"+postKindId).append(str);		 
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
			        url:"<%=basePath%>post/"+action,
			        data:"pageNow="+page+"&pageSize="+pageSize, 
			        dataType:"json",
			        success: function (msg) {
			        	var str1 = "<br>"; 
			        	var strTop1 ="";
						var strNoTop1 ="";
			            $(msg.data).each(function(i,post1){ 
			            	if(post1.postState == 4){
								strTop1 += setStr(post1);
							}
							if(post1.postState != 4){
								strNoTop1 += setStr(post1);
							}
					});
			        $("#"+postKindId).html("");
			        str1 += strTop1 + strNoTop1;
			        $("#"+postKindId).append(str1); 
			     }
			    
			 });
			}
			};
			$('#example').bootstrapPaginator(options);
		}
			      
	});
}

function setStr(post){
	var imgPathBefore = "/upload/post/";
	var str ="";
	str += "<div class='postOne'><div class='post_one_Title'><span style='font-size:12px;'>" + getUserName(post.userNo) + "</span>" +
		"<a style='margin-left:10px;opacity:0.5;' href='" + basePath + "post/findPostIndexByPostNo.do?postNo=" + post.postNo + "'";
	if(post.postState == 4){
		str += " class='color-red'";
	}
	var postTitle = post.postTitle;
	if(postTitle.length > 33){
		postTitle = postTitle.substring(0,33) + "...";
	}
	str += ">" + postTitle + "</a><span style='float:right;'>" + moment(post.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "</span><span style='float:right;margin-right:10px;'>点击：&nbsp;" +
		"<span class='color-red'>" + post.postScanNum +"</span></span></div><div class='post_one_content' style='height:57px;width:100%;'>" +
		"<div class='content_one' style='margin:5px 40px 3px;width:610px;float:left;font-size:16px;opacity:0.3;' onClick='window.location.href=\"" + basePath + 'post/findPostIndexByPostNo.do?postNo=' + post.postNo + "\"'>";
	str += getHtmlContent(post.postContent) + "</div><div class='pic_one' style='float:right;'><a href='" + basePath + "post/findPostIndexByPostNo.do?postNo=" + post.postNo + "'>" +
		"<img style='width:100px;height:55px;margin-right:10px;' src='" + imgPathBefore + post.postPic + "'</a></div></div></div>"; 
	return str;
}

function getUserName(userNo){
	var userName ="";
	$.ajax({
		type : "post",
		async: false,
		url  : basePath + "user/getUserName.do",
		data : "userNo="+userNo, 
		success : function(data) {
			userName = data;
		}
	});
	return userName;
}

function getHtmlContent(content){
	var chtml = removeHTMLTag(content);
	var htmlContent ="";
	var htmlContentLength = chtml.split('。')[0].length;
	if(htmlContentLength < 1){
		htmlContentLength = chtml.split('：')[0].length;
	}
	if(htmlContentLength < 1){
		htmlContentLength = chtml.split('；')[0].length;
	}
	if(htmlContentLength < 1){
		htmlContentLength = chtml.split('.')[0].length;
	}
	if(htmlContentLength < 1){
		htmlContentLength = chtml.split(':')[0].length;
	}
	
	if(htmlContentLength < 10){
		htmlContent = chtml.substr(5,72);
	}
	if(htmlContentLength > 10){
		htmlContent = chtml.substr(htmlContentLength+1,72)+"...";
	}
	return htmlContent;
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
