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

<body>
<%@ include file="/page/common/user-include.jsp"%>
<div id ="main">
	<div id="index_all">
		<%@ include file="/page/common/head-include.jsp"%>
		<!--网站主体部分开始-->
		<div id="index_body">
			
			<div style="height:800px;">
			<div class="title" style="margin: 0px; padding: 10px 0px; clear: both; line-height: 25px; font-size: 14px; color: rgb(0, 0, 0); text-align: center; font-family: 宋体; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px;">关于我们(www.plmc.com)</div><div class="desc" style="margin: 0px; padding: 0px 20px; clear: both; height: 25px; line-height: 25px; color: rgb(102, 102, 102); font-family: 宋体; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background: rgb(245, 245, 245);"><h5 style="margin: 0px; padding: 0px; font-size: 12px; font-weight: normal; float: left;">穿山甲登山俱乐部</h5><h6 style="margin: 0px; padding: 0px; font-size: 12px; font-weight: normal; float: right;"><strong>plmc.com</strong></h6></div><div class="content" style="margin: 0px; padding: 20px; clear: both; line-height: 25px; color: rgb(51, 51, 51); font-family: 宋体; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px;">&nbsp;&nbsp;&nbsp; 穿山甲登山俱乐部网站(www.plmc.com)作为领先的行业门户网站，为广大企业和职业人士架起信息沟通的桥梁，协助企业实施品牌战略，帮助企业了解行情，促销产品，把握商机，开拓市场，从而为生产厂家、商家与市场流通之间建立经济、快捷、准确、丰富的专业信息服务及电子商务服务。<br><br>&nbsp;&nbsp;&nbsp;&nbsp;自网站建立以来，穿山甲登山俱乐部网站就以“不断创新、优质服务”为宗旨，开辟了供求信息，产品信息，企业目录，商业资讯等多个栏目，以深刻、全面、新颖的思想指导、分析行业与市场的发展，为企业创造更多的合作商机。每天，都有数以万计的客户，通过我们的平台寻找到可信赖的合作伙伴和贸易伙伴，实现合作共赢，共同发展.<br><br>&nbsp;&nbsp;&nbsp; 穿山甲登山俱乐部网站本着“以客户为中心”的服务方针，致力于深入了解市场、关注客户需求，着力于打造最全面、最快捷、最新颖的信息化服务。禀承“持续解读客户需求，不断提升服务价值”的服务方向，将不断提升企业核心竞争力、不断整合自身及行业资源、不断突破观念完善策略，为打造一流的行业门户而努力。<br><br>&nbsp;&nbsp;&nbsp;&nbsp;我们的目标：成为互联网上最优秀、最权威的登山用品行业平台；<br>&nbsp;&nbsp;&nbsp;&nbsp;我们的理念：以最大的热情与真诚，全力以赴，让我们的平台推动企业与个人走向成功。</div>
			</div>
			
			
		</div>
		<!--网站主体部分结束-->
	</div>


</div>
</body>
</html>
