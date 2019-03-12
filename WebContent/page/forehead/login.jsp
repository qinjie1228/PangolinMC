<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma","no-cache"); 
%>
<head>
 <base href="<%=basePath%>">
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>穿山甲登山俱乐部用户中心</title>
<link rel="stylesheet" href="<%=basePath%>css/login.css" />
<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js" ></script>
<script type="text/javascript" src="<%=basePath%>js/common.js" ></script>
</head>
	<body>
		<div class="nav_top">
			<div class="nav_tcon">
		        <div class="logotitle">
		        	<span><a href="<%=basePath%>index/toIndex.do">穿山甲登山俱乐部</a></span>
		            <p>PangolinMC</p>
		        </div>
		        <div class="logoname">账号登录</div>
		    </div>
		</div>
		<div class="logo_content">
			<div class="logo_ccon">
		        <div class="logo_enter">
		        	<span style="border-bottom:solid 1px #cfcfcf;width:350px; margin:18px 15px 2px 15px; float:left;padding:0 0 2px 0">请登陆</span>
		        	
		        	<form id="loginForm" method="post" >
		        	<span class="the_show" style="margin-top: 20px;">选择登陆权限：</span>
		            <select id="select" name="currentState">
		            	 <option value="1"  selected>会员</option>
		            	 <option value="2">管理员</option>
		            </select>
		            
		            <div class="fudong">
			        	<span class="the_show">用户名：</span><input class="the_content input_name" type="text" name="currentName" onblur="check_name()" />
						<span class="warn name_warn" >请输入3~16位英文，数字，中文字符</span>
						<br />
					</div>
		            
		            
		            <div class="fudong">
						<span class="the_show">密码：</span><input class="the_content input_pwd" type="password" name="currentPwd" onblur="check_pwd()"/>
						<span class="warn pwd_warn">请输入6~18位英文，数字，特殊字符</span>
						<br />
					</div>
					
					
					<div class="fudong">
					<span class="the_show">验证码：</span>
					<input class="the_content" type="text" id="identifyInput" style="width: 100px;"/>
					<input type="text" id="identifyCode" onclick="createCode();" style="width:90px;   border:0px;background:rgba(0, 0, 0, 0);"  readonly/>
					</div>
					<br />
		          
		            
		            <button  type="submit" style="margin-left: 7%;">登&nbsp;&nbsp;录</button>
		            <br><br><br><br>
		            <a style="margin-left: 40px;" href="<%=basePath%>index/toRegister.do">没有账号？立即注册</a>
		             </form>
		        </div>
		    </div>
		</div>
		
		
<script>

// 登录页面若在框架内，则跳出框架
if (self != top) {
	top.location = self.location;
};



$(function(){
	$(".warn").hide();
	createCode();
	
	
	$('#loginForm').bind('submit', function(){
        toLogin(this);
        return false;
    });
	
});

//将form中的值转换为键值对。
function getFormJson(form) {
    var o = {};
    var a = $(form).serializeArray();
    $.each(a, function () {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
}



var checkname=0;
var checkpwd=0;

/*验证*/
function check_name(){
	var name=$(".input_name").val();
	var reg =/^[\u4e00-\u9fa5a-zA-Z0-9]{3,16}$/;
	if(name==""){
		$(".name_warn").html("请输入3~16位英文，数字，中文字符");
		$(".name_warn").show();
		checkname=0;
	}
	else if(reg.test(name) != true){
		$(".name_warn").html("请输入3~16位英文，数字，中文字符");
		$(".name_warn").show();
		checkname=0;
	}
	else if(reg.test(name) == true){
		$(".name_warn").hide();
		checkname=1;
	}
	
}
function check_pwd(){
	var pwd=$(".input_pwd").val();
	var reg = /^[a-zA-Z0-9~!@#$%^&*()+-_={}|\/:;/'/",.?<>{}]{6,18}$/;
	if(pwd==""){
		$(".pwd_warn").html("请输入6~18位英文，数字，特殊字符");
		$(".pwd_warn").show();
		checkpwd=0;
	}
	else if(reg.test(pwd) != true){
		$(".pwd_warn").html("请输入6~18位英文，数字，特殊字符");
		$(".pwd_warn").show();
		checkpwd=0;
	}
	else if(reg.test(pwd) == true){
		$(".pwd_warn").hide();
		checkpwd=1;
	}
	
}

function toLogin(form){
		  var inputCode = document.getElementById("identifyInput").value;
 		 if (inputCode.length <= 0) {
 		    alert("请输入验证码！");
 		  }   
 		  else if (inputCode.toLowerCase() != code.toLowerCase()) {
		    alert("验证码输入错误！");
		  createCode();//刷新验证码 
		  }  
		  else {
			  check_name();
			  check_pwd();
			  if(checkname!=1){
				  $(".name_warn").html("请输入3~16位以上英文，数字，中文字符");
				  $(".name_warn").show();
			  }
			  else if(checkname==1){
			  		if(checkpwd!=1){
			  			$(".pwd_warn").html("请输入6~18位英文，数字，特殊字符")
			  			$(".pwd_warn").show();
			  		}
			  		else if(checkname==1){
			  			var formData = getFormJson(form);
			  		    $.ajax({
			  		        url: "<%=basePath%>"+"user/toLogin.do",
			  		        type: form.method,
			  		        data: formData,
			  		        dataType:"json",
			  		        success: function(data){			  		        	
								switch(data.loginState){
								case 1:
									window.location.href="<%=basePath%>"+"user/doLogin.do";
									break;
								case 2:
									$(".name_warn").html(data.loginMsg);
									$(".name_warn").show();
									break;
								case 3:
									$(".name_warn").html(data.loginMsg);
									$(".name_warn").show();
									break;
								case 4:
									$(".pwd_warn").html(data.loginMsg);
									$(".pwd_warn").show();
									break;
								case 5:
									$(".name_warn").html(data.loginMsg);
									$(".name_warn").show();
									break;
								}
			  		        }

			  		    });
			  			
			  			
			  		}
				}
			  	
		  }
		

	
	
}

			
</script>
		
		
		
</body>

</html>
