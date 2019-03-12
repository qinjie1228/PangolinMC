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



<style type="text/css">
/*left-菜单*/
.left-menu{
    position:absolute;
    float: left;
    min-height: 100%;
    box-shadow: 0 0 10px #BDBDBD;
/*     width: 138px; */
	width: 120px;
}
/*main内容显示*/
.right-content{
    margin-left: 14%;
    height: 100%;
    min-height:100%;
    overflow:auto;
}
.my{
	height:750px;
}



.menu_list{margin:auto;width:120px;}
.menu_head{width:120px;height:47px;line-height:47px;padding-left:24px;font-size:14px;color:#525252;cursor:pointer;border:1px solid #e1e1e1;position:relative;font-weight:bold;background:#f1f1f1 url(images/pro_left.png) center right no-repeat;margin:0;}
.menu_list .current{background:#f1f1f1 url(images/pro_down.png) center right no-repeat;}
.menu_body{width:120px;height:auto;overflow:hidden;line-height:38px;border-left:1px solid #e1e1e1;backguound:#fff;border-right:1px solid #e1e1e1;}
.menu_body a{display:block;width:223px;height:38px;line-height:38px;padding-left:24px;color:#777777;background:#fff;text-decoration:none;border-bottom:1px solid #e1e1e1;}
.menu_body a:hover{text-decoration:none;}

</style>

<body>
<%@ include file="/page/common/user-include.jsp"%>
<div id ="main">
	<div id="index_all">
		<%@ include file="/page/common/head-include.jsp"%>
		<!--网站主体部分开始-->
		<div id="index_body" style="margin:2% 0% 2% 0%;">
		<div class="my">	
			
			<div class="left-menu">
			 <div id="firstpane" class="menu_list">
			    <p class="menu_head current">我的资料</p>
			    <div style="display:block" class=menu_body >
			      <a href="<%=basePath%>index/toMyMain.do" target="menuFrame">资料设置</a>
				</div>
			    <p class="menu_head">我的活动</p>
			    <div style="display:none" class=menu_body >
			      <a href="<%=basePath%>act/toGetAllAct.do?actState=1&url=page/forehead/mypage/my-act" target="menuFrame">待审核</a>
				  <a href="<%=basePath%>act/toGetAllAct.do?actState=3&url=page/forehead/mypage/my-act" target="menuFrame">已否决</a>
				  <a href="<%=basePath%>act/toGetAllAct.do?actState=2&url=page/forehead/mypage/my-act" target="menuFrame">已发布</a>
				</div>
			    <p class="menu_head">预约记录</p>
			    <div style="display:none" class=menu_body >
			      <a href="<%=basePath%>mact/toGetAllMact.do?actResState=1&url=page/forehead/mypage/my-mact" target="menuFrame">待审核</a>
				  <a href="<%=basePath%>mact/toGetAllMact.do?actResState=3&url=page/forehead/mypage/my-mact" target="menuFrame">已否决</a>
				  <a href="<%=basePath%>mact/toGetAllMact.do?actResState=2&url=page/forehead/mypage/my-mact" target="menuFrame">已预约</a>
			    </div>
			    <p class="menu_head">我的订单</p>
			    <div style="display:none" class=menu_body >
			      <a href="<%=basePath%>order/toGetAllOrder.do?orderState=5&url=page/forehead/mypage/my-order" target="menuFrame">购物车</a>
			      <a href="<%=basePath%>order/toGetAllOrder.do?orderState=6&url=page/forehead/mypage/my-order" target="menuFrame">已确认</a>
				  <a href="<%=basePath%>order/toGetAllOrder.do?orderState=1&url=page/forehead/mypage/my-order" target="menuFrame">待审核</a>
				  <a href="<%=basePath%>order/toGetAllOrder.do?orderState=2&url=page/forehead/mypage/my-order" target="menuFrame">已付款</a>
				  <a href="<%=basePath%>order/toGetAllOrder.do?orderState=3&url=page/forehead/mypage/my-order" target="menuFrame">已发货</a>
				  <a href="<%=basePath%>order/toGetAllOrder.do?orderState=4&url=page/forehead/mypage/my-order" target="menuFrame">已过期</a>
			    </div>
			    <p class="menu_head">我的帖子</p>
			    <div style="display:none" class=menu_body >
			      <a href="<%=basePath%>post/toGetAllPost.do?postState=6&url=page/forehead/mypage/my-post" target="menuFrame">待审核</a>
			      <a href="<%=basePath%>post/toGetAllPost.do?postState=1&url=page/forehead/mypage/my-post" target="menuFrame">普通帖</a> 
				  <a href="<%=basePath%>post/toGetAllPost.do?postState=4&url=page/forehead/mypage/my-post" target="menuFrame">置顶帖</a> 
				  <a href="<%=basePath%>post/toGetAllPost.do?postState=2&url=page/forehead/mypage/my-post" target="menuFrame">精品贴</a>
				  <a href="<%=basePath%>post/toGetAllPost.do?postState=5&url=page/forehead/mypage/my-post" target="menuFrame">已否决</a>
			    </div>
			    <p class="menu_head">我的评语</p>
			    <div style="display:none" class=menu_body >
			      <a href="<%=basePath%>comment/toGetAllComment.do?commentState=1&url=page/forehead/mypage/my-comment" target="menuFrame" >已发布</a>
			      <a href="<%=basePath%>comment/toGetAllComment.do?commentState=2&url=page/forehead/mypage/my-comment" target="menuFrame" >已过期</a>
				</div>
				<p class="menu_head">我的照片</p>
			    <div style="display:none" class=menu_body >
			      <a href="<%=basePath%>pic/toGetAllPic.do?picState=3&url=page/forehead/mypage/my-pic" target="menuFrame">待审核</a>
				  <a href="<%=basePath%>pic/toGetAllPic.do?picState=1&url=page/forehead/mypage/my-pic" target="menuFrame">普通照</a>
				  <a href="<%=basePath%>pic/toGetAllPic.do?picState=2&url=page/forehead/mypage/my-pic" target="menuFrame">我喜欢</a>
				  <a href="<%=basePath%>pic/toGetAllPic.do?picState=4&url=page/forehead/mypage/my-pic" target="menuFrame">精品照</a>
				  <a href="<%=basePath%>pic/toGetAllPic.do?picState=5&url=page/forehead/mypage/my-pic" target="menuFrame">已否决</a>
			    </div>
			  </div>
			  
			  <div style="margin-top:50px;width:150px;">
			  
			  </div>
			  
			</div>	
		
			<!--菜单右边的iframe页面-->
		    <div id="right-content" class="right-content">
		        <div class="content">
		            <div id="page_content">
		                <iframe id="menuFrame" name="menuFrame" src="<%=basePath%>index/toMyMain.do" style="overflow:visible;"
		                        allowFullScreen="true" scrolling="yes" frameborder="no" width="100%" height="98%"></iframe>
		            </div>
		        </div>
		    </div>
			
			
		  </div>	
		</div>
		<!--网站主体部分结束-->
	</div>
</div>
</body>
<script>
$(document).ready(function(){
	$("#firstpane .menu_body:eq(0)").show();
	$("#firstpane p.menu_head").click(function(){
		$(this).addClass("current").next("div.menu_body").slideToggle(300).siblings("div.menu_body").slideUp("slow");
		$(this).siblings().removeClass("current");
	});
	$("#secondpane .menu_body:eq(0)").show();
	$("#secondpane p.menu_head").mouseover(function(){
		$(this).addClass("current").next("div.menu_body").slideDown(500).siblings("div.menu_body").slideUp("slow");
		$(this).siblings().removeClass("current");
	});
	
});

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
