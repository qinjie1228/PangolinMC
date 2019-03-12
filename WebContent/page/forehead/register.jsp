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
		<link rel="stylesheet" href="<%=basePath%>css/register.css" />
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
		        <div class="logoname">账号注册</div>
		    </div>
		</div>
		<div class="logo_content">
			<div class="logo_ccon">
		        <div class="logo_enter">
		        	<span style="border-bottom:solid 1px #cfcfcf;width:450px; margin:18px 15px 2px 15px; float:left;padding:0 0 2px 0">注册</span><br /><br /><br />
		        	<form  method="post" id="regForm">
		        	<div class="fudong">
			        	<span class="the_show">用户名：</span><input class="the_content input_name" type="text" name="userName" onblur="check_name()" />
						<span class="warn name_warn" ></span>
						<br />
					</div>
					
					<div class="fudong">
						<span class="the_show">密码：</span><input class="the_content input_pwd" type="password" name="userPwd" onblur="check_pwd()"/>
						<span class="warn pwd_warn">请输入6~18位英文，数字，特殊字符</span>
						<br />
					</div>
					
					<div class="fudong">
						<span class="the_show">密码确认：</span><input class="the_content input_pwdconf" type="password" onblur="check_pwdconf()"/>
						<span class="warn pwdconf_warn">密码必须一致</span>
						<br />
					</div>
					
					<div class="fudong">
						<span class="the_show">姓名：</span><input class="the_content input_realname" type="text" name="userRealName" onblur="check_realname()" />
						<span class="warn realname_warn">请输入中文名或英文名</span>
					<br /><br />
					</div>
					
					<span class="the_show" style="float: left;">出生日期：</span>
					<div style="float: left;">
					<input type="hidden" name="userAge" id="age"/>
				   	<select class="sel_year" rel="2000" > </select> 年 
					<select class="sel_month" rel="2"> </select> 月 
					<select class="sel_day" rel="14"> </select> 日 
   					</div>
					
					<span class="the_show">性别：</span><input type="radio" checked="true" value="0" name="userSex"/>男
					<input type="radio" value="1" name="userSex"/>女
					<br />
					
					<span class="the_show">地址：</span><input class="the_content" type="text" name="userAddress" /><br />
					
					<div class="fudong">
						<span class="the_show">邮箱：</span><input class="the_content input_email" type="text" name="userEmail" onblur="check_email()"/>
						<span class="warn email_warn">请输入有效邮箱</span>
						<br />
					</div>
					
					<span class="the_show">头像：</span><input class="the_content" type="file" name="userPic" /><br />
					<span class="the_show">验证码：</span>
					<input class="the_content" type="text" id="identifyInput" style="width: 120px;"/>
					<input type="text" id="identifyCode" onclick="createCode();" style="border:0px;background:rgba(0, 0, 0, 0);"  readonly="true"/>
					<br />
		            
		            <button type="submit">注&nbsp;&nbsp;册</button><br/><br/><br/>
		            </form>
		            &nbsp;&nbsp;&nbsp;&nbsp;<a href="<%=basePath%>page/forehead/login.jsp">我有账号？立即登录</a>
		        </div>
		    </div>
		</div>
		
		
		<script>

			$(function(){
				$(".warn").hide();
				createCode();
				
				
				$('#regForm').bind('submit', function(){
			        toReg(this);
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
				var checkpwdconf=0;
				var checkemail=0;
				var checkrealname=1;
				
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
						$(".name_warn").html("请输入3~16位以上英文，数字，中文字符");
						$(".name_warn").show();
						checkname=0;
					}		 						
					else if(reg.test(name) == true){
						
						$.ajax({
						 	type: "post",
			  		        url: "<%=basePath%>"+"user/checkNameRepeat.do",
			  		        data: "userName="+name,
			  		        dataType:"json",
			  		        success: function(data){
			  		        	if(data.checkState==2){
			  		        		$(".name_warn").html(data.checkMsg);
			  		        		$(".name_warn").show();
			  		        	}
			  		        	else if(data.checkState==1){
			  		        		$(".name_warn").hide();
									checkname=1;
			  		        	}
			  		        }
					 });
												
					}
					
				}
				function check_pwd(){
					var pwd=$(".input_pwd").val();
					var reg = /^[a-zA-Z0-9~!@#$%^&*()+-_={}|\/:;/'/",.?<>{}]{6,18}$/;
/* 					var reg =/^[A-Za-z0-9]{6,12}$/; */
					if(pwd==""){
						$(".pwd_warn").show();
					}
					else if(reg.test(pwd) != true){
						$(".pwd_warn").show();
					}
					else if(reg.test(pwd) == true){
						$(".pwd_warn").hide();
						checkpwd=1;
					}
					
				}
				function check_pwdconf(){
					var pwd=$(".input_pwd").val();
					var pwdconf=$(".input_pwdconf").val();
					if(pwdconf==""){
						$(".pwdconf_warn").show();
					}
					else if(pwd!= pwdconf){
						$(".pwdconf_warn").show();
					}
					else if(pwd== pwdconf){
						$(".pwdconf_warn").hide();
						checkpwdconf=1;
					}
					
				}
				function check_realname(){
					var realname=$(".input_realname").val();
					var reg =/^([u4e00-u9fa5·s]{1,20}|[a-zA-Z.s]{1,20})$/;
					if(realname==""||realname.length==0){
						;
					}
					else if(reg.test(realname) != true){
						$(".realname_warn").show();
						checkrealname=0;
					}
					else if(reg.test(realname) == true){
						$(".realname_warn").hide();
						checkrealname=1;
					}
				}
				function check_email(){
					var email=$(".input_email").val();
					var reg = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
					if(email==""){
						$(".email_warn").show();
					}
					else if(reg.test(email) != true){
						$(".email_warn").show();
					}
					else if(reg.test(email) == true){
						$(".email_warn").hide();
						checkemail=1;
					}
					
				}
				
				
				function toReg(form) {
					  var inputCode = document.getElementById("identifyInput").value;
					  if (inputCode.length <= 0) {
					    alert("请输入验证码！");
					  } else if (inputCode.toLowerCase() != code.toLowerCase()) {
					    alert("验证码输入错误！");
					  createCode();//刷新验证码 
					  } else {
						  check_name();
						  check_pwd();
						  check_pwdconf();
						  check_realname();
						  check_email();
						  	if(checkname!=1){
						  		$(".name_warn").html("请输入3~16位以上英文，数字，中文字符");
						  		$(".name_warn").show();
						  		$(".input_name").focus();
						  	}
						  	else if(checkname==1){
						  		if(checkpwd!=1){
						  			$(".pwd_warn").show();
						  			$(".input_pwd").focus();
						  		}
						  		else if(checkpwd==1){
						  			if(checkpwdconf!=1){
						  				$(".pwdconf_warn").show();
						  				$(".input_pwdconf").focus();
						  			}
						  			else if(checkpwdconf==1){
						  				if(checkrealname!=1){
						  					$(".realname_warn").show();
						  					$(".input_realname").focus();
						  				}
						  				else if(checkrealname==1){
						  					if(checkemail!=1){
						  						$(".email_warn").show();
						  						$(".input_email").focus();
						  					}
						  					else if(checkrealname==1){
						  					
						  						
						  						var formData = getFormJson(form);
									  		    $.ajax({
									  		        url: "<%=basePath%>"+"user/toRegister.do",
									  		        type: form.method,
									  		        data: formData,
									  		        dataType:"json",
									  		        success: function(data){			  		        	
														switch(data.regState){
														case 1:
															alert(data.regMsg);
															window.location.href="<%=basePath%>"+"page/forehead/login.jsp";
															break;
														case 2:alert(data.regMsg);break;
														}
									  		        }

									  		    });
						  						
						  						
						  					}
						  				}
						  			}
						  		}
							}
						  	
					  }
					}
			
		</script>
		
		
		</body>

</html>
