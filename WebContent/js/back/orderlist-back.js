
function submitSearch(){
	var searchOrderCode = $("#searchOrderCode").val();
	var searchUserName = $("#searchUserName").val();
	var searchStartPrice = $("#searchStartPrice").val();
	var searchEndPrice = $("#searchEndPrice").val();
	var searchMakeStartTime = $("#searchMakeStartTime").val();
	var searchMakeEndTime = $("#searchMakeEndTime").val();
	var searchPayStartTime = $("#searchPayStartTime").val();
	var searchPayEndTime = $("#searchPayEndTime").val();
	var searchSendStartTime = $("#searchSendStartTime").val();
	var searchSendEndTime = $("#searchSendEndTime").val();
	
	var forMatUserName =/^[\u4e00-\u9fa5a-zA-Z0-9]{3,32}$/;
	var forMatCode =/^[a-z0-9]{4,14}$/;
	var forMatPrice = /^(0|([1-9]\d{0,9}(\.\d{1,2})?))$/;
	var forMatTime = /^[0-9]{4}-(0?[0-9]|1[0-2])-(0?[1-9]|[12]?[0-9]|3[01])$/;
	
	if(searchUserName != null && searchUserName !=""){
		if(forMatUserName.test(searchUserName) != true){
			alert("请输入正确的用户名！");
			$("#searchUserName").focus();
			return;
		}
	}
	
	if(searchOrderCode != null && searchOrderCode !=""){
		if(forMatCode.test(searchOrderCode) != true){
			alert("请输入正确的订单编号！");
			$("#searchOrderCode").focus();
			return;
		}
	}
	
	if(searchStartPrice != null && searchStartPrice !=""){
		if(forMatPrice.test(searchStartPrice) != true){
			alert("价格格式不正确！");
			$("#searchStartPrice").focus();
			return;
		}
	}
	
	if(searchEndPrice != null && searchEndPrice !=""){
		if(forMatPrice.test(searchEndPrice) != true){
			alert("价格格式不正确！");
			$("#searchEndPrice").focus();
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

	var location = (window.location+'').split('/');  
	var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
	var action = "getOrderCondition.do";
	
	$.ajax({
		type:"post",
		url:basePath+"/order/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&orderState="+orderState+
		"&orderCode="+searchOrderCode+
		"&userName="+searchUserName+
		"&searchStartPrice="+searchStartPrice+
		"&searchEndPrice="+searchEndPrice+
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
			          		data:"pageNow="+page+"&pageSize="+pageSize+"&orderState="+orderState+
			        		"&userName="+searchUserName+
			        		"&orderNo="+searchOrderNo+
			        		"&searchStartPrice="+searchStartPrice+
			        		"&searchEndPrice="+searchEndPrice+
			        		"&searchMakeStartTime="+searchMakeStartTime+
			        		"&searchMakeEndTime="+searchMakeEndTime+
			        		"&searchPayStartTime="+searchPayStartTime+
			        		"&searchPayEndTime="+searchPayEndTime+
			        		"&searchSendStartTime="+searchSendStartTime+
			        		"&searchSendEndTime="+searchSendEndTime,
			                success: function (msg) {
			                	var str1 = ""; 
			       			 $(msg.data).each(function(i,order1){ 
			    				 str1 += "<tr class='success'>" +  
			                     "<td>" + order1.orderCode + "</td>" +  
			                     "<td>" + order1.userName + "</td>" + 
			                     "<td>" + order1.orderPrice + "</td><td>"; 
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





function toAlertOrder(orderNo){
	var location = (window.location+'').split('/');  
	var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
	$.ajax({
		type:"post",
		url:basePath+"/order/findOrderByOrderNo.do",
		data:"orderNo="+orderNo, 
		dataType:"json",
		success:function(data){
			$("#aorderNo").val(data.orderNo);
			$("#auserNo").val(data.userNo);
			$("#aorderMakeTime").val(data.orderMakeTime);
			$("#aorderPayTime").val(data.orderPayTime);
			$("#aorderState").val(data.orderState);
			$("#aorderPrice").val(data.orderPrice);
			$("#aorderAddress").val(data.orderAddress);
		}
	});
}






function passOrder(orderNo){
	if(confirm("通过该订单支付申请？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/order/passOrder.do",
			data:"orderNo="+orderNo, 
			dataType:"json",
			success:function(data){
				if(data.passState==1){
					alert(data.passMsg);
					loadOrder();
				}
				else if(data.passState==0){
					alert(data.passMsg);
				}
				
			}
		});
		}
}




function sendOutTool(orderNo){
	if(confirm("订单状态将变更为已发货状态？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/order/sendOutTool.do",
			data:"orderNo="+orderNo, 
			dataType:"json",
			success:function(data){
				if(data.sendState==1){
					alert(data.sendMsg);
					loadOrder();
				}
				else if(data.sendState==0){
					alert(data.sendMsg);
				}
				
			}
		});
		}
}




function deleteOrder(orderNo){
	if(confirm("删除该订单记录？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/order/deleteOrder.do",
			data:"orderNo="+orderNo, 
			dataType:"json",
			success:function(data){
				if(data.deleteState==1){
					alert(data.deleteMsg);
					loadOrder();
				}
				else if(data.deleteState==0){
					alert(data.deleteMsg);
				}
				
			}
		});
		}
	
}

