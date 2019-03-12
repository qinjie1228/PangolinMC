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
    <title>订单列表</title>
	<script type="text/javascript" src="<%=basePath%>js/back/orderlist-back.js"></script>

</head>
<body>   
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">前台</li>
	  <li class="active">个人中心</li>
	  <li id="orderNameShow" class="active">已付款定单</li>
	</ol>
	
	<div class="searchBar" style="height:100px;">
		<div class="searchTop">搜索栏</div>
		<div class="cutLine"></div>
		<div class="form-inline">
		  <div class="form-group">
		  <span class="itemLeftFirst">搜索条件:</span>
			<input type="text" class="searchItem" id="searchOrderCode" placeholder="订单编号">
		  </div>
		</div>

		<div class="form-inline searchBarTwo">
		  <div class="form-group">
		  <span class="itemLeftFirst searchOrderTimeName">下单时间:</span>
			<input type="text" class="searchItem date_picker searchMakeTimeName" id="searchMakeStartTime" placeholder="起始时间">
			<input type="text" class="itemLeft searchItem date_picker searchMakeTimeName" id="searchMakeEndTime" placeholder="结束时间">
			<input type="text" class="searchItem date_picker searchPayTimeName" id="searchPayStartTime" placeholder="起始时间">
			<input type="text" class="itemLeft searchItem date_picker searchPayTimeName" id="searchPayEndTime" placeholder="结束时间">
			<input type="text" class="searchItem date_picker searchSendTimeName" id="searchSendStartTime" placeholder="起始时间">
			<input type="text" class="itemLeft searchItem date_picker searchSendTimeName" id="searchSendEndTime" placeholder="结束时间">
		  <button type="button" id="submitSearch" class="submitSearch btn" onclick="submitSearchIndex();" style="float:right;margin-right:75px;" >搜索</button>
			</div>
		</div>
	</div>

	<div class="widget-box">
	
		<table cellspacing="0">
    		<tr>
    			<td>订单编号</td>
				<td id="orderPriceTdShow">订单总价</td>
    			<td id ="orderMakeTimeTdShow">下单时间</td>
				<td id ="orderPayTimeTdShow">付款时间</td>
				<td id ="orderSendTimeTdShow">发货时间</td>			
    			<th>操作</th>
    		</tr>
    		<tbody id="tbody">
			</tbody>
		</table>
		
		<ul class="pagination" id="example"> 
    		<li><a href="#">&laquo;</a></li> 
		    <li class="active"><a href="#">1</a></li> 
		    <li ><a href="#">2</a></li> 
		    <li><a href="#">3</a></li> 
		    <li><a href="#">4</a></li> 
		    <li><a href="#">5</a></li> 
		    <li><a href="#">&raquo;</a></li> 
		</ul>
  			
   
		
	</div>
	
</div>

</body>
  
  
 <script type="text/javascript">
 var orderState= ${orderState};
