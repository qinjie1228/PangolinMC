<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
    <title>订单列表</title>
	<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/bootstrap-theme.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/date-picker.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/common.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/bootstrap-paginator.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/back/orderlist-back.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.date_input.pack.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/browser.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/moment.min.js"></script>
	
	<script src="<%=basePath%>js/back/background-common.js"></script>

</head>
<body onload="loadOrder();">   
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">后台</li>
	  <li class="active">订单管理</li>
	  <li id="orderNameShow" class="active">待审核订单</li>
	</ol>
	
	<div class="searchBar">
		<div class="searchTop">搜索栏</div>
		<div class="cutLine"></div>
		<div class="form-inline">
		  <div class="form-group">
		  <span class="itemLeftFirst">搜索条件:</span>
		  	<input type="text" class="searchItem" id="searchOrderCode" placeholder="订单编号">
			<input type="text" class="itemLeft searchItem" id="searchUserName" placeholder="用户名">
			<input type="text" class="itemLeft searchItem" id="searchStartPrice" placeholder="起始价格">
			<input type="text" class="itemLeft searchItem" id="searchEndPrice" placeholder="结束价格">
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
		  <button type="button" class="submitSearch btn" onclick="submitSearch();" style="margin-left:449px;">搜索</button>
			</div>
		</div>
	</div>

	<div class="widget-box">
		<table class="table table-hover table-bordered table-striped table-responsive">
			<thead>
				<tr>
					<td>订单编号</td>
					<td>下单者</td>
					<td>订单总价</td>
					<td>收货人地址</td>
					<td id ="orderMakeTimeTdShow">下单时间</td>
					<td id ="orderPayTimeTdShow">付款时间</td>
					<td id ="orderSendTimeTdShow">发货时间</td>					
					<td>操作</td>
				</tr>
			</thead>
			
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




<!-- 修改订单价格框开始 -->
<div class="modal fade" id="modify" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">订单信息修改</h4>
      </div>
      <div class="modal-body">
        <!--修改订单表单-->
		<form class="form-horizontal" action="<%=basePath%>order/doAlterOrder.do" method="post">
		
		<input type="hidden" name="orderNo" id="aorderNo"/>
		<input type="hidden" name="userNo" id="auserNo"/>
		<input type="hidden" name="orderMakeTime" id="aorderMakeTime"/>
		<input type="hidden" name="orderPayTime" id="aorderPayTime"/>
		<input type="hidden" name="orderState" id="aorderState"/>
		
		  <div class="form-group">
			<label class="col-sm-3 control-label">订单价格</label>
			<div class="col-sm-9">
			  <input type="text" class="form-control" name="orderPrice" id="aorderPrice">
			</div>
		  </div>
		  
		   <div class="form-group">
			<label class="col-sm-3 control-label">收货人地址</label>
			<div class="col-sm-9">
			  <input type="text" class="form-control" name="orderAddress" id="aorderAddress">
			</div>
		  </div>
  
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="submit" class="btn btn-primary">确认修改</button>
      </div>
      
      </form>
       <!--修改订单表单结束-->
      	
      </div>
      </div>
      </div>
    </div>	
 <!--修改订单模态框结束-->   



</body>
  
  
 <script type="text/javascript">

var orderState= ${orderState};
var pageSize = 6;

function loadOrder(){
	$('.date_picker').date_input();
	
	var action ="doGetAllOrder.do";
	switch(orderState){
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
			$(".searchOrderTimeName").html("下单时间:");
			break;
	}
	$.ajax({
		type:"post",
		url:"<%=basePath%>order/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&orderState="+orderState, 
		dataType:"json",
		success:function(data){
			$("#tbody").html("");
			 var str = "";  
			 $(data.data).each(function(i,order){ 
				 str += "<tr class='success'>" +  
                 "<td>" + order.orderCode + "</td>" +  
                 "<td>" + order.userName + "</td>" + 
                 "<td>" + order.orderPrice + "</td><td>";  
                 var orderAddress = order.orderAddress;
				 if(orderAddress.length > 30){
					 orderAddress = orderAddress.substring(0,30) + "...";
                 }
                 str += orderAddress + "</td>";  
                 switch(Number(order.orderState)){
					case 1:
						 str += 
							 "<td>" + moment(order.orderMakeTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
							 "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertOrder(\""+order.orderNo+"\")' role='button'>修改</a>"+
		                     "<a class='btn btn-default' href='javascript:passOrder(\""+order.orderNo+"\")' role='button'>通过</a>"+
		                     "<a class='btn btn-info' href='javascript:deleteOrder(\""+order.orderNo+"\")' role='button'>否决</a>";
		                     break;
					case 2:
						 str +=
							 "<td>" + moment(order.orderPayTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
							 "<a class='btn btn-default' href='javascript:sendOutTool(\""+order.orderNo+"\")' role='button'>发货</a>"+
		                     "<a class='btn btn-info' href='javascript:deleteOrder(\""+order.orderNo+"\")' role='button'>删除</a>";
		                     break;
		            case 3:
		            	 str +=
							 "<td>" + moment(order.orderSendTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
		                	 "<a class='btn btn-info' href='javascript:deleteOrder(\""+order.orderNo+"\")' role='button'>删除</a>";
		                	 break;
		            case 4:
		            	 str +=
		            		 "<td>" + moment(order.orderMakeTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
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
			          		data:"pageNow="+page+"&pageSize="+pageSize+"&orderState="+orderState, 
			          		dataType:"json",
			                success: function (msg) {
			                	var str1 = ""; 
			       			 $(msg.data).each(function(i,order1){ 
			    				 str1 += "<tr class='success'>" +  
			                     "<td>" + order1.orderCode + "</td>" +  
			                     "<td>" + order1.userName + "</td>" + 
			                     "<td>" + order1.orderPrice + "</td>"; 
			                     var orderAddress1 = order1.orderAddress;
			    				 if(orderAddress1.length > 30){
			    					 orderAddress1 = orderAddress1.substring(0,30) + "...";
			                     }
			                     str1 += orderAddress1 + "</td>";  
			                     switch(Number(order1.orderState)){
			    					case 1:
			    						 str1 += 
			    							 "<td>" + moment(order1.orderMakeTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
			    							 "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertOrder(\""+order1.orderNo+"\")' role='button'>修改</a>"+
			    		                     "<a class='btn btn-default' href='javascript:passOrder(\""+order1.orderNo+"\")' role='button'>通过</a>"+
			    		                     "<a class='btn btn-info' href='javascript:deleteOrder(\""+order1.orderNo+"\")' role='button'>否决</a>";
			    		                     break;
			    					case 2:
			    						 str1 +=
			    							 "<td>" + moment(order1.orderPayTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
			    							 "<a class='btn btn-default' href='javascript:sendOutTool(\""+order1.orderNo+"\")' role='button'>发货</a>"+
			    		                     "<a class='btn btn-info' href='javascript:deleteOrder(\""+order1.orderNo+"\")' role='button'>删除</a>";
			    		                     break;
			    		            case 3:
			    		            	 str1 +=	     
			    							 "<td>" + moment(order1.orderSendTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
			    		                	 "<a class='btn btn-info' href='javascript:deleteOrder(\""+order1.orderNo+"\")' role='button'>删除</a>";
			    		                	 break;
			    		            case 4:
			    		            	 str1 +=
			    		            		 "<td>" + moment(order1.orderMakeTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
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


  
			  
			  
</script>
  
  
  
</html>
