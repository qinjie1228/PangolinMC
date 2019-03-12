
function submitSearch(){
	var searchUserName = $("#searchUserName").val();
	var searchUserRealName = $("#searchUserRealName").val();
	var searchUserAge = $("#searchUserAge").val();
	var searchUserSex = $("#searchUserSex").val();
	var searchUserEmail = $("#searchUserEmail").val();
	var searchStartTime = $("#searchStartTime").val();
	var searchEndTime = $("#searchEndTime").val();
	
	var forMatName =/^[\u4e00-\u9fa5a-zA-Z0-9]{3,32}$/;
	var forMatRealName =/^[\u4E00-\u9FA5]{2,32}/;
	var forMatAge = /^[0-9]{2,3}$/;
	var forMatEmail = /^[A-Za-zd]+([-_.][A-Za-zd]+)*@([A-Za-zd]+[-.])+[A-Za-zd]{2,5}$/;
	var forMatTime = /^[0-9]{4}-(0?[0-9]|1[0-2])-(0?[1-9]|[12]?[0-9]|3[01])$/;
	
	if(searchUserName != null && searchUserName !=""){
		if(forMatName.test(searchUserName) != true){
			alert("请输入正确的用户名！");
			$("#searchUserName").focus();
			return;
		}
	}
	
	if(searchUserRealName != null && searchUserRealName !=""){
		if(forMatRealName.test(searchUserRealName) != true){
			alert("姓名格式不正确！");
			$("#searchUserRealName").focus();
			return;
		}
	}
	
	if(searchUserAge != null && searchUserAge !=""){
		if(forMatAge.test(searchUserAge) != true){
			alert("年龄格式不正确！");
			$("#searchUserAge").focus();
			return;
		}
	}
	
	if(searchUserSex != null && searchUserSex !=""){
		if(searchUserSex !="男" && searchUserSex !="女"){
			alert("请输入正确的性别！");
			$("#searchUserSex").focus();
			return;
		}
	}
	
	if(searchUserEmail != null && searchUserEmail !=""){
		if(forMatEmail.test(searchUserEmail) != true){
			alert("邮箱格式不正确！");
			$("#searchUserEmail").focus();
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
	var action = "getUserCondition.do";
	$.ajax({
		type:"post",
		url:basePath+"/user/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&userState="+userState+
		"&userName="+searchUserName+
		"&userRealName="+searchUserRealName+
		"&userAge="+searchUserAge+
		"&userSex="+searchUserSex+
		"&userEmail="+searchUserEmail+
		"&searchStartTime="+searchStartTime+
		"&searchEndTime="+searchEndTime, 
		dataType:"json",
		success:function(data){
			$("#tbody").html("");
			 var str = "";  
			 $(data.data).each(function(i,user){ 
				 str += "<tr class='success'>" +  
               "<td>" + user.userName + "</td>" +  
               "<td>" + user.userRealName + "</td>" +  
               "<td>" + user.userAge + "</td>" +  
               "<td>" + user.userSex + "</td>" +  
               "<td>" + user.userEmail + "</td>" +  
               "<td>" + moment(user.userRegTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" +  
               "<td>";
                 switch(Number(user.userState)){
					case 1:
						 str += 
							 "<a class='btn btn-default' href='javascript:promoteUser(\""+user.userNo+"\")' role='button'>升级</a>"+
							 "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertUser(\""+user.userNo+"\")' role='button'>修改</a>"+
							 "<a class='btn btn-info' href='javascript:overdueUser(\""+user.userNo+"\")' role='button'>删除</a>";
		                     break;
					case 2:
						 str +=
							 "<a class='btn btn-default' href='javascript:promoteUser(\""+user.userNo+"\")' role='button'>升级</a>"+
							 "<a class='btn btn-default' href='javascript:degradeUser(\""+user.userNo+"\")' role='button'>降级</a>"+
							 "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertUser(\""+user.userNo+"\")' role='button'>修改</a>"+
							 "<a class='btn btn-info' href='javascript:overdueUser(\""+user.userNo+"\")' role='button'>删除</a>";
		                     break;
		            case 3:
		            	 str +=
							 "<a class='btn btn-default' href='javascript:degradeUser(\""+user.userNo+"\")' role='button'>降级</a>"+
							 "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertUser(\""+user.userNo+"\")' role='button'>修改</a>"+
							 "<a class='btn btn-info' href='javascript:overdueUser(\""+user.userNo+"\")' role='button'>删除</a>";
		                     break;
		            case 4:
		            	 str +=
		            		"<a class='btn btn-info' href='javascript:deleteUser(\""+user.userNo+"\")' role='button'>删除</a>";
		                     break;
		            case 6:
		            	 str +=
		                    "<a class='btn btn-default' href='javascript:recoverUser(\""+user.userNo+"\")' role='button'>恢复</a>"+
		   				    "<a class='btn btn-info' href='javascript:deleteUser(\""+user.userNo+"\")' role='button'>彻底删除</a>"; 
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
			          		url:basePath+"/user/"+action,
			          		data:"pageNow="+page+"&pageSize="+pageSize+"&userState="+userState+
			          		"&userName="+searchUserName+
			          		"&userRealName="+searchUserRealName+
			          		"&userAge="+searchUserAge+
			          		"&userSex="+searchUserSex+
			          		"&userEmail="+searchUserEmail+
			          		"&searchStartTime="+searchStartTime+
			          		"&searchEndTime="+searchEndTime, 
			          		dataType:"json",
			                success: function (msg) {
			                	var str1 = ""; 
			                	  $(msg.data).each(function(i,user1){ 
			         				 str1 += "<tr class='success'>" +  
			                          "<td>" + user1.userName + "</td>" +  
			                          "<td>" + user1.userRealName + "</td>" +  
			                          "<td>" + user1.userAge + "</td>" +  
			                          "<td>" + user1.userSex + "</td>" +  
			                          "<td>" + user1.userEmail + "</td>" +  
			                          "<td>" + moment(user1.userRegTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" +  
			                          "<td>";
			                          switch(Number(user1.userState)){
				      					case 1:
				      						 str1 += 
				      							 "<a class='btn btn-default' href='javascript:promoteUser(\""+user1.userNo+"\")' role='button'>升级</a>"+
				      							 "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertUser(\""+user1.userNo+"\")' role='button'>修改</a>"+
				      							 "<a class='btn btn-info' href='javascript:overdueUser(\""+user1.userNo+"\")' role='button'>删除</a>";
				      		                     break;
				      					case 2:
				      						 str1 +=
				      							 "<a class='btn btn-default' href='javascript:promoteUser(\""+user1.userNo+"\")' role='button'>升级</a>"+
				      							 "<a class='btn btn-default' href='javascript:degradeUser(\""+user1.userNo+"\")' role='button'>降级</a>"+
				      							 "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertUser(\""+user1.userNo+"\")' role='button'>修改</a>"+
				      							 "<a class='btn btn-info' href='javascript:overdueUser(\""+user1.userNo+"\")' role='button'>删除</a>";
				      		                     break;
				      		            case 3:
				      		            	 str1 +=
				      							 "<a class='btn btn-default' href='javascript:degradeUser(\""+user1.userNo+"\")' role='button'>降级</a>"+
				      							 "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertUser(\""+user1.userNo+"\")' role='button'>修改</a>"+
				      							 "<a class='btn btn-info' href='javascript:overdueUser(\""+user1.userNo+"\")' role='button'>删除</a>";
				      		                     break;
				      		            case 4:
				      		            	 str1 +=
				      		            		"<a class='btn btn-info' href='javascript:deleteUser(\""+user1.userNo+"\")' role='button'>删除</a>";
				      		                     break;
				      		            case 6:
				      		            	 str1 +=
				      		                    "<a class='btn btn-default' href='javascript:recoverUser(\""+user1.userNo+"\")' role='button'>恢复</a>"+
				      		   				    "<a class='btn btn-info' href='javascript:deleteUser(\""+user1.userNo+"\")' role='button'>彻底删除</a>"; 
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




function degradeUser(userNo){
	if(confirm("确认降级该用户？")){
	var location = (window.location+'').split('/');  
	var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

	$.ajax({
		type:"post",
		url:basePath+"/user/degradeUser.do",
		data:"userNo="+userNo, 
		dataType:"json",
		success:function(data){
			if(data.degradeState==1){
				alert(data.degradeMsg);
				loadUser();
			}
			else if(data.degradeState==0){
				alert(data.degradeMsg);
			}
			
		}
	});
	}
}



function promoteUser(userNo){
	if(confirm("确认提升该用户等级？")){
	var location = (window.location+'').split('/');  
	var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

	$.ajax({
		type:"post",
		url:basePath+"/user/promoteUser.do",
		data:"userNo="+userNo, 
		dataType:"json",
		success:function(data){
			if(data.promoteState==1){
				alert(data.promoteMsg);
				loadUser();
			}
			else if(data.promoteState==0){
				alert(data.promoteMsg);
			}
			
		}
	});
	}
}



function overdueUser(userNo){
	if(confirm("用户状态将变更为过期状态")){
	var location = (window.location+'').split('/');  
	var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

	$.ajax({
		type:"post",
		url:basePath+"/user/overdueUser.do",
		data:"userNo="+userNo, 
		dataType:"json",
		success:function(data){
			if(data.overdueState==1){
				alert(data.overdueMsg);
				loadUser();
			}
			else if(data.overdueState==0){
				alert(data.overdueMsg);
			}
			
		}
	});
	}
}




function toAlertUser(userNo){
	var location = (window.location+'').split('/');  
	var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
	$.ajax({
		type:"post",
		url:basePath+"/user/findUserByUserNo.do",
		data:"userNo="+userNo, 
		dataType:"json",
		success:function(data){
			$("#auserNo").val(data.userNo);
			$("#auserPwd").val(data.userPwd);
			$("#auserState").val(data.userState);
			$("#auserName").val(data.userName);
			$("#auserRealName").val(data.userRealName);
			$("#auserAddress").val(data.userAddress);
			$("#auserEmail").val(data.userEmail);
			$("#auserPic").val(data.userPic);
			$("#auserAge").val(data.userAge);
			$("#auserSex").val(data.userSex);
		}
	});
}



function recoverUser(userNo){
	if(confirm("恢复用户至初级状态？")){
	var location = (window.location+'').split('/');  
	var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

	$.ajax({
		type:"post",
		url:basePath+"/user/recoverUser.do",
		data:"userNo="+userNo, 
		dataType:"json",
		success:function(data){
			if(data.recoverState==1){
				alert(data.recoverMsg);
				loadUser();
			}
			else if(data.recoverState==0){
				alert(data.recoverMsg);
			}
			
		}
	});
	}
}




function deleteUser(userNo){
	var alertMsg ="";
	if(userState == 4){
		alertMsg ="彻底删除管理员？";
	}
	else{
		alertMsg ="彻底删除用户？";
	}
	if(confirm(alertMsg)){
	var location = (window.location+'').split('/');  
	var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

	$.ajax({
		type:"post",
		url:basePath+"/user/deleteUser.do",
		data:"userNo="+userNo, 
		dataType:"json",
		success:function(data){
			if(data.deleteState==1){
				alert(data.deleteMsg);
				loadUser();
			}
			else if(data.deleteState==0){
				alert(data.deleteMsg);
			}
			
		}
	});
	}
}
