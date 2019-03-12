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
.tool{
	min-height:800px;
}
.the-tool{
margin:30px 50px 0px 50px;
}
.tool-left{
float:left;
}
.tool-right{
float:left;
margin-left:10px;
width:400px;
}
.tool-name{
text-align:center;
width:280px;
}
</style>
<body>
<%@ include file="/page/common/user-include.jsp"%>
<div id ="main">
	<div id="index_all">
		<%@ include file="/page/common/head-include.jsp"%>
		<!--网站主体部分开始-->
		<div id="index_body">
			<div class="tool">
				<ol class="breadcrumb">
				  <li class="active"><a href="<%=basePath%>index/toIndexTool.do">道具</a></li>
				  <li class="active">道具详情</li>
				</ol>
				<br>
				<div class="the-tool">
					<div class="tool-left">
						<div class="tool-pic"><img src="/upload/tool/${tool.toolPic }" style="width:300px;height:250px;"></div>
						<div class="tool-name">${tool.toolName}</div>
						<br>
						<div style="width:300px; height:30px;">
							<div class="tool-price" style="margin-left:5px;">
								<span>￥${tool.toolPrice}</span>
								<span style="margin-left:140px;">库存：${tool.toolNum}</span>
							</div>
						</div>
					</div>
					<div class="tool-right" id="toolDes">${tool.toolDes }</div>
				</div>
				<br><br><br>
			</div>
		</div>
		<!--网站主体部分结束-->
	</div>


</div>
</body>
<script type="text/javascript">
changeContentImgSize('toolDes');
</script>
</html>
