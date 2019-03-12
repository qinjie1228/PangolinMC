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
    <title>订单支付</title>

</head>
<style>
.form-pay{
min-height:800px;
}
</style>
<body> 
<%@ include file="/page/common/user-include.jsp"%>
<div id ="main">
	<div id="index_all">
		<%@ include file="/page/common/head-include.jsp"%>
		<!--网站主体部分开始-->
		<div id="index_body">
			<div class="post">
				<ol class="breadcrumb">
				  <li class="active"><a href="<%=basePath%>index/toIndex.do">首页</a></li>
				  <li class="active">订单支付</li>
				</ol>
				<br>
				
				<div class="form-pay">
					<input id="orderState" type="hidden" value="${order.orderState}">
					<input id="orderNo" type="hidden" value="${order.orderNo}" name="orderNo">
					<input id="orderNo" type="hidden" value="${order.orderMakeTime}" id="orderMakeTime">
						<fieldset>
				        	<legend>订单详情</legend>
				            <div class="">
								<label style="margin-left:100px;">订单编号</label>
								<input type="text" class=" form-right" style="float:right;margin-right:150px;width:470px;" value="${order.orderCode }" id="orderCode" disabled>
						  	</div>
						  	<br>
						  
						  	<div class="">
								<label style="margin-left:100px;">收货地址</label>
								<input type="text" class=" form-right" style="float:right;margin-right:150px;width:470px;" value="${order.orderAddress }" name="orderAddress" id="orderAddress">
						  	</div>
						  	<br>
						  	
						  	<div class="orderMakeTime">
								<label style="margin-left:100px;">下单时间</label>
								<input type="text" class=" form-right" style="float:right;margin-right:150px;width:470px;" value="${order.orderMakeTime }" id="orderMakeTime" disabled>
						  	</div>
						  	<br class="timeBr1">
						  	
						  	<div class="">
								<label style="margin-left:100px;">订单详情</label>
								 <textarea id="addActUp" cols="64" rows="10" style="float:right;margin-right:150px;" disabled>${order.toolNumPrice }</textarea>
								 
						  	</div>
							<div style="margin-top:240px;">
								 <button id="leave" type="button" style="float:right;margin-right:150px;" class="btn btn-default" onclick="confirm();">取消</button> 
								<button id="payButton" type="submit" style="float:right;margin-right:20px;" class="btn btn-primary" onclick="return payOrderDo();">确认支付</button>
								<span id="leftAll" style='display:-moz-inline-box;display:inline-block;float:right;margin-right:50px;'>订单将在<span id="timeCount" class="color-red"></span>后过期，请尽快支付订单</span>
							</div>
						   	
						
						</fieldset> 
						
					</div>	
				
			</div>
		</div>
		<!--网站主体部分结束-->
	</div>

  </div>
</body>
  
  
 <script type="text/javascript">
 
var orderMakeTime = new Date($("#orderMakeTime").val().replace("-","/").replace("-","/"));
orderMakeTime.setMinutes(orderMakeTime.getMinutes() + 30, orderMakeTime.getSeconds(), 0);
setInterval("showTimeLeft()",1000);//1000为1秒钟
function showTimeLeft(){
	var date1= new Date();  //开始时间  
    var date2 = new Date(orderMakeTime);    //结束时间  
    var date3 = date2.getTime() - date1.getTime();   //时间差的毫秒数        
    
    //------------------------------  
  
    //计算出相差天数  
    var days=Math.floor(date3/(24*3600*1000))  
  
    //计算出小时数  
  
    var leave1=date3%(24*3600*1000)    //计算天数后剩余的毫秒数  
    var hours=Math.floor(leave1/(3600*1000))  
    //计算相差分钟数  
    var leave2=leave1%(3600*1000)        //计算小时数后剩余的毫秒数  
    var minutes=Math.floor(leave2/(60*1000))  
    //计算相差秒数  
    var leave3=leave2%(60*1000)      //计算分钟数后剩余的毫秒数  
    var seconds=Math.round(leave3/1000)  
    var left = days+"天 "+hours+"小时 "+minutes+" 分钟"+seconds+" 秒"
    
    if(seconds<0||minutes<0||hours<0||days<0){
    	$("#leftAll").html("订单已过期，请重新下单！");
    	$("#leave").hide();
    	$("#payButton").html("重新下单");
    	document.getElementById('payButton').style.marginRight="150px";
    	$("#payButton").attr("onclick","confirm();");
    }
    else if(seconds>0||minutes>0||hours>0||days>0){
    	$("#timeCount").html(left);
    }
}
 

function payOrderDo(){
	var orderNo = $("#orderNo").val();
	var orderAddress = $("#orderAddress").val();
	art.dialog(
	        {
	            content:'确定支付？',
	            style:'succeed noClose'
	        },
	        function(){
	        	$.ajax({
	        		type:"post",
	        		url:"<%=basePath%>order/doPayOrder.do",
	        		data:"orderNo="+orderNo+"&orderAddress="+orderAddress, 
	        		dataType:"json",
	        		success:function(data){
	        			if(data.payState==1){
	        				art.dialog.alert(data.payMsg, function () {
	        					window.location.href="<%=basePath%>index/toIndex.do";
	        			    });
	        			}
	        			else if(data.payState==0){
	        				art.dialog.alert(data.payMsg, function () {
	        					;
	        			    });
	        			}
	        			
	        		}
	        	});
	        },
	        function(){
	        	;
	        }
	);
	return false;
}

function confirm(){
	
	art.dialog(
	        {
	            content:'确定离开？',
	            style:'succeed noClose'
	        },
	        function(){
	        	window.location.href="<%=basePath%>index/toIndexTool.do";
	        },
	        function(){
	            ;
	        }
	);
	return false;
}

			  
</script>
  
  
  
</html>