$(document).ready(function(){
	$('.date_picker').date_input();
	
	switch(orderState){
	case 6:
		$("#orderNameShow").html("购物车已确认订单");
		$("#orderPayTimeTdShow").hide();
		$("#orderSendTimeTdShow").hide();
		$(".searchPayTimeName").hide();
		$(".searchSendTimeName").hide();
		$(".searchOrderTimeName").html("下单时间:");
		break;
	case 5:
		$("#orderNameShow").html("购物车订单");
		$("#orderPriceTdShow").hide();
		$("#orderPayTimeTdShow").hide();
		$("#orderSendTimeTdShow").hide();
		$(".searchPayTimeName").hide();
		$(".searchSendTimeName").hide();
		$("#orderMakeTimeTdShow").hide();
		$(".searchMakeTimeName").hide();
		$(".searchOrderTimeName").hide();
		break;
	case 1:
		$("#orderNameShow").html("待审核订单");
		$("#orderPayTimeTdShow").hide();
		$("#orderSendTimeTdShow").hide();
		$(".searchPayTimeName").hide();
		$(".searchSendTimeName").hide();
		$(".searchOrderTimeName").html("下单时间:");
		break;
	case 2:
		$("#mactNameShow").html("已付款订单");
		$("#orderMakeTimeTdShow").hide();
		$("#orderSendTimeTdShow").hide();
		$(".searchMakeTimeName").hide();
		$(".searchSendTimeName").hide();
		$(".searchOrderTimeName").html("付款时间:");
		break;
	case 3:
		$("#mactNameShow").html("已发货订单");
		$("#orderMakeTimeTdShow").hide();
		$("#orderPayTimeTdShow").hide();
		$(".searchMakeTimeName").hide();
		$(".searchPayTimeName").hide();
		$(".searchOrderTimeName").html("发货时间:");
		break;
	case 4:
		$("#mactNameShow").html("失效订单");
		$("#orderPayTimeTdShow").hide();
		$("#orderSendTimeTdShow").hide();
		$(".searchPayTimeName").hide();
		$(".searchSendTimeName").hide();
		$("#orderMakeTimeTdShow").hide();
		$(".searchMakeTimeName").hide();
		$(".searchOrderTimeName").hide();
		break;
	}
	$("#submitSearch").click();
});
 
