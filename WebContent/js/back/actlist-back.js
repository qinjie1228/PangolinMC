
function submitSearch(){
	var searchUserName = $("#searchUserName").val();
	var searchActTitle = $("#searchActTitle").val();
	var searchActNum = $("#searchActNum").val();
	var searchStartTime = $("#searchStartTime").val();
	var searchEndTime = $("#searchEndTime").val();
	
	var forMatUserName =/^[\u4e00-\u9fa5a-zA-Z0-9]{3,32}$/;
	var forMatTitle = /^[\w\u4e00-\u9fa5~!@#$%^&*()+-_={}|\/:;/'/"”‘？’“、：,，。.?<>{}]{2,1000}$/;
	var forMatNum = /^[0-9]{1,12}$/;
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
	
	if(searchActNum != null && searchActNum !=""){
		if(forMatNum.test(searchActNum) != true){
			alert("请输入数字！");
			$("#searchActNum").focus();
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
	var action = "getActCondition.do";
	$.ajax({
		type:"post",
		url:basePath+"/act/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&actState="+actState+
		"&userName="+searchUserName+
		"&actTitle="+searchActTitle+
		"&actNum="+searchActNum+
		"&searchStartTime="+searchStartTime+
		"&searchEndTime="+searchEndTime,
		dataType:"json",
		success:function(data){
			$("#tbody").html("");
			 var str = "";  
			 $(data.data).each(function(i,act){ 
				 str += "<tr class='success'>" +  
                 "<td class='actTitleTd'>";
                 var actTitle = act.actTitle;
                 if(actTitle.length > 18){
                	 actTitle = actTitle.substring(0,18) + "...";
                 }
                 str += actTitle + "</td>" + 
                 "<td>" + act.userName + "</td>" + 
                 "<td>" + act.actNum + "</td>";  
                 switch(Number(act.actState)){
					case 1:
						 str += "<td>" +
		                	 "<a class='btn btn-default' data-toggle='modal' data-target='#look' onclick='toLookAct(\""+act.actNo+"\")' role='button'>查看</a>"+
		                     "<a class='btn btn-default' href='javascript:passAct(\""+act.actNo+"\")' role='button'>通过</a>"+
		                     "<a class='btn btn-info' href='javascript:failAct(\""+act.actNo+"\")' role='button'>否决</a>";
		                     break;
					case 2:
						 str += "<td>" + moment(act.actPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertAct(\""+act.actNo+"\")' role='button'>修改</a>"+
		                     "<a class='btn btn-info' href='javascript:overdueAct(\""+act.actNo+"\")' role='button'>删除</a>";
		                     break;
		            case 3:
		            	 str += "<td>" +
		                	 "<a class='btn btn-info' href='javascript:deleteAct(\""+act.actNo+"\")' role='button'>删除</a>";
		                	 break;
		            case 4:
		            	 str += "<td>" + moment(act.actPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
		                	 "<a class='btn btn-default' href='javascript:recoverAct(\""+act.actNo+"\")' role='button'>恢复</a>"+
		                     "<a class='btn btn-info' href='javascript:deleteAct(\""+act.actNo+"\")' role='button'>彻底删除</a>";
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
			            	url:basePath+"/act/"+action,
			            	data:"pageNow="+page+"&pageSize="+pageSize+"&actState="+actState+
			        		"&userName="+searchUserName+
			        		"&actTitle="+searchActTitle+
			        		"&actNum="+searchActNum+
			        		"&searchStartTime="+searchStartTime+
			        		"&searchEndTime="+searchEndTime,
			          		dataType:"json",
			                success: function (msg) {
			                	var str1 = ""; 
			                	  $(msg.data).each(function(i,act1){ 
			                		 str1 += "<tr class='success'>" +  
				                     "<td class='actTitleTd'>";
				                     var actTitle1 = act1.actTitle;
				                     if(actTitle1.length > 18){
				                    	 actTitle1 = actTitle1.substring(0,18) + "...";
				                     }
				                     str1 += actTitle1 + "</td>" + 
			                         "<td>" + act1.userName + "</td>" +  
			                         "<td>" + act1.actNum + "</td>"; 
			                         switch(Number(act1.actState)){
				     					case 1:
				     						 str1 += "<td>" +
				     		                	 "<a class='btn btn-default' data-toggle='modal' data-target='#look' onclick='toLookAct(\""+act1.actNo+"\")' role='button'>查看</a>"+
				     		                     "<a class='btn btn-default' href='javascript:passAct(\""+act1.actNo+"\")' role='button'>通过</a>"+
				     		                     "<a class='btn btn-info' href='javascript:failAct(\""+act1.actNo+"\")' role='button'>否决</a>";
				     		                     break;
				     					case 2:
				     						 str1 += "<td>" + moment(act1.actPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
				     		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertAct(\""+act1.actNo+"\")' role='button'>修改</a>"+
				     		                     "<a class='btn btn-info' href='javascript:overdueAct(\""+act1.actNo+"\")' role='button'>删除</a>";
				     		                     break;
				     		            case 3:
				     		            	 str1 += "<td>" +
				     		                	 "<a class='btn btn-info' href='javascript:deleteAct(\""+act1.actNo+"\")' role='button'>删除</a>";
				     		                	 break;
				     		            case 4:
				     		            	 str1 += "<td>" + moment(act1.actPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
				     		                	 "<a class='btn btn-default' href='javascript:recoverAct(\""+act1.actNo+"\")' role='button'>恢复</a>"+
				     		                     "<a class='btn btn-info' href='javascript:deleteAct(\""+act1.actNo+"\")' role='button'>彻底删除</a>";
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










function toLookAct(actNo){
	var location = (window.location+'').split('/');  
	var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
	$.ajax({
		type:"post",
		url:basePath+"/act/findActByActNo.do",
		data:"actNo="+actNo, 
		dataType:"json",
		success:function(data){
			var src = '/upload/act/'+data.actPic;
			$("#lactTitle").val(data.actTitle);
			$("#lactContent").html(data.actContent);
			$("#lactPic").attr('src', src);
			changeContentImgSize('lactContent');
		}
	});
}

function toAlertAct(actNo){
	var location = (window.location+'').split('/');  
	var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
	$.ajax({
		type:"post",
		url:basePath+"/act/findActByActNo.do",
		data:"actNo="+actNo, 
		dataType:"json",
		success:function(data){
			var src = '/upload/act/'+data.actPic;
			$("#aactNo").val(data.actNo);
			$("#auserNo").val(data.userNo);
			$("#aactNum").val(data.actNum);
			$("#aactState").val(data.actState);
			$("#aactTitle").val(data.actTitle);
			$("#simple-editor").html(data.actContent);
			$("#actAlertPic").attr('src', src);
			$("#aactPubTime").val(data.actPubTime);
		}
	});
}






function passAct(actNo){
	if(confirm("通过该活动申请？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/act/passAct.do",
			data:"actNo="+actNo, 
			dataType:"json",
			success:function(data){
				if(data.passState==1){
					alert(data.passMsg);
					loadAct();
				}
				else if(data.passState==0){
					alert(data.passMsg);
				}
				
			}
		});
		}
}




function failAct(actNo){
	if(confirm("否决该活动申请？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/act/failAct.do",
			data:"actNo="+actNo, 
			dataType:"json",
			success:function(data){
				if(data.failState==1){
					alert(data.failMsg);
					loadAct();
				}
				else if(data.failState==0){
					alert(data.failMsg);
				}
				
			}
		});
		}
}




function overdueAct(actNo){
	if(confirm("活动将变更为过期状态")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/act/overdueAct.do",
			data:"actNo="+actNo, 
			dataType:"json",
			success:function(data){
				if(data.overdueState==1){
					alert(data.overdueMsg);
					loadAct();
				}
				else if(data.overdueState==0){
					alert(data.overdueMsg);
				}
				
			}
		});
		}
	
}





function deleteAct(actNo){
	if(confirm("彻底删除该活动？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/act/deleteAct.do",
			data:"actNo="+actNo, 
			dataType:"json",
			success:function(data){
				if(data.deleteState==1){
					alert(data.deleteMsg);
					loadAct();
				}
				else if(data.deleteState==0){
					alert(data.deleteMsg);
				}
				
			}
		});
		}
	
}




function recoverAct(actNo){
	if(confirm("恢复该活动到已发布状态？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/act/recoverAct.do",
			data:"actNo="+actNo, 
			dataType:"json",
			success:function(data){
				if(data.recoverState==1){
					alert(data.recoverMsg);
					loadAct();
				}
				else if(data.recoverState==0){
					alert(data.recoverMsg);
				}
				
			}
		});
		}
	
}

