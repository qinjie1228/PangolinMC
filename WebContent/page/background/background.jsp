<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma","no-cache"); 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
<title>穿山甲登山俱乐部管理后台</title>

<link href="<%=basePath%>css/pop-up.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=basePath%>css/background.css" type="text/css" media="screen" />

<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/tendina.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
<script type="text/javascript" src="<%=basePath%>js/back/background.js"></script>
</head>

<body>
<div id ="main">
    <!--顶部-->
    <div class="top">
            <div style="float: left"><span style="font-size: 16px;line-height: 45px;padding-left: 20px;color: #fff">穿山甲登山俱乐部管理后台</span></div>

            <div id="ad_setting" class="ad_setting">
                <a class="ad_setting_a" href="javascript:; ">${currentUser.currentName }</a>
                <ul class="dropdown-menu-uu" style="display: none" id="ad_setting_ul">
               		<li class="ad_setting_ul_li"> <a id="alert-click"><i class="icon-cog glyph-icon"></i>修改密码</a> </li>
                    <li class="ad_setting_ul_li"> <a href="<%=basePath%>index.jsp"><i class="icon-signout glyph-icon"></i> <span class="font-bold">进入前台</span> </a> </li>
                    <li class="ad_setting_ul_li"> <a href="<%=basePath%>user/logOff.do"><i class="icon-cog glyph-icon"></i>注销</a> </li>
                </ul>
                <!--<img class="use_xl" src="images/person.png" />--> 
            </div>

    </div>
    <!--顶部结束-->
    <!--菜单-->
    <div class="left-menu">
        <ul id="menu">
		        	
		        	<li class="menu-list">
		               <a style="cursor:pointer" class="firsta"><i  class="glyph-icon xlcd"></i>系统管理<s class="sz"></s></a>
		                <ul>
		                	<li><a href="<%=basePath%>bac/toBacMain.do" target="menuFrame"><i class="glyph-icon icon-chevron-right1"></i>网站管理</a></li>
		                    <li><a href="<%=basePath%>user/toGetAllUser.do?userState=4" onclick="return getAdmin();" target="menuFrame"><i class="glyph-icon icon-chevron-right1"></i>管理员</a></li>
		                </ul>
		            </li>
		        	
		            <li class="menu-list">
		               <a style="cursor:pointer" class="firsta"><i  class="glyph-icon xlcd"></i>会员管理<s class="sz"></s></a>
		                <ul>
		                    <li><a href="<%=basePath%>user/toGetAllUser.do?userState=1" target="menuFrame"><i class="glyph-icon icon-chevron-right1"></i>初级会员</a></li>
		                    <li><a href="<%=basePath%>user/toGetAllUser.do?userState=2" target="menuFrame"><i class="glyph-icon icon-chevron-right1"></i>中级会员</a></li>
		                    <li><a href="<%=basePath%>user/toGetAllUser.do?userState=3" target="menuFrame"><i class="glyph-icon icon-chevron-right1"></i>高级会员</a></li>
		                    <li><a href="<%=basePath%>user/toGetAllUser.do?userState=6" target="menuFrame"><i class="glyph-icon icon-chevron-right1"></i>过期会员</a></li>
		                </ul>
		            </li>
		            
		            <li class="menu-list">
		               <a style="cursor:pointer" class="firsta"><i  class="glyph-icon xlcd"></i>活动管理<s class="sz"></s></a>
		                <ul>
		                    <li><a href="<%=basePath%>act/toGetAllAct.do?actState=1&url=page/background/act-list" target="menuFrame"><i class="glyph-icon icon-chevron-right2"></i>待审核活动</a></li>
		                    <li><a href="<%=basePath%>act/toGetAllAct.do?actState=3&url=page/background/act-list" target="menuFrame"><i class="glyph-icon icon-chevron-right2"></i>已否决活动</a></li>
		                    <li><a href="<%=basePath%>act/toGetAllAct.do?actState=2&url=page/background/act-list" target="menuFrame"><i class="glyph-icon icon-chevron-right2"></i>已发布活动</a></li>
		                    <li><a href="<%=basePath%>act/toGetAllAct.do?actState=4&url=page/background/act-list" target="menuFrame"><i class="glyph-icon icon-chevron-right2"></i>过期活动</a></li>
		                </ul>
		            </li>
		            
		            <li class="menu-list">
		               <a style="cursor:pointer" class="firsta"><i  class="glyph-icon xlcd"></i>活动预约<s class="sz"></s></a>
		                <ul>
		                    <li><a href="<%=basePath%>mact/toGetAllMact.do?actResState=1&url=page/background/mact-list" target="menuFrame"><i class="glyph-icon icon-chevron-right3"></i>待审核预约记录</a></li>
		                    <li><a href="<%=basePath%>mact/toGetAllMact.do?actResState=2&url=page/background/mact-list" target="menuFrame"><i class="glyph-icon icon-chevron-right3"></i>已成功预约记录</a></li>
		                    <li><a href="<%=basePath%>mact/toGetAllMact.do?actResState=3&url=page/background/mact-list" target="menuFrame"><i class="glyph-icon icon-chevron-right3"></i>已否决预约记录</a></li>
		                    <li><a href="<%=basePath%>mact/toGetAllMact.do?actResState=4&url=page/background/mact-list" target="menuFrame"><i class="glyph-icon icon-chevron-right3"></i>过期预约记录</a></li>
		                </ul>
		            </li>
		            
		            <li class="menu-list">
		               <a style="cursor:pointer" class="firsta"><i  class="glyph-icon xlcd"></i>道具管理<s class="sz"></s></a>
		                <ul>
		                    <li><a href="<%=basePath%>tool/toGetAllTool.do?toolState=1" target="menuFrame"><i class="glyph-icon icon-chevron-right4"></i>在售道具</a></li>
		                    <li><a href="<%=basePath%>tool/toGetAllTool.do?toolState=2" target="menuFrame"><i class="glyph-icon icon-chevron-right4"></i>道具回收站</a></li>
		                </ul>
		            </li>
		            
		            <li class="menu-list">
		               <a style="cursor:pointer" class="firsta"><i  class="glyph-icon xlcd"></i>订单管理<s class="sz"></s></a>
		                <ul>
		                    <li><a href="<%=basePath%>order/toGetAllOrder.do?orderState=1&url=page/background/order-list" target="menuFrame"><i class="glyph-icon icon-chevron-right5"></i>待审核订单</a></li>
		                    <li><a href="<%=basePath%>order/toGetAllOrder.do?orderState=2&url=page/background/order-list" target="menuFrame"><i class="glyph-icon icon-chevron-right5"></i>已付款订单</a></li>
		                    <li><a href="<%=basePath%>order/toGetAllOrder.do?orderState=3&url=page/background/order-list" target="menuFrame"><i class="glyph-icon icon-chevron-right5"></i>已发货订单</a></li>
		                    <li><a href="<%=basePath%>order/toGetAllOrder.do?orderState=4&url=page/background/order-list" target="menuFrame"><i class="glyph-icon icon-chevron-right5"></i>失效订单</a></li>
		                </ul>
		            </li>
		            
		            <li class="menu-list">
		               <a style="cursor:pointer" class="firsta"><i  class="glyph-icon xlcd"></i>公告管理<s class="sz"></s></a>
		               <ul>
		                    <li><a href="<%=basePath%>notice/toGetAllNotice.do?noticeState=1" target="menuFrame"><i class="glyph-icon icon-chevron-right6"></i>已发布公告</a></li>
		                    <li><a href="<%=basePath%>notice/toGetAllNotice.do?noticeState=2" target="menuFrame"><i class="glyph-icon icon-chevron-right6"></i>公告回收站</a></li>
		                </ul>
		            </li>
		            
		            <li class="menu-list">
		               <a style="cursor:pointer" class="firsta"><i  class="glyph-icon xlcd"></i>帖子管理<s class="sz"></s></a>
		                <ul>
		                	<li><a href="<%=basePath%>post/toGetAllPost.do?postState=6&url=page/background/post-list" target="menuFrame"><i class="glyph-icon icon-chevron-right7"></i>待审核帖子</a></li>
		               	 	<li><a href="<%=basePath%>post/toGetAllPost.do?postState=1&url=page/background/post-list" target="menuFrame"><i class="glyph-icon icon-chevron-right7"></i>普通帖</a></li>
		                    <li><a href="<%=basePath%>post/toGetAllPost.do?postState=4&url=page/background/post-list" target="menuFrame"><i class="glyph-icon icon-chevron-right7"></i>置顶帖</a></li>
