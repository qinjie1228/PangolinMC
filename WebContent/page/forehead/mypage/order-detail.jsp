<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ include file="/page/common/page-include.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>订单详情</title>

</head>
<body>   
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">前台</li>
	  <li class="active">个人中心</li>
	  <li id="actNameShow" class="active">订单</li>
	</ol>
	
	

	
	<form class="form-inline">
	<input id="orderState" type="hidden" value="${order.orderState}">
	<input id="orderNo" type="hidden" value="${order.orderNo}" name="orderNo">
	<input id="orderMakeTime" type="hidden" value="${order.orderMakeTime}">
		<fieldset>
        	<legend>订单详情</legend>
            <div class="">
				<label class=" ">订单编号</label>
				<input type="text" class=" form-right" style="float:right;margin-right:100px;width:470px;" value="${order.orderCode }" id="orderCode" disabled>
		  	</div>
		  	<br>
		  
		  	<div class="">
				<label class=" ">收货地址</label>
				<input type="text" class=" form-right" style="float:right;margin-right:100px;width:470px;" value="${order.orderAddress }" name="orderAddress" id="orderAddress">
		  	</div>
		  	<br>
		  	
		  	<div class="orderMakeTime" style="display:none;">
				<label class=" ">下单时间</label>
				<input type="text" class=" form-right" style="float:right;margin-right:100px;width:470px;" value="${order.orderMakeTime }" id="orderMakeTime" disabled>
		  	</div>
		  	<br class="timeBr1" style="display:none;">
		  	<div class="orderPayTime" style="display:none;">
				<label class=" ">支付时间</label>
				<input type="text" class=" form-right" style="float:right;margin-right:100px;width:470px;" value="${order.orderPayTime }" id="orderPayTime" disabled>
		  	</div>
		  	<br class="timeBr2" style="display:none;">
		  	<div class="orderSendTime" style="display:none;">
				<label class=" ">发货时间</label>
				<input type="text" class=" form-right" style="float:right;margin-right:100px;width:470px;" value="${order.orderSendTime }" id="orderSendTime" disabled>
		  	</div>
		  	<br class="timeBr3" style="display:none;">
		  	
		  	<div class="">
				<label class=" ">订单详情</label>
				 <textarea id="addActUp" cols="64" rows="10" style="float:right;margin-right:100px;" disabled>${order.toolNumPrice }</textarea>
				 
		  	</div><br>
			<div style="margin-top:300px;">
				 <button id="leave" type="button" style="float:right;margin-right:50px;" class="btn btn-default" onclick="cancelPayOrderTo();">取消</button> 
				<button id="payButton" type="submit" style="float:right;margin-right:10px;" class="btn btn-primary" onclick="return payOrderDo();">确认支付</button>
				<span id="leftAll" style='display:-moz-inline-box;display:inline-block;float:right;margin-right:50px;'>订单将在<span id="timeCount" style="ont-color:red;"></span>后过期，请尽快支付订单</span>
			</div>
		   	
		
		</fieldset> 
		
	</form>	
</div>
</body>
  
  
 <script type="text/javascript">
$(document).ready(function(){
	var orderState=$("#orderState").val();
	var orderNo = $("#orderNo").val();
	switch(Number(orderState)){
	case 6:
		$(".orderMakeTime").show();$(".timeBr1").show();
        break;
	case 1:
		$(".orderMakeTime").show();$(".timeBr1").show();
		$("#payButton").html("修改");
		$("#payButton").attr("onclick","return alterDo(\""+orderNo+"\");");
        break;
	case 2:
		$("#orderAddress").attr("disabled","true");
		$("#leave").hide();
		$("#payButton").html("确定");
		$("#payButton").attr("onclick","return confirm();");
		$(".orderMakeTime").show();$(".orderPayTime").show();$(".timeBr1").show();$(".timeBr2").show();
        break;
	case 3:
		$("#orderAddress").attr("disabled","true");
		$("#leave").hide();
		$("#payButton").html("确定");
		$("#payButton").attr("onclick","return confirm();");
		$(".orderMakeTime").show();$(".orderPayTime").show();$(".orderSendTime").show();$(".timeBr1").show();$(".timeBr2").show();$(".timeBr3").show();
        break;
	case 4:
		$("#orderAddress").attr("disabled","true");
		$("#leave").hide();
		$("#payButton").html("确定");
		$("#payButton").attr("onclick","return confirm();");
        break;
	}
});

var orderMakeTime = new Date($("#orderMakeTime").val().replace("-","/").replace("-","/"));
orderMakeTime.setMinutes(orderMakeTime.getMinutes() + 30, orderMakeTime.getSeconds(), 0);

if($("#orderState").val() == "6"){
	setInterval("showTimeLeft()",1000);//1000为1秒钟
}
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
	        					window.location.href="<%=basePath%>"+"order/toGetAllOrder.do?orderState=1&url=page/forehead/mypage/my-order";
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


function alterDo(){
	var orderNo = $("#orderNo").val();
	var orderAddress = $("#orderAddress").val();
	art.dialog(
	        {
	            content:'确定修改？',
	            style:'succeed noClose'
	        },
	        function(){
	        	$.ajax({
	        		type:"post",
	        		url:"<%=basePath%>order/alterDo.do",
	        		data:"orderNo="+orderNo+"&orderAddress="+orderAddress, 
	        		dataType:"json",
	        		success:function(data){
	        			if(data.state==1){
	        				art.dialog.alert(data.msg, function () {
	        					window.location.href="<%=basePath%>"+"order/toGetAllOrder.do?orderState=1&url=page/forehead/mypage/my-order";
	        			    });
	        			}
	        			else if(data.state==0){
	        				art.dialog.alert(data.msg, function () {
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
	        	window.location.href="<%=basePath%>"+"order/toGetAllOrder.do?orderState="+${order.orderState}+"&url=page/forehead/mypage/my-order";
	        },
	        function(){
	            ;
	        }
	);
	return false;
}

			  
</script>
  
  
  
</html>
