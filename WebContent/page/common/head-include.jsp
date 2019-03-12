<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String pathIncludeHead = request.getContextPath();
	String basePathIncludeHead = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ pathIncludeHead + "/";
%>
<div id="header">
			<div id="index_logo">
				<img src="images/logo3.png" height="100%" width="100%">
			</div>
			<!--网站导航条-->
			<div style="width: 100%;" class="navbar navbar-default" role="navigation">
				<ul id="index_ul" style="width: 100%;" class="nav navbar-nav">
					<li class="active"><a href="<%=basePathIncludeHead%>index/toIndex.do">首页</a></li>
					<li><a href="<%=basePathIncludeHead%>index/toIndexNotice.do">公告</a></li>
					<li><a href="<%=basePathIncludeHead%>index/toIndexAct.do">活动</a></li>
					<li><a href="<%=basePathIncludeHead%>index/toIndexTool.do">道具</a></li>
					<li><a href="<%=basePathIncludeHead%>index/toIndexPost.do">论坛</a></li>
					<li><a href="<%=basePathIncludeHead%>index/toIndexPic.do">图库</a></li>
					<li><a href="<%=basePathIncludeHead%>index/toIndexMy.do">我的</a></li>
					<li><a href="<%=basePathIncludeHead%>index/toIndexAboutus.do">关于我们</a></li>
					<li style="float: right;" class="usershow"><a href="<%=basePathIncludeHead%>index/toRegister.do">注册</a></li>
					<li style="float: right;" class="usershow"><a href="javascript:return false;">|</a></li>
					<li style="float: right;" class="usershow"><a id="login-click">登录</a></li>
					<li style="float: right;" class="usershow"><a href="javascript:return false;">|</a></li>
				</ul>
			</div>
		</div>
		
<div id="dialogBg"></div>
		<div id="dialog" class="animated">
			<img class="dialogIco" width="50" height="50" src="images/ico.png" alt="" />
			<div class="dialogTop">
				<a href="javascript:;" class="claseDialogBtn">关闭</a>
			</div>
			<form id="loginForm" method="post">
			<input type="hidden" name="currentState" value="1">
				<ul class="editInfos">
					<li><div class="fudong">
						<label><font color="#ff0000">* </font>用户名：<input style="width:180px;" type="text" name="currentName" onblur="check_name();" class="ipt input_name" /><span class="warn name_warn" ></span></label>
					</div></li>
					<li><div class="fudong">
						<label><font color="#ff0000">* </font>密码&nbsp;&nbsp;&nbsp;：<input style="width:180px;" type="password" name="currentPwd" onblur="check_pwd();" class="ipt input_pwd" /><span class="warn pwd_warn" ></span></label>
					</div></li>
					<li>
					<label><font color="#ff0000">* </font>验证码：<input type="text" id="identifyInput" class="ipt" style="width:105px;" /><span class="warn identify_warn" ></span>
					 <input type="text" id="identifyCode" onclick="createCode();" style="width:73px;border: 0px; background: rgba(0, 0, 0, 0);" readonly/></label>
					</li>
					<li><input style="margin-top:0px;" type="submit" value="立即登录" class="submitBtn" /></li>
				</ul>
			</form>
</div>