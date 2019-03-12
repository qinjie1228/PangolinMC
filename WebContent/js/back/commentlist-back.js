
function submitSearch(){
	var searchUserName = $("#searchUserName").val();
	var searchPostTitle = $("#searchPostTitle").val();
	var searchCommentContent = $("#searchCommentContent").val();
	var searchStartTime = $("#searchStartTime").val();
	var searchEndTime = $("#searchEndTime").val();
	
	var forMatUserName =/^[\u4e00-\u9fa5a-zA-Z0-9]{3,32}$/;
	var forMatTitle = /^[\w\u4e00-\u9fa5~!@#$%^&*()+-_={}|\/:;/'/"”‘？’“、：,，。.?<>{}]{2,1000}$/;
	var forMatContent = /^[\w\u4e00-\u9fa5~!@#$%^&*()+-_={}|\/:;/'/"”‘？’“、：,，。.?<>{}]{2,1000}$/;
	var forMatTime = /^[0-9]{4}-(0?[0-9]|1[0-2])-(0?[1-9]|[12]?[0-9]|3[01])$/;
	if(searchPostTitle != null && searchPostTitle !=""){
		if(forMatTitle.test(searchPostTitle) != true){
			alert("标题格式不正确！");
			$("#searchPostTitle").focus();
			return;
		}
	}
	
	if(searchCommentContent != null && searchCommentContent !=""){
		if(forMatContent.test(searchCommentContent) != true){
			alert("内容格式不正确！");
			$("#searchCommentContent").focus();
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
	var action = "getCommentCondition.do";
	$.ajax({
		type:"post",
		url:basePath+"/comment/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&commentState="+commentState+
		"&userName="+searchUserName+
		"&postTitle="+searchPostTitle+
		"&commentContent="+searchCommentContent+
		"&searchStartTime="+searchStartTime+
		"&searchEndTime="+searchEndTime,
		dataType:"json",
		success:function(data){
			$("#tbody").html("");
			 var str = "";  
			 $(data.data).each(function(i,comment){ 
				 str += "<tr class='success'><td>";
				 var postTitle = comment.postTitle;
                 if(postTitle.length > 26){
                	 postTitle = postTitle.substring(0,26) + "...";
                 }
                 str += postTitle + "</td><td>" + comment.userName + "</td><td>";
                 var commentContent = comment.commentContent;
                 if(commentContent.length > 20){
                	 commentContent = commentContent.substring(0,20) + "...";
                 }
                 str += commentContent + "</td>";
                 switch(Number(comment.commentState)){
					case 1:
						 str += "<td>" + moment(comment.commentPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
		                	 "<a class='btn btn-default' data-toggle='modal' data-target='#look' onclick='toLookComment(\""+comment.commentNo+"\")' role='button'>查看</a>"+
		                	 "<a class='btn btn-info' href='javascript:overdueComment(\""+comment.commentNo+"\")' role='button'>删除</a>";
		                     break;
					case 2:
						 str += "<td>" +
							 "<a class='btn btn-default' href='javascript:recoverComment(\""+comment.commentNo+"\")' role='button'>恢复</a>"+
		                     "<a class='btn btn-info' href='javascript:deleteComment(\""+comment.commentNo+"\")' role='button'>删除</a>";
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
			            	url:basePath+"/comment/"+action,
			        		data:"pageNow="+page+"&pageSize="+pageSize+"&commentState="+commentState+
			        		"&userName="+searchUserName+
			        		"&postTitle="+searchPsearchPostTitle+
			        		"&commentContent="+searchCommentContent+
			        		"&searchStartTime="+searchStartTime+
			        		"&searchEndTime="+searchEndTime,
			          		dataType:"json",
			                success: function (msg) {
			                	var str1 = ""; 
			                	$(msg.data).each(function(i,comment1){ 
				                		  str1 += "<tr class='success'><td>";
				         				  var postTitle1 = comment1.postTitle;
				                          if(postTitle1.length > 26){
				                         	 postTitle1 = postTitle1.substring(0,26) + "...";
				                          }
				                          str1 += postTitle1 + "</td><td>" + comment1.userName + "</td><td>";
				                          var commentContent1 = comment1.commentContent;
				                          if(commentContent1.length > 20){
				                         	 commentContent1 = commentContent1.substring(0,20) + "...";
				                          }
				                          str1 += commentContent1 + "</td>";
				                         switch(Number(comment1.commentState)){
				        					case 1:
				        						 str += "<td>" + moment(comment1.commentPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
				        		                	 "<a class='btn btn-default' data-toggle='modal' data-target='#look' onclick='toLookComment(\""+comment1.commentNo+"\")' role='button'>查看</a>"+
				        		                	 "<a class='btn btn-info' href='javascript:overdueComment(\""+comment1.commentNo+"\")' role='button'>删除</a>";
				        		                     break;
				        					case 2:
				        						 str += "<td>" +
				        							 "<a class='btn btn-default' href='javascript:recoverComment(\""+comment1.commentNo+"\")' role='button'>恢复</a>"+
				        		                     "<a class='btn btn-info' href='javascript:deleteComment(\""+comment1.commentNo+"\")' role='button'>删除</a>";
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










function toLookComment(commentNo){
	var location = (window.location+'').split('/');  
	var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
	$.ajax({
		type:"post",
		url:basePath+"/comment/findCommentByCommentNo.do",
		data:"commentNo="+commentNo, 
		dataType:"json",
		success:function(data){
			$("#lpostTitle").val(data.postTitle);
			$("#lcommentContent").html(data.commentContent);
		}
	});
}



function overdueComment(commentNo){
	if(confirm("评语将变更为过期状态")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/comment/overdueComment.do",
			data:"commentNo="+commentNo, 
			dataType:"json",
			success:function(data){
				if(data.overdueState==1){
					alert(data.overdueMsg);
					loadComment();
				}
				else if(data.overdueState==0){
					alert(data.overdueMsg);
				}
				
			}
		});
		}
	
}





function deleteComment(commentNo){
	if(confirm("彻底删除该评语？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/comment/deleteComment.do",
			data:"commentNo="+commentNo, 
			dataType:"json",
			success:function(data){
				if(data.deleteState==1){
					alert(data.deleteMsg);
					loadComment();
				}
				else if(data.deleteState==0){
					alert(data.deleteMsg);
				}
				
			}
		});
		}
	
}




function recoverComment(commentNo){
	if(confirm("恢复该评语到已发布状态？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/comment/recoverComment.do",
			data:"commentNo="+commentNo, 
			dataType:"json",
			success:function(data){
				if(data.recoverState==1){
					alert(data.recoverMsg);
					loadComment();
				}
				else if(data.recoverState==0){
					alert(data.recoverMsg);
				}
				
			}
		});
		}
	
}