<%-- 		                    <li><a href="<%=basePath%>post/toGetAllPost.do?postState=3" target="menuFrame"><i class="glyph-icon icon-chevron-right7"></i>热门贴</a></li> --%>
		                    <li><a href="<%=basePath%>post/toGetAllPost.do?postState=2&url=page/background/post-list" target="menuFrame"><i class="glyph-icon icon-chevron-right7"></i>精华帖</a></li>
		                    <li><a href="<%=basePath%>post/toGetAllPost.do?postState=5&url=page/background/post-list" target="menuFrame"><i class="glyph-icon icon-chevron-right7"></i>帖子回收站</a></li>
		                </ul>
		            </li>
		            
		            <li class="menu-list">
		               <a style="cursor:pointer" class="firsta"><i  class="glyph-icon xlcd"></i>评语管理<s class="sz"></s></a>
		                <ul>
		                    <li><a href="<%=basePath%>comment/toGetAllComment.do?commentState=1&url=page/background/comment-list" target="menuFrame"><i class="glyph-icon icon-chevron-right8"></i>已发表评语</a></li>
		                    <li><a href="<%=basePath%>comment/toGetAllComment.do?commentState=2&url=page/background/comment-list" target="menuFrame"><i class="glyph-icon icon-chevron-right8"></i>过期评语</a></li>
		                </ul>
		            </li>
		            
		            <li class="menu-list">
		               <a style="cursor:pointer" class="firsta"><i  class="glyph-icon xlcd"></i>照片管理<s class="sz"></s></a>
		                <ul>
		                    <li><a href="<%=basePath%>pic/toGetAllPic.do?picState=3&url=page/background/pic-list" target="menuFrame"><i class="glyph-icon icon-chevron-right9"></i>待审核照片</a></li>
		                    <li><a href="<%=basePath%>pic/toGetAllPic.do?picState=4&url=page/background/pic-list" target="menuFrame"><i class="glyph-icon icon-chevron-right9"></i>精品照片</a></li>
		                    <li><a href="<%=basePath%>pic/toGetAllPic.do?picState=5&url=page/background/pic-list" target="menuFrame"><i class="glyph-icon icon-chevron-right9"></i>照片回收站</a></li>
		                </ul>
		            </li>
		                       
		        </ul>
    </div>
    
    <!--菜单右边的iframe页面-->
    <div id="right-content" class="right-content">
        <div class="content">
            <div id="page_content">
                <iframe id="menuFrame" name="menuFrame" src="<%=basePath%>page/background/background-main.jsp" style="overflow:visible;"
                        scrolling="yes" frameborder="no" width="100%" height="90%"></iframe>
            </div>
        </div>
    </div>
    
    
    	<div id="dialogBg"></div>
		<div id="dialog" class="animated">
			<img class="dialogIco" width="50" height="50" src="images/ico.png" alt="" />
			<div class="dialogTop">
				<a href="javascript:;" class="claseDialogBtn">关闭</a>
			</div>
			<form action="<%=basePath%>user/doAlterPwd.do" method="post">
				<ul class="editInfos">
					<li><label><font color="#ff0000">* </font>密码：<input type="password" id="userPwdAlter" name="currentPwd"  class="ipt" /></label></li>
					<li><label><font color="#ff0000">* </font>确认：<input type="password" id="userPwdConf" class="ipt"/></label></li>
					<li><input type="submit" onclick="return valueToAlertInput();" value="确认提交" class="submitBtn" /></li>
				</ul>
			</form>
		</div>
    
    