function submitSearchIndex(){
	var pageSize = 10;
	
	var searchUserName = $("#searchUserName").val();
	var searchOrderCode = $("#searchOrderCode").val();
	var searchMakeStartTime = $("#searchMakeStartTime").val();
	var searchMakeEndTime = $("#searchMakeEndTime").val();
	var searchPayStartTime = $("#searchPayStartTime").val();
	var searchPayEndTime = $("#searchPayEndTime").val();
	var searchSendStartTime = $("#searchSendStartTime").val();
	var searchSendEndTime = $("#searchSendEndTime").val();
	var forMatCode =/^[a-z0-9]{4,14}$/;
	if(searchOrderCode != null && searchOrderCode !=""){
		if(forMatCode.test(searchOrderCode) != true){
			alert("请输入正确的订单编号！");
			$("#searchOrderCode").focus();
			return;
		}
	}
	
	if(searchMakeStartTime != null && searchMakeStartTime !=""){
		if(forMatTime.test(searchMakeStartTime) != true){
			alert("日期格式不正确！");
			$("#searchMakeStartTime").focus();
			return;
		}
	}
	
	if(searchMakeEndTime != null && searchMakeEndTime !=""){
		if(forMatTime.test(searchMakeEndTime) != true){
			alert("日期格式不正确！");
			$("#searchMakeEndTime").focus();
			return;
		}
	}
	
	if(searchPayStartTime != null && searchPayStartTime !=""){
		if(forMatTime.test(searchPayStartTime) != true){
			alert("日期格式不正确！");
			$("#searchPayStartTime").focus();
			return;
		}
	}
	
	if(searchPayEndTime != null && searchPayEndTime !=""){
		if(forMatTime.test(searchPayEndTime) != true){
			alert("日期格式不正确！");
			$("#searchPayEndTime").focus();
			return;
		}
	}

	if(searchSendStartTime != null && searchSendStartTime !=""){
		if(forMatTime.test(searchSendStartTime) != true){
			alert("日期格式不正确！");
			$("#searchSendStartTime").focus();
			return;
		}
	}
	
	if(searchSendEndTime != null && searchSendEndTime !=""){
		if(forMatTime.test(searchSendEndTime) != true){
			alert("日期格式不正确！");
			$("#searchSendEndTime").focus();
			return;
		}
	}
	
	var action ="getOrderCondition.do";
	$.ajax({
		type:"post",
		url:"<%=basePath%>order/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&orderState="+orderState+
		"&orderCode="+searchOrderCode+
		"&userName="+searchUserName+
		"&searchStartPrice="+""+
		"&searchEndPrice="+""+
		"&searchMakeStartTime="+searchMakeStartTime+
		"&searchMakeEndTime="+searchMakeEndTime+
		"&searchPayStartTime="+searchPayStartTime+
		"&searchPayEndTime="+searchPayEndTime+
		"&searchSendStartTime="+searchSendStartTime+
		"&searchSendEndTime="+searchSendEndTime,
		dataType:"json",
		success:function(data){
			$("#tbody").html("");
			 var str = ""; 
			 $(data.data).each(function(i,order){ 
				 str += "<tr>" +
				 "<td>" + order.orderCode + "</td>";
				 if(Number(order.orderState) != 5){
					 str += "<td>" + order.orderPrice + "</td>"; 
				 }
                 switch(Number(order.orderState)){
					case 1:
						str += 
							 "<td>" + moment(order.orderMakeTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
							 "<a class='btn btn-default' href='<%=basePath%>index/toOrderDetail.do?orderNo=" + order.orderNo + "' role='button'>修改</a>";
		                     break;
					case 2:
						str +=
							 "<td>" + moment(order.orderPayTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
							 "<a class='btn btn-default' href='<%=basePath%>index/toOrderDetail.do?orderNo=" + order.orderNo + "' role='button'>查看</a>";
		                     break;
		            case 3:
		            	str +=	     
							 "<td>" + moment(order.orderSendTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
							 "<a class='btn btn-default' href='<%=basePath%>index/toOrderDetail.do?orderNo=" + order.orderNo + "' role='button'>查看</a>" +
		                	 "<a class='btn btn-info' href='javascript:deleteOrder(\""+order.orderNo+"\")' role='button'>删除</a>";
		                	 break;
		            case 4:
		            	str +=	     
							 "<td>" + 
							 "<a class='btn btn-default' href='<%=basePath%>index/toOrderDetail.do?orderNo=" + order.orderNo + "' role='button'>查看</a>" +
		                	 "<a class='btn btn-info' href='javascript:deleteOrder(\""+order.orderNo+"\")' role='button'>删除</a>";
		                	 break;
		            case 5:
		            	str +=
		            		 "<td>" + 
		            		 "<a class='btn btn-default' href='<%=basePath%>index/toPayOrder.do?orderNo=" + order.orderNo + "' role='button'>支付</a>" +
		            		 "<a class='btn btn-info' href='javascript:deleteOrder(\""+order.orderNo+"\")' role='button'>删除</a>";
		                     break;
		            case 6:
		            	str +=
		            		 "<td>" + moment(order.orderMakeTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
		            		 "<a class='btn btn-default' href='<%=basePath%>index/toOrderDetail.do?orderNo=" + order.orderNo + "' role='button'>支付</a>" +
		            		 "<a class='btn btn-info' href='javascript:deleteOrder(\""+order.orderNo+"\")' role='button'>删除</a>";
		                     break;
                 }
     				str += "</td></tr>";
	        });
			 $("#tbody").append(str);		 
			 var options = {
			            bootstrapMajorVersion: 3, //版本
			            currentPage: data.page, //当前页数
			            totalPages: data.pageCount, //总页数
			            visiblePageLinks:5, //显示的最多分页链接数
			            itemTexts: function (type, page, current) {
			              switch (type) {
			                case "first":
			                  return "首页";
			                case "prev":
			                  return "上一页";
			                case "next":
			                  return "下一页";
			                case "last":
			                  return "末页";
			                case "page":
			                  return page;
			              }
			            },
			            onPageClicked: function (event, originalEvent, type, page) {
			              $.ajax({
			            	type:"post",
			            	url:"<%=basePath%>order/"+action,
			            	data:"pageNow="+page+"&pageSize="+pageSize+"&orderState="+orderState+
			            	"&orderCode="+searchOrderCode+
			        		"&userName="+searchUserName+
			        		"&searchStartPrice="+""+
			        		"&searchEndPrice="+""+
			        		"&searchMakeStartTime="+searchMakeStartTime+
			        		"&searchMakeEndTime="+searchMakeEndTime+
			        		"&searchPayStartTime="+searchPayStartTime+
			        		"&searchPayEndTime="+searchPayEndTime+
			        		"&searchSendStartTime="+searchSendStartTime+
			        		"&searchSendEndTime="+searchSendEndTime,
			          		dataType:"json",
			                success: function (msg) {
			                	var str1 = ""; 
			                	  $(msg.data).each(function(i,order1){ 
			                		  str1 += "<tr>" +
			         				 "<td>" + order1.orderCode + "</td>";
			         				 if(Number(order1.orderState) != 5){
			         					 str1 += "<td>" + order1.orderPrice + "</td>"; 
			         				 }
			                          switch(Number(order1.orderState)){
			         					case 1:
			         						str1 += 
			         							 "<td>" + moment(order1.orderMakeTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
			         							 "<a class='btn btn-default' href='<%=basePath%>index/toOrderDetail.do?orderNo=" + order1.orderNo + "' role='button'>修改</a>";
			         		                     break;
			         					case 2:
			         						str1 +=
			         							 "<td>" + moment(order1.orderPayTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
			         							 "<a class='btn btn-default' href='<%=basePath%>index/toOrderDetail.do?orderNo=" + order1.orderNo + "' role='button'>查看</a>";
			         		                     break;
			         		            case 3:
			         		            	str +=	     
			         							 "<td>" + moment(order1.orderSendTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
			         							 "<a class='btn btn-default' href='<%=basePath%>index/toOrderDetail.do?orderNo=" + order1.orderNo + "' role='button'>查看</a>" +
			         		                	 "<a class='btn btn-info' href='javascript:deleteOrder(\""+order1.orderNo+"\")' role='button'>删除</a>";
			         		                	 break;
			         		            case 4:
			         		            	str1 +=	     
			         							 "<td>" + 
			         							 "<a class='btn btn-default' href='<%=basePath%>index/toOrderDetail.do?orderNo=" + order1.orderNo + "' role='button'>查看</a>" +
			         		                	 "<a class='btn btn-info' href='javascript:deleteOrder(\""+order1.orderNo+"\")' role='button'>删除</a>";
			         		                	 break;
			         		            case 5:
			         		            	str1 +=
			         		            		 "<td>" + 
			         		            		 "<a class='btn btn-default' href='<%=basePath%>index/toPayOrder.do?orderNo=" + order1.orderNo + "' role='button'>支付</a>" +
			         		            		 "<a class='btn btn-info' href='javascript:deleteOrder(\""+order1.orderNo+"\")' role='button'>删除</a>";
			         		                     break;
			         		            case 6:
			         		            	str1 +=
			         		            		 "<td>" + moment(order1.orderMakeTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
			         		            		 "<a class='btn btn-default' href='<%=basePath%>index/toOrderDetail.do?orderNo=" + order1.orderNo + "' role='button'>支付</a>" +
			         		            		 "<a class='btn btn-info' href='javascript:deleteOrder(\""+order1.orderNo+"\")' role='button'>删除</a>";
			         		                     break;
			                          }
			              				str1 += "</td></tr>";
			                    });
			                	  $("#tbody").html("");
			                	  $("#tbody").append(str1); 
			                	 
			                  }
			    
			              });
			            }
			          };
			          $('#example').bootstrapPaginator(options);
			        }
			      
			    });
}



$('#simple-editor').trumbowyg();
$('#add-editor').trumbowyg();
$.trumbowyg.btnsGrps.test = ['bold', 'link'];
$.extend(true, $.trumbowyg.langs, {
    fr: {
        align: 'Alignement',
        image: 'Image'
    }
});



function valueToAlertInput(){
	$("#aactContent").val($("#simple-editor").html());
	if($("#actAlertUp").val()==null||$("#actAlertUp").val()==""){
		$("#kactPic").val("fail");
	}else{
		$("#kactPic").val("success");
	}
	return true;
}





			  
</script>
  
  
  
</html>
