
function submitSearch(){
	var searchActTitle = $("#searchActTitle").val();
	var searchUserName = $("#searchUserName").val();
	var searchStartTime = $("#searchStartTime").val();
	var searchEndTime = $("#searchEndTime").val();
	
	var forMatUserName =/^[\u4e00-\u9fa5a-zA-Z0-9]{3,32}$/;
	var forMatTitle = /^[\w\u4e00-\u9fa5~!@#$%^&*()+-_={}|\/:;/'/"”‘？’“、：,，。.?<>{}]{2,1000}$/;
	var forMatTime = /^[0-9]{4}-(0?[0-9]|1[0-2])-(0?[1-9]|[12]?[0-9]|3[01])$/;
	
	if(searchUserName != null && searchUserName !=""){
		if(forMatUserName.test(searchUserName) != true){
			alert("请输入正确的用户名！");
			$("#searchUserName").focus();
			return;
		}
	}
	
	if(searchActTitle != null && searchActTitle !=""){
		if(forMatTitle.test(searchActTitle) != true){
			alert("标题格式不正确！");
			$("#searchActTitle").focus();
			return;
		}
	}

	if(searchStartTime != null && searchStartTime !=""){
		if(forMatTime.test(searchStartTime) != true){
			alert("日期格式不正确！");
			$("#searchStartTime").focus();
			return;
		}
	}
	
	if(searchEndTime != null && searchEndTime !=""){
		if(forMatTime.test(searchEndTime) != true){
			alert("日期格式不正确！");
			$("#searchEndTime").focus();
			return;
		}
	}

	var location = (window.location+'').split('/');  
	var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
	var action = "getMactCondition.do";
	$.ajax({
		type:"post",
		url:basePath+"/mact/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&actResState="+actResState+
		"&actTitle="+searchActTitle+
		"&userName="+searchUserName+
		"&searchStartTime="+searchStartTime+
		"&searchEndTime="+searchEndTime,
		dataType:"json",
		success:function(data){
			$("#tbody").html("");
			 var str = "";  
			 $(data.data).each(function(i,mact){ 
				 str += "<tr class='success'>";  
                 var actTitle = mact.actTitle;
                 if(actTitle.length > 36){
                	 actTitle = mact.substring(0,36) + "...";
                 }
                 str += "<td>" + actTitle + "</td>" + 
                 "<td>" + mact.userName + "</td>";   
                 switch(Number(mact.actResState)){
					case 1:
						 str += 
							 "<td>" +
		                     "<a class='btn btn-default' href='javascript:passMact(\""+mact.actNo+"\")' role='button'>通过</a>"+
		                     "<a class='btn btn-info' href='javascript:failMact(\""+mact.actNo+"\")' role='button'>否决</a>";
		                     break;
					case 2:
						 str +=
							 "<td>" + moment(mact.actResTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
							 "<a class='btn btn-info' href='javascript:failMactAgain(\""+mact.actNo+"\")' role='button'>否决</a>"+
		                     "<a class='btn btn-info' href='javascript:overdueMact(\""+mact.actNo+"\")' role='button'>删除</a>";
		                     break;
		            case 3:
		            	 str +=
		            		 "<td>" +
		            		 "<a class='btn btn-default' href='javascript:passMact(\""+mact.actNo+"\")' role='button'>通过</a>"+
		                	 "<a class='btn btn-info' href='javascript:deleteMact(\""+mact.actNo+"\")' role='button'>删除</a>";
		                	 break;
		            case 4:
		            	 str +=
		            		 "<td>" + moment(mact.actResTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
		                	 "<a class='btn btn-default' href='javascript:recoverMact(\""+mact.actNo+"\")' role='button'>恢复</a>"+
		                     "<a class='btn btn-info' href='javascript:deleteMact(\""+mact.actNo+"\")' role='button'>彻底删除</a>";
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
			            	url:basePath+"/mact/"+action,
			            	data:"pageNow="+1+"&pageSize="+pageSize+"&actResState="+actResState+
			            	"&actTitle="+searchActTitle+
			        		"&userName="+searchUserName+
			        		"&searchStartTime="+searchStartTime+
			        		"&searchEndTime="+searchEndTime,
			          		dataType:"json",
			                success: function (msg) {
			                	var str1 = ""; 
			                	  $(msg.data).each(function(i,mact1){ 
			                		  str1 += "<tr class='success'>";  
			                          var actTitle1 = mact1.actTitle;
			                          if(actTitle1.length > 36){
			                         	 actTitle1 = mact1.substring(0,36) + "...";
			                          }
			                          str1 += "<td>" + actTitle1 + "</td>" + 
			                          "<td>" + mact1.userName + "</td>";   
			                          switch(Number(mact1.actResState)){
			         					case 1:
			         						 str1 += 
			         							 "<td>" +
			         		                     "<a class='btn btn-default' href='javascript:passMact(\""+mact1.mactNo+"\")' role='button'>通过</a>"+
			         		                     "<a class='btn btn-info' href='javascript:failMact(\""+mact1.mactNo+"\")' role='button'>否决</a>";
			         		                     break;
			         					case 2:
			         						 str1 +=
			         							 "<td>" + moment(mact1.actResTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
			         							 "<a class='btn btn-info' href='javascript:failMactAgain(\""+mact1.mactNo+"\")' role='button'>否决</a>"+
			         		                     "<a class='btn btn-info' href='javascript:overdueMact(\""+mact1.mactNo+"\")' role='button'>删除</a>";
			         		                     break;
			         		            case 3:
			         		            	 str1 +=
			         		            		 "<td>" +
			         		            		 "<a class='btn btn-default' href='javascript:passMact(\""+mact1.mactNo+"\")' role='button'>通过</a>"+
			         		                	 "<a class='btn btn-info' href='javascript:deleteMact(\""+mact1.mactNo+"\")' role='button'>删除</a>";
			         		                	 break;
			         		            case 4:
			         		            	 str1 +=
			         		            		 "<td>" + moment(mact1.actResTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
			         		                	 "<a class='btn btn-default' href='javascript:recoverMact(\""+mact1.mactNo+"\")' role='button'>恢复</a>"+
			         		                     "<a class='btn btn-info' href='javascript:deleteMact(\""+mact1.mactNo+"\")' role='button'>彻底删除</a>";
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



function passMact(mactNo){
	if(confirm("通过该活动预约申请？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/mact/passMact.do",
			data:"mactNo="+mactNo, 
			dataType:"json",
			success:function(data){
				if(data.passState==1){
					alert(data.passMsg);
					loadMact();
				}
				else if(data.passState==0){
					alert(data.passMsg);
				}
				
			}
		});
		}
}




function failMact(mactNo){
	if(confirm("否决该活动预约申请？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/mact/failMact.do",
			data:"mactNo="+mactNo, 
			dataType:"json",
			success:function(data){
				if(data.failState==1){
					alert(data.failMsg);
					loadMact();
				}
				else if(data.failState==0){
					alert(data.failMsg);
				}
				
			}
		});
		}
}




function failMactAgain(mactNo){
	if(confirm("否决该活动预约？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/mact/failMactAgain.do",
			data:"mactNo="+mactNo, 
			dataType:"json",
			success:function(data){
				if(data.failAgainState==1){
					alert(data.failAgainMsg);
					loadMact();
				}
				else if(data.failAgainState==0){
					alert(data.failAgainMsg);
				}
				
			}
		});
		}
}





function overdueMact(mactNo){
	if(confirm("活动预约记录将变更为过期状态")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/mact/overdueMact.do",
			data:"mactNo="+mactNo, 
			dataType:"json",
			success:function(data){
				if(data.overdueState==1){
					alert(data.overdueMsg);
					loadMact();
				}
				else if(data.overdueState==0){
					alert(data.overdueMsg);
				}
				
			}
		});
		}
	
}





function deleteMact(mactNo){
	if(confirm("彻底删除该活动预约记录？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/mact/deleteMact.do",
			data:"mactNo="+mactNo, 
			dataType:"json",
			success:function(data){
				if(data.deleteState==1){
					alert(data.deleteMsg);
					loadMact();
				}
				else if(data.deleteState==0){
					alert(data.deleteMsg);
				}
				
			}
		});
		}
	
}




function recoverMact(mactNo){
	if(confirm("恢复该活动预约记录至已成功预约状态？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/mact/recoverMact.do",
			data:"mactNo="+mactNo, 
			dataType:"json",
			success:function(data){
				if(data.recoverState==1){
					alert(data.recoverMsg);
					loadMact();
				}
				else if(data.recoverState==0){
					alert(data.recoverMsg);
				}
				
			}
		});
		}
	
}