</div>    
</body>
<script type="text/javascript">
function getAdmin(){
	var currenState = ${currentUser.currentState};
	if(currenState != 5){
		alert("无此权限！");
		return false;
	}
	return true;
}

function valueToAlertInput(){
	var forMatPwd = /^[a-zA-Z0-9!@#$%^&*()_?<>{}]{6,18}$/;
	var userPwd = $("#userPwdAlter").val();
	var userPwdConf = $("#userPwdConf").val();
	if(userPwd == null || userPwd ==""){
		alert("请输入密码！");
		$("#userPwdAlter").focus();
		return false;
	}
	if(userPwdConf == null || userPwdConf ==""){
		alert("请进行密码确认！");
		$("#userPwdConf").focus();
		return false;
	}
	if(forMatPwd.test(userPwd) != true){
		alert("密码格式不正确！");
		$("#userPwdAlter").focus();
		return false;
	}
	if(userPwd != userPwdConf){
		alert("两次输入不一致！");
		$("#userPwdAlter").val("");
		$("#userPwdConf").val("");
		$("#userPwdAlter").focus();
		return false;
	}
	return true;
}



var w,h,className;
function getSrceenWH(){
	w = $(window).width();
	h = $(window).height();
	$('#dialogBg').width(w).height(h);
}

window.onresize = function(){  
	getSrceenWH();
}  
$(window).resize();  

$(function(){
	getSrceenWH();
	
	//显示弹框
	$('#alert-click').click(function(){
		className = $(this).attr('class');
		$('#dialogBg').fadeIn(300);
		$('#dialog').removeAttr('class').addClass('animated '+className+'').fadeIn();
	});
	
	//关闭弹窗
	$('.claseDialogBtn').click(function(){
		$('#dialogBg').fadeOut(300,function(){
			$('#dialog').addClass('bounceOutUp').fadeOut();
		});
	});
});

</script>
</html>