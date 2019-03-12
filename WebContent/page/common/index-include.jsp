<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String pathInclude = request.getContextPath();
	String basePathInclude = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ pathInclude + "/";
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma","no-cache"); 
%>
<link href="<%=basePathInclude%>css/pop-up.css" rel="stylesheet" type="text/css" />
<link href="<%=basePathInclude%>css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="<%=basePathInclude%>css/bootstrap-theme.css" rel="stylesheet" type="text/css" />
<link href="<%=basePathInclude%>css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
<link href="<%=basePathInclude%>css/index.css" rel="stylesheet" type="text/css" />
<link href="<%=basePathInclude%>css/zoom.css" rel="stylesheet" type="text/css" />
<link href="<%=basePathInclude%>css/jquery-confirm.css" rel="stylesheet" type="text/css" />
<%-- 	<link href="<%=basePathInclude%>artDialog/default.css" rel="stylesheet" type="text/css" /> --%>
<link href="<%=basePathInclude%>artDialog/css/simple.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<%=basePathInclude%>js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="<%=basePathInclude%>js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePathInclude%>js/bootstrap-paginator.js"></script>
<script type="text/javascript" src="<%=basePathInclude%>js/moment.min.js"></script>
<script type="text/javascript" src="<%=basePathInclude%>js/common.js"></script>

<link href="<%=basePathInclude%>css/date-picker.css" rel="stylesheet" type="text/css" />
<link href="<%=basePathInclude%>trumbowyg/design/css/trumbowyg.css" type="text/css">

<script type="text/javascript" src="<%=basePathInclude%>js/jquery.date_input.pack.js"></script>
<script type="text/javascript" src="<%=basePathInclude%>js/browser.js"></script>
<script type="text/javascript" src="<%=basePathInclude%>js/picUpload.js"></script>
<script type="text/javascript" src="<%=basePathInclude%>trumbowyg/trumbowyg.js"></script>
<script type="text/javascript" src="<%=basePathInclude%>trumbowyg/langs/fr.js"></script>
<script type="text/javascript" src="<%=basePathInclude%>trumbowyg/plugins/upload/trumbowyg.upload.js"></script>
<script type="text/javascript" src="<%=basePathInclude%>trumbowyg/plugins/base64/trumbowyg.base64.js"></script>
<script src="<%=basePathInclude%>js/jquery-confirm.js"></script>
<script src="<%=basePathInclude%>artDialog/artDialog.source.js"></script>
<script src="<%=basePathInclude%>artDialog/iframeTools.source.js"></script>

<script>
$(document).ready(function(){
	
	var userName = $("#userName").val();
	if(userName != "" && userName != null){
		$(".usershow").remove();
		var ul = document.getElementById("index_ul");
		
		var li1 = document.createElement("li");
		li1.setAttribute('style', 'float:right;');
		li1.innerHTML = "<a href='javascript:return false;' >欢迎    "+userName+"</a>";
		
		var li2 = document.createElement("li");
		li2.setAttribute('style', 'float:right;');
		li2.innerHTML = "<a href='<%=basePathInclude%>user/logOff.do' > | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注销</a>";

		ul.appendChild(li2);
		ul.appendChild(li1);
	}
 
});



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
	$(".warn").hide();
	createCode();
