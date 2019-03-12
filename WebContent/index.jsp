<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@include file="page/common/index-include.jsp" %> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>穿山甲登山俱乐部</title>
<script type="text/javascript" src="<%=basePath%>js/fore/index.js"></script>
</head>

<body>
<%@include file="page/common/user-include.jsp" %>
<div id ="main">
	<div id="index_all">
		<%@include file="page/common/head-include.jsp" %>
		<!--网站主体部分开始-->
		<div id="index_body">
			<!--图片轮播和公告展示部分开始-->
			<div id="pic_notice">

				<!--图片轮播左边-->
				<div id="picUp">

					<div id="myCarousel" class="carousel slide">
						<!-- 轮播（Carousel）指标 -->
						<ol class="carousel-indicators">
							<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
							<li data-target="#myCarousel" data-slide-to="1"></li>
							<li data-target="#myCarousel" data-slide-to="2"></li>
						</ol>
						<!-- 轮播（Carousel）项目 -->
						<div class="carousel-inner">
							<div class="item active">
								<!-- <img id="carouselImgOne"> -->
								<img id="carouselImgOne">
							</div>
							<div class="item">
								<img id="carouselImgTwo">
							</div>
							<div class="item">
								<img id="carouselImgThree">
							</div>
						</div>
						<!-- 轮播（Carousel）导航 -->
						<a class="carousel-control left" href="#myCarousel"
							data-slide="prev">&lsaquo; </a> <a class="carousel-control right"
							href="#myCarousel" data-slide="next">&rsaquo; </a>
					</div>

				</div>
				<!--图片轮播左边结束-->
				<!--公告右边-->
				<div id="noticeUp">
					<!--公告标题-->
					<div id="noticeUp_title">
						<img src="<%=basePath%>images/notice.png" style="width: 20px;" /> <span>最新公告</span>
					</div>
					<!--公告标题-->
					<!--公告展示-->
					<div id="noticeUp_notices">
					</div>
					<!--公告展示结束-->
				</div>
				<!--公告右边结束-->
			</div>
			<!--图片轮播和公告展示部分结束-->

			<!--活动部分开始-->
			<div id="index_act">
				<div id="act_title">
					<img src="<%=basePath%>images/act.png" style="width: 20px;" /> <span>俱乐部活动预约</span>
				</div><br>
				<div id="act_content">
<%-- 					<div class="actone">
						<div class="actone_pic">
							<img src="/upload/example/actscoll_one.jpg" style="width: 100%;" />
						</div>
						<div style="float:left;" class="actone_title">最新登山活动登山活动...(220)</div>
						<div style="float:right;" class="actone_do">
							<input type="button" value="预约" onclick="resAct(${currentUser.currentNo})">
						</div>
					</div> --%>
					
					

				</div>
			</div>
			<br>
			<!--活动部分结束-->
			<!--道具部分开始-->

			<div id="index_tool">
				<div id="tool_title">
					<img src="<%=basePath%>images/toolbuy.png" style="width: 20px;" /> <span>登山道具推荐</span>
				</div>
				<div id="tool_content">
 <%--  					<div class="toolone">
						<div class="toolone_pic">
							<img src="/upload/tool/20160921224424.jpg" style='width:100%; height:180px;' />
						</div>
						<div class="toolone_desc">
							<p>
								韩版登山服登山服服服服登山涉水所所所所韩版登山服登山服服服服登山涉水
							</p>
						</div>
						<div class="toolone_do">
							<div style="float:left;" class="tool_price"><img src="images/toolprice.png" style="width: 15px;" /><span class="price color-red">50</span></div> 
							<input style="float:right;" type="button" value="添加购物车" onclick="addToolToOrder(${currentUser.currentNo})">
							
							<input style="margin-left:65px;" class="min" type="button" value="-" /> 
							<input class="text_box color-red" type="text" value="1" style="width:24px;font-size:10px;"/> 
							<input class="add" type="button" value="+" /> 
						</div>
					</div>  --%>

				</div>
				<div class="chosePrice">
					<p> 
						<label style="width:200px;">当页已选商品价格：<label id="total"></label></label>
						<span style="margin-left:330px;">购物车总价：<label id="totalAll"></label></span>   
						<input id="indexPay" style="margin-left:90px;" type="button" value="去结算" onclick='toPayOrderDo2("indexPay");'>   
					</p>
				</div>
			</div><br> 
			
			<!--道具部分结束-->
			<!--论坛部分开始-->

			<div id="index_post">
				<div id="post_title">
					<img src="<%=basePath%>images/post.png" style="width: 20px;" /> <span>网站论坛</span>
				</div>
				<div id="post_cat"></div>
				<div id="post_content">
						<!-- Nav tabs -->
						<ul class="nav nav-tabs" role="tablist">
							<li role="presentation" class="active"><a href="#postNew" onclick="postShow();" role="tab" data-toggle="tab">最新帖子</a></li>
							<li role="presentation"><a href="#postWell" role="tab" onclick="postWellShow();" data-toggle="tab">精品帖子</a></li>
							<li role="presentation"><a href="#postHot" role="tab" onclick="postHotShow();" data-toggle="tab">热门帖子</a></li>
						</ul>

						<!-- Tab panes -->
						<div class="tab-content">
							<div role="tabpanel" class="tab-pane active" id="postNew">
<!-- 								<div class="post-one">
									<a style='color: black;' href='#'>最新帖子最新帖子最新帖子最新帖子最新帖子最新帖子最新帖子最新帖子</a> 
									<span style='float: right;'>
										时间：&nbsp;2017-12-22 12:34:59 &nbsp;&nbsp;&nbsp;点击：&nbsp;<span class="color-red">0</span>&nbsp;&nbsp;&nbsp;
										回复：&nbsp;&nbsp;<span class="color-red">2</span>moment(notice.noticePubTime).format('YYYY-MM-DD HH:mm:ss')
									</span>
								</div> -->
							</div>
							<div role="tabpanel" class="tab-pane" id="postWell"></div>
							<div role="tabpanel" class="tab-pane" id="postHot"></div>
						</div>
				</div>
			</div>


			<!--论坛部分结束-->
			<!--图片部分开始-->

			<div id="index_pic">
 				<div id="pic_title">
					<img src="<%=basePath%>images/picture.png" style="width: 20px;" /> <span>精品图片</span>
				</div><br>
				<div id="pic_content">
					<div class="gallery">
					
					</div>
					<div class="clear"></div>
				</div>
			</div>

			<!--图片部分结束-->
		</div>
		<!--网站主体部分结束-->
	</div>

</div>
</body>
</html>
