
function submitSearch(){
	var searchUserName = $("#searchUserName").val();
	var searchNoticeTitle = $("#searchNoticeTitle").val();
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
	
	if(searchNoticeTitle != null && searchNoticeTitle !=""){
		if(forMatTitle.test(searchNoticeTitle) != true){
			alert("标题格式不正确！");
			$("#searchNoticeTitle").focus();
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
	var action = "getNoticeCondition.do";
	$.ajax({
		type:"post",
		url:basePath+"/notice/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&actState="+actState+
		"&userName="+searchUserName+
		"&noticeTitle="+searchNoticeTitle+
		"&searchStartTime="+searchStartTime+
		"&searchEndTime="+searchEndTime,
		dataType:"json",
		success:function(data){
			$("#tbody").html("");
			 var str = "";  
			 $(data.data).each(function(i,notice){ 
				 str += "<tr class='success'>" +  
                 "<td class='noticeTitleTd'>";
                 var noticeTitle = notice.noticeTitle;
                 if(noticeTitle.length > 14){
                	 noticeTitle = noticeTitle.substring(0,14) + "...";
                 }
                 str += noticeTitle + "</td>" + 
                 "<td>" + notice.userName + "</td>"; 
                 switch(Number(notice.noticeState)){
					case 1:
						 str += "<td>" + moment(notice.noticePubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
		                	 "<a class='btn btn-default' data-toggle='modal' data-target='#look' onclick='toLookNotice(\""+notice.noticeNo+"\")' role='button'>查看</a>"+
		                	 "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertNotice(\""+notice.noticeNo+"\")' role='button'>修改</a>"+
		                	 "<a class='btn btn-info' href='javascript:overdueNotice(\""+notice.noticeNo+"\")' role='button'>删除</a>";
		                     break;
					case 2:
						 str += "<td>" +
							 "<a class='btn btn-default' href='javascript:recoverNotice(\""+notice.noticeNo+"\")' role='button'>恢复</a>"+
		                     "<a class='btn btn-info' href='javascript:deleteNotice(\""+notice.noticeNo+"\")' role='button'>彻底删除</a>";
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
			            	url:"<%=basePath%>notice/"+action,
			            	data:"pageNow="+page+"&pageSize="+pageSize+"&actState="+actState+
			        		"&userName="+searchUserName+
			        		"&noticeTitle="+searchNoticeTitle+
			        		"&searchStartTime="+searchStartTime+
			        		"&searchEndTime="+searchEndTime,
			          		dataType:"json",
			                success: function (msg) {
			                	var str1 = ""; 
			                	  $(msg.data).each(function(i,notice1){ 
			                		  str1 += "<tr class='success'>" +  
			                          "<td class='noticeTitleTd'>";
			                          var noticeTitle1 = notice1.noticeTitle;
			                          if(noticeTitle1.length > 14){
			                         	 noticeTitle1 = noticeTitle1.substring(0,14) + "...";
			                          }
			                          str += noticeTitle1 + "</td>" + 
			                          "<td>" + notice1.userName + "</td>"; 
			                		  switch(Number(notice1.noticeState)){
				      				  	case 1:
				      						 str += "<td>" + moment(notice.noticePubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
				      		                	 "<a class='btn btn-default' data-toggle='modal' data-target='#look' onclick='toLookNotice(\""+notice1.noticeNo+"\")' role='button'>查看</a>"+
				      		                	 "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertNotice(\""+notice1.noticeNo+"\")' role='button'>修改</a>"+
				      		                	 "<a class='btn btn-info' href='javascript:overdueNotice(\""+notice1.noticeNo+"\")' role='button'>删除</a>";
				      		                     break;
				      				 	case 2:
				      						 str += "<td>" +
				      							 "<a class='btn btn-default' href='javascript:recoverNotice(\""+notice1.noticeNo+"\")' role='button'>恢复</a>"+
				      		                     "<a class='btn btn-info' href='javascript:deleteNotice(\""+notice1.noticeNo+"\")' role='button'>彻底删除</a>";
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




function toLookNotice(noticeNo){
	var location = (window.location+'').split('/');  
	var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
	$.ajax({
		type:"post",
		url:basePath+"/notice/findNoticeByNoticeNo.do",
		data:"noticeNo="+noticeNo, 
		dataType:"json",
		success:function(data){
			$("#lnoticeTitle").val(data.noticeTitle);
			$("#lnoticeContent").html(data.noticeContent);
		}
	});
}





function toAlertNotice(noticeNo){
	var location = (window.location+'').split('/');  
	var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
	$.ajax({
		type:"post",
		url:basePath+"/notice/findNoticeByNoticeNo.do",
		data:"noticeNo="+noticeNo, 
		dataType:"json",
		success:function(data){
			$("#anoticeNo").val(data.noticeNo);
			$("#auserNo").val(data.userNo);
			$("#anoticeState").val(data.noticeState);
			$("#anoticeTitle").val(data.noticeTitle);
			$("#simple-editor").html(data.noticeContent);
			$("#anoticePubTime").val(data.noticePubTime);
		}
	});
}



function overdueNotice(noticeNo){
	if(confirm("公告将变更为过期状态")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/notice/overdueNotice.do",
			data:"noticeNo="+noticeNo, 
			dataType:"json",
			success:function(data){
				if(data.overdueState==1){
					alert(data.overdueMsg);
					loadNotice();
				}
				else if(data.overdueState==0){
					alert(data.overdueMsg);
				}
				
			}
		});
		}
	
}





function deleteNotice(noticeNo){
	if(confirm("彻底删除该公告？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/notice/deleteNotice.do",
			data:"noticeNo="+noticeNo, 
			dataType:"json",
			success:function(data){
				if(data.deleteState==1){
					alert(data.deleteMsg);
					loadNotice();
				}
				else if(data.deleteState==0){
					alert(data.deleteMsg);
				}
				
			}
		});
		}
	
}




function recoverNotice(noticeNo){
	if(confirm("恢复该活动到已发布状态？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/notice/recoverNotice.do",
			data:"noticeNo="+noticeNo, 
			dataType:"json",
			success:function(data){
				if(data.recoverState==1){
					alert(data.recoverMsg);
					loadNotice();
				}
				else if(data.recoverState==0){
					alert(data.recoverMsg);
				}
				
			}
		});
		}
	
}