/* 	var currentUser = ${currentUser.currentName }; 
 	if(typeof(currentUser) != "undefined") {
			$(".usershow").remove();
		}    */
	
	
	$('#loginForm').bind('submit', function(){
        toLogin(this);
        return false;
    });
		
	getSrceenWH();
	
	//显示弹框
	$('#login-click').click(function(){
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



var checkname=0;
var checkpwd=0;

/*验证*/
function check_name(){
	var name=$(".input_name").val();
	var reg =/^[\u4e00-\u9fa5a-zA-Z0-9]{3,16}$/;
	if(name==""){
		$(".name_warn").html("用户名格式错误");
		$(".input_name").focus();
		$(".name_warn").show();
		checkname=0;
	}
	else if(reg.test(name) != true){
		$(".name_warn").html("用户名格式错误");
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
		$(".pwd_warn").html("密码格式错误");
		$(".pwd_warn").show();
		checkpwd=0;
	}
	else if(reg.test(pwd) != true){
		$(".pwd_warn").html("密码格式错误");
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
 			  } else {
 				 check_name();
 				 check_pwd();
			  if(checkname!=1){
				  $(".name_warn").html("用户名格式错误");
				  $(".name_warn").show();
				  $(".input_name").focus();
			  }
			  else if(checkname==1){
			  		if(checkpwd!=1){
			  			$(".pwd_warn").html("密码格式错误")
			  			$(".pwd_warn").show();
			  			$(".input_pwd").focus();
			  		}
			  		else if(checkname==1){
			  			var formData = getFormJson(form);
			  		    $.ajax({
			  		        url: "<%=basePathInclude%>"+"user/toLogin.do",
			  		        type: form.method,
			  		        data: formData,
			  		        dataType:"json",
			  		        success: function(data){			  		        	
								switch(data.loginState){
								case 1:
									/* alert(data.loginMsg); */
									window.location.href="<%=basePathInclude%>"+"user/doLogin.do";
									break;
								case 2:
									$(".name_warn").html(data.loginMsg);
									$(".name_warn").show();
									$(".input_name").focus();
									break;
								case 3:
									$(".name_warn").html(data.loginMsg);
									$(".name_warn").show();
									$(".input_name").focus();
									break;
								case 4:
									$(".pwd_warn").html(data.loginMsg);
									$(".pwd_warn").show();
									$(".input_pwd").focus();
									break;
								}
			  		        }

			  		    });
			  			
			  			
			  		}
				}
			  	
		  }
}

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

window.onload=function(){ 
	//自适当前应屏幕分辨率
	var windowHeight = window.screen.height;
	var windowWidth = window.screen.width;
	var main = document.getElementById("main"); 
	main.style.height = windowHeight*0.9 + "px";
	main.style.width = windowWidth*0.9 + "px";
}; 

var basePath = getbasePath();
function getbasePath(){
    //获取当前网址，如： http://localhost:8080/ems/Pages/Basic/Person.jsp
    var curWwwPath = window.document.location.href;
    //获取主机地址之后的目录，如： /ems/Pages/Basic/Person.jsp
    var pathName = window.document.location.pathname;
    var pos = curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8080
    var localhostPath = curWwwPath.substring(0, pos);
    //获取带"/"的项目名，如：/ems
    var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
    //获取项目的basePathInclude   http://localhost:8080/ems/
    var basePath=localhostPath+projectName+"/";
    return basePath;
};


function checkMact(actNo,userNo){
	if($("#"+actNo).val() != "预约"){
		return;
	}
	$.ajax({
		type : "post",
		url  : basePath + "mact/checkMact.do",
		data : "actNo="+actNo+"&userNo="+userNo, 
		success : function(data) {
			if(data.mactState == 1){
				$("#"+actNo).val("取消申请");
				$("#"+actNo).attr("onclick","cancelApply(\""+actNo+"\""+",\""+userNo+"\");");
			}
			if(data.mactState == 2){
				$("#"+actNo).val("取消预约");
				$("#"+actNo).attr("onclick","cancelRes(\""+actNo+"\""+",\""+userNo+"\");");
			}
		}
	});
}

function cancelApply(actNo,userNo){
	$.ajax({
		type : "post",
		url  : basePathe + "mact/cancelApply.do",
		data : "actNo="+actNo+"&userNo="+userNo, 
		success : function(data) {
			if(data.mactState == 1){
				$("#"+actNo).val("预约");
				$("#"+actNo).attr("onclick","resAct(\""+actNo+"\""+",\""+userNo+"\");");
			}
		}
	});
}

function cancelRes(actNo,userNo){
	$.ajax({
		type : "post",
		url  : basePath + "mact/cancelRes.do",
		data : "actNo="+actNo+"&userNo="+userNo, 
		success : function(data) {
			if(data.mactState == 1){
				$("#"+actNo).val("预约");
				var countN = $("."+actNo).text();
				countN--;
				$("."+actNo).text(countN);
				$("#"+actNo).attr("onclick","resAct(\""+actNo+"\""+",\""+userNo+"\");");
			}
		}
	});
}

function resAct(actNo,userNo){
	$.ajax({
		type : "post",
		url  : basePath + "mact/resAct.do",
		data : "actNo="+actNo+"&userNo="+userNo, 
		success : function(data) {
			if(data.mactState == 1){
				$("#"+actNo).val("取消申请");
				$("#"+actNo).attr("onclick","cancelApply(\""+actNo+"\""+",\""+userNo+"\");");
			}
			if(data.mactState == 2){
				$("#"+actNo).val("取消预约");
				var countN = $("."+actNo).text();
				countN++;
				$("."+actNo).text(countN);
				$("#"+actNo).attr("onclick","cancelRes(\""+actNo+"\""+",\""+userNo+"\");");
			}
		}
	});
}

function addToolToOrder(toolNo,userNo){
	var toolOrderNum = getToolOrderNum(toolNo,userNo)
	var toolNowNum = $("."+toolNo).val();
	var toolNum = toolNowNum - toolOrderNum;
	var toolPrice = $(".price"+toolNo).text();
	$.ajax({
		type : "post",
		url  : basePath + "order/addCart.do",
		data : "toolNo="+toolNo+"&toolNum="+toolNowNum+"&toolPrice="+toolPrice+"&userNo="+userNo, 
		success : function(data) {
			if(data.addState == 1){
				var s=0;
   				var totalAllPrice = $("#totalAll").text();
				if(totalAllPrice !="" && totalAllPrice != null){
					s+=parseFloat(totalAllPrice);
				}   
				s+=toolNum*parseFloat(toolPrice); 
				$("#totalAll").html(s.toFixed(2)); 
			}
			if(data.addState == 2){
				$("#"+toolNo).html("去支付");
				$("#"+toolNo).attr("onclick","toPayOrderDo(\""+toolNo+"\""+",\""+userNo+"\");");
			}
			if(data.addState == 3){
				$("#"+toolNo).html("联系管理员");
				$("#"+toolNo).attr("onclick","callAdmin();");
			}
		}
	});
}

function checkOrder(toolNo){
	if($("#"+toolNo).html() != "添加到购物车"){
		return;
	}
	$.ajax({
		type : "post",
		url  : basePath + "tool/getToolNumByToolNo.do",
		data : "toolNo="+toolNo, 
		success : function(data) {
			if($("."+toolNo).val() > data){
				$("#"+toolNo).html("库存不够");
				$("#"+toolNo).attr("disabled","true");
			}
		}
	});
}

function toPayOrderDo(toolNo,userNo){
	$.ajax({
		type : "post",
		url  : basePath + "order/getOrderNoByUserNo.do",
		data : "userNo="+userNo, 
		success : function(data) {
			orderNo = data;
			if(orderNo == ""){
				$("#"+toolNo).html("联系管理员");
				$("#"+toolNo).attr("onclick","callAdmin();");
			}
			else if(orderNo == "-1"){
				$("#"+toolNo).html("尚未购物");
			}
			else{
				window.location.href=basePath+"order/toPayOrderDo.do?orderNo="+orderNo;
			}
		}
	});
}

function toPayOrderDo2(){
	var userNo = $("#userNo").val();
	if(userNo == null || userNo == ""){
		$("#indexPay").attr("disabled","true");
	}
	else{
		$.ajax({
			type : "post",
			url  : basePath + "order/getOrderNoByUserNo.do",
			data : "userNo="+userNo, 
			success : function(data) {
				orderNo = data;
				if(orderNo == ""){
					$("#indexPay").val("联系管理员");
					$("#indexPay").attr("onclick","callAdmin();");
				}
				else if(orderNo == "-1"){
					$("#"+toolNo).html("尚未购物");
				}
				else{
					window.location.href=basePath+"order/toPayOrderDo.do?orderNo="+orderNo;
				}
			}
		});
	}
}

function orderChange(toolNo){
	$("#"+toolNo).removeAttr("disabled");
	if($("#"+toolNo).html() != "添加到购物车"){
		$("#"+toolNo).html("添加到购物车");
	}
}


function getToolOrderNum(toolNo, userNo){
	var toolOrderNum = 0;
	if(userNo =="" || userNo.length < 1){
		return toolOrderNum;
	}
	$.ajax({
		type : "post",
		async: false,
		url  : basePath + "order/getToolOrderNum.do",
		data : "toolNo="+toolNo+"&userNo="+userNo, 
		success : function(data) {
			toolOrderNum = eval('(' +data +')');
		}
	});
	return toolOrderNum;
}

function getToltalPice(userNo){
	var totalPrice = 0;
	if(userNo =="" || userNo.length < 1){
		return parseFloat(totalPrice).toFixed(2);
	}
	$.ajax({
		type : "post",
		async: false,
		url  : basePath + "order/getToltalPice.do",
		data : "userNo="+userNo, 
		success : function(data) {
			totalPrice = eval('(' +data +')');
		}
	});
	return parseFloat(totalPrice).toFixed(2);
}

//取html中纯文本
function removeHTMLTag(str) {
            str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
            str = str.replace(/[ | ]*\n/g,'\n'); //去除行尾空白
            str = str.replace(/\n[\s| | ]*\r/g,'\n'); //去除多余空行
            str=str.replace(/&nbsp;/ig,'');//去掉&nbsp;
            str=str.replace(/\s/g,''); //将空格去掉
            return str;
}

function changeContentImgSize(id){
	var aImg=document.getElementById(id).getElementsByTagName('img');
	for(var i=0;i<aImg.length;i++){
	      aImg[i].style.height=300+"px";
	      aImg[i].style.width=500+"px";
	}
}
</script>
