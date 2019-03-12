
function submitSearch(){
	var searchToolName = $("#searchToolName").val();
	var searchToolNum = $("#searchToolNum").val();
	var searchStartPrice = $("#searchStartPrice").val();
	var searchEndPrice = $("#searchEndPrice").val();
	var searchStartTime = $("#searchStartTime").val();
	var searchEndTime = $("#searchEndTime").val();
	
	var forMatToolName= /^[\w\u4e00-\u9fa5~!@#$%^&*()+-_={}|\/:;/'/"”‘？’“、：,，。.?<>{}]{2,1000}$/;
	var forMatNum = /^[0-9]{1,12}$/;
	var forMatPrice = /^(0|([1-9]\d{0,9}(\.\d{1,2})?))$/;
	var forMatTime = /^[0-9]{4}-(0?[0-9]|1[0-2])-(0?[1-9]|[12]?[0-9]|3[01])$/;
	
	if(searchToolName != null && searchToolName !=""){
		if(forMatToolName.test(searchToolName) != true){
			alert("请输入正确的道具名称！");
			$("#searchToolName").focus();
			return;
		}
	}
	
	if(searchToolNum != null && searchToolNum !=""){
		if(forMatNum.test(searchToolNum) != true){
			alert("请输入数字！");
			$("#searchToolNum").focus();
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
	var action = "getToolCondition.do";
	$.ajax({
		type:"post",
		url:basePath+"/tool/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&toolState="+toolState+
		"&toolName="+searchToolName+
		"&toolNum="+searchToolNum+
		"&searchStartPrice="+searchStartPrice+
		"&searchEndPrice="+searchEndPrice+
		"&searchStartTime="+searchStartTime+
		"&searchEndTime="+searchEndTime,
		dataType:"json",
		success:function(data){
			$("#tbody").html("");
			 var str = "";  
			 $(data.data).each(function(i,tool){ 
				 str += "<tr class='success'>" +  
                 "<td class='toolNameTd'>";
                 var toolName = tool.toolName;
                 if(toolName.length > 18){
                	 toolName = toolName.substring(0,18) + "...";
                 }
                 str += toolName + "</td>" + 
                 "<td>" + tool.toolNum + "</td>" +  
                 "<td>" + tool.toolPrice + "</td>";
                 switch(Number(tool.toolState)){
					case 1:
						 str += "<td>" + moment(tool.toolPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertTool(\""+tool.toolNo+"\");modelClick();' role='button'>修改</a>"+
		                     "<a class='btn btn-info' href='javascript:overdueTool(\""+tool.toolNo+"\")' role='button'>删除</a>";
		                     break;
		            case 2:
		            	 str += "<td>" +
		                	 "<a class='btn btn-default' href='javascript:recoverTool(\""+tool.toolNo+"\")' role='button'>恢复</a>"+
		                     "<a class='btn btn-info' href='javascript:deleteTool(\""+tool.toolNo+"\")' role='button'>彻底删除</a>";
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
			            	url:basePath+"/tool/"+action,
			            	data:"pageNow="+page+"&pageSize="+pageSize+"&toolState="+toolState+
			        		"&toolName="+searchToolName+
			        		"&toolNum="+searchToolNum+
			        		"&searchStartPrice="+searchStartPrice+
			        		"&searchEndPrice="+searchEndPrice+
			        		"&searchStartTime="+searchStartTime+
			        		"&searchEndTime="+searchEndTime,
			          		dataType:"json",
			                success: function (msg) {
			                	var str1 = ""; 
			                	 $(msg.data).each(function(i,tool1){ 
			                		 str1 += "<tr class='success'>" +  
			                         "<td class='toolNameTd'>";
			                         var toolName1 = tool1.toolName;
			                         if(toolName1.length > 18){
			                        	 toolName1 = toolName1.substring(0,18) + "...";
			                         }
			                         str1 += toolName1 + "</td>" + 
			                         "<td>" + tool1.toolNum + "</td>" +  
			                         "<td>" + tool1.toolPrice + "</td>";
			                         switch(Number(tool1.toolState)){
			        					case 1:
			        						 str1 += "<td>" + moment(tool1.toolPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
			        		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertTool(\""+tool1.toolNo+"\")' role='button'>修改</a>"+
			        		                     "<a class='btn btn-info' href='javascript:overdueTool(\""+tool1.toolNo+"\")' role='button'>删除</a>";
			        		                     break;
			        		            case 2:
			        		            	 str1 += "<td>" +
			        		                	 "<a class='btn btn-default' href='javascript:recoverTool(\""+tool1.toolNo+"\")' role='button'>恢复</a>"+
			        		                     "<a class='btn btn-info' href='javascript:deleteTool(\""+tool1.toolNo+"\")' role='button'>彻底删除</a>";
			        		                     break;
			                         }               
			        				 str += "</td></tr>";
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








function toAlertTool(toolNo){
	var location = (window.location+'').split('/');  
	var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
	$.ajax({
		type:"post",
		url:basePath+"/tool/findToolByToolNo.do",
		data:"toolNo="+toolNo, 
		dataType:"json",
		success:function(data){
			var src = '/upload/tool/'+data.toolPic;
			$("#atoolName").val(data.toolName);
			$("#atoolNo").val(data.toolNo);
			$("#atoolNum").val(data.toolNum);
			$("#atoolState").val(data.toolState);
			$("#aversion").val(data.version);
			$("#simple-editor").html(data.toolDes);
			$("#atoolPrice").val(data.toolPrice);
			$("#pic").attr('src', src);
			$("#atoolPubTime").val(data.toolPubTime);
		}
	});
}






function overdueTool(toolNo){
	if(confirm("道具状态将变更为过期状态？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/tool/overdueTool.do",
			data:"toolNo="+toolNo, 
			dataType:"json",
			success:function(data){
				if(data.overdueState==1){
					alert(data.overdueMsg);
					loadTool();
				}
				else if(data.overdueState==0){
					alert(data.overdueMsg);
				}
				
			}
		});
		}
	
}





function deleteTool(toolNo){
	if(confirm("彻底删除该道具？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/tool/deleteTool.do",
			data:"toolNo="+toolNo, 
			dataType:"json",
			success:function(data){
				if(data.deleteState==1){
					alert(data.deleteMsg);
					loadTool();
				}
				else if(data.deleteState==0){
					alert(data.deleteMsg);
				}
				
			}
		});
		}
	
}




function recoverTool(toolNo){
	if(confirm("恢复该道具到在售状态？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/tool/recoverTool.do",
			data:"toolNo="+toolNo, 
			dataType:"json",
			success:function(data){
				if(data.recoverState==1){
					alert(data.recoverMsg);
					loadTool();
				}
				else if(data.recoverState==0){
					alert(data.recoverMsg);
				}
				
			}
		});
		}
	
}

