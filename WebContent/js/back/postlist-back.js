
function submitSearch(){
	var searchUserName = $("#searchUserName").val();
	var searchPostTitle = $("#searchPostTitle").val();
	var searchPostCategory = $("#searchPostCategory").val();
	var searchPostScanNum = $("#searchPostScanNum").val();
	var searchPostCommentNum = $("#searchPostCommentNum").val();
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
	
	if(searchPostTitle != null && searchPostTitle !=""){
		if(forMatTitle.test(searchPostTitle) != true){
			alert("标题格式不正确！");
			$("#searchPostTitle").focus();
			return;
		}
	}
	
	if(searchPostScanNum != null && searchPostScanNum !=""){
		if(forMatNum.test(searchPostScanNum) != true){
			alert("浏览量请输入数字！");
			$("#searchPostScanNum").focus();
			return;
		}
	}
	
	if(searchPostCommentNum != null && searchPostCommentNum !=""){
		if(forMatNum.test(searchPostCommentNum) != true){
			alert("评论量请输入数字！");
			$("#searchPostCommentNum").focus();
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
	var action = "getPostCondition.do";
	$.ajax({
		type:"post",
		url:basePath+"/post/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&postState="+postState+
		"&userName="+searchUserName+
		"&postTitle="+searchPostTitle+
		"&postCategory="+searchPostCategory+
		"&postScanNum="+searchPostScanNum+
		"&postCommentNum="+searchPostCommentNum+
		"&searchStartTime="+searchStartTime+
		"&searchEndTime="+searchEndTime,
		dataType:"json",
		success:function(data){
			$("#tbody").html("");
			 var str = "";  
			 $(data.data).each(function(i,post){ 
				 str += "<tr class='success'>" +  
                 "<td class='postTitleTd'>";
                 var postTitle = post.postTitle;
                 if(postTitle.length > 13){
                	 postTitle = postTitle.substring(0,13) + "...";
                 }
                 str += postTitle + "</td>" + 
                 "<td>" + post.userName + "</td>" + 
                 "<td>" + post.postCategory + "</td>" + 
                 "<td>" + post.postScanNum + "</td>" +
                 "<td>" + post.postCommentNum + "</td>";  
                 switch(Number(post.postState)){
					case 6:
						 str += "<td>" +
		                	 "<a class='btn btn-default' data-toggle='modal' data-target='#look' onclick='toLookPost(\""+post.postNo+"\")' role='button'>查看</a>"+
		                     "<a class='btn btn-default' href='javascript:passPost(\""+post.postNo+"\")' role='button'>通过</a>"+
		                     "<a class='btn btn-info' href='javascript:failPost(\""+post.postNo+"\")' role='button'>否决</a>";
		                     break;
					case 1:
						 str += "<td>" + moment(post.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertPost(\""+post.postNo+"\")' role='button'>修改</a>"+
		                     "<a class='btn btn-info' href='javascript:passPost(\""+post.postNo+"\")' role='button'>置精</a>" +
/*		                     "<a class='btn btn-info' href='javascript:hotPost(\""+post.postNo+"\")' role='button'>置热</a>" +*/
		                     "<a class='btn btn-info' href='javascript:topPost(\""+post.postNo+"\")' role='button'>置顶</a>" +
		                     "<a class='btn btn-info' href='javascript:overduePost(\""+post.postNo+"\")' role='button'>删除</a>";
		                     break;
		            case 2:
		            	str += "<td>" + moment(post.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertPost(\""+post.postNo+"\")' role='button'>修改</a>"+
		                     "<a class='btn btn-info' href='javascript:commonPost(\""+post.postNo+"\")' role='button'>置普</a>" +
/*		                     "<a class='btn btn-info' href='javascript:hotPost(\""+post.postNo+"\")' role='button'>置热</a>" +*/
		                     "<a class='btn btn-info' href='javascript:topPost(\""+post.postNo+"\")' role='button'>置顶</a>" +
		                     "<a class='btn btn-info' href='javascript:overduePost(\""+post.postNo+"\")' role='button'>删除</a>";
	                     break;
/*		            case 3:
		            	str += "<td>" + moment(post.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertPost(\""+post.postNo+"\")' role='button'>修改</a>"+
		                     "<a class='btn btn-info' href='javascript:commonPost(\""+post.postNo+"\")' role='button'>置普</a>" +
		                     "<a class='btn btn-info' href='javascript:passPost(\""+post.postNo+"\")' role='button'>置精</a>" +
		                     "<a class='btn btn-info' href='javascript:topPost(\""+post.postNo+"\")' role='button'>置顶</a>" +
		                     "<a class='btn btn-info' href='javascript:overduePost(\""+post.postNo+"\")' role='button'>删除</a>";
	                     break;*/
		            case 4:
		            	str += "<td>" + moment(post.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertPost(\""+post.postNo+"\")' role='button'>修改</a>"+
		                     "<a class='btn btn-info' href='javascript:commonPost(\""+post.postNo+"\")' role='button'>置普</a>" +
		                     "<a class='btn btn-info' href='javascript:passPost(\""+post.postNo+"\")' role='button'>置精</a>" +
/*		                     "<a class='btn btn-info' href='javascript:topPost(\""+post.postNo+"\")' role='button'>置热</a>" +*/
		                     "<a class='btn btn-info' href='javascript:overduePost(\""+post.postNo+"\")' role='button'>删除</a>";
	                     break;
		            case 5:
						 str += "<td>" +
		                     "<a class='btn btn-default' href='javascript:commonPost(\""+post.postNo+"\")' role='button'>恢复</a>"+
		                     "<a class='btn btn-info' href='javascript:deletePost(\""+post.postNo+"\")' role='button'>删除</a>";
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
			            	url:basePath+"/post/"+action,
			        		data:"pageNow="+page+"&pageSize="+pageSize+"&postState="+postState+
			        		"&userName="+searchUserName+
			        		"&postTitle="+searchPostTitle+
			        		"&postCategory="+searchPostCategory+
			        		"&searchStartTime="+searchStartTime+
			        		"&searchEndTime="+searchEndTime,
			          		dataType:"json",
			                success: function (msg) {
			                	var str1 = ""; 
			                	  $(msg.data).each(function(i,post1){ 
			                		     str1 += "<tr class='success'>" +  
				                         "<td class='postTitleTd'>";
				         				 var postTitle1 = post1.postTitle;
				                         if(postTitle1.length > 13){
				                       	 postTitle1 = postTitle1.substring(0,13) + "...";
				                         }
				                         str1 += postTitle1 + "</td>" + 
				                         "<td>" + post1.userName + "</td>" + 
				                         "<td>" + post1.postCategory + "</td>" + 
				                         "<td>" + post1.postScanNum + "</td>" +
				                         "<td>" + post1.postCommentNum + "</td>";  
				                         switch(Number(post1.postState)){
				        					case 6:
				        						 str1 += "<td>" +
				        		                	 "<a class='btn btn-default' data-toggle='modal' data-target='#look' onclick='toLookPost(\""+post1.postNo+"\")' role='button'>查看</a>"+
				        		                     "<a class='btn btn-default' href='javascript:passPost(\""+post1.postNo+"\")' role='button'>通过</a>"+
				        		                     "<a class='btn btn-info' href='javascript:failPost(\""+post1.postNo+"\")' role='button'>否决</a>";
				        		                     break;
				        					case 1:
				        						 str1 += "<td>" + moment(post1.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
				        		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertPost(\""+post1.postNo+"\")' role='button'>修改</a>"+
				        		                     "<a class='btn btn-info' href='javascript:passPost(\""+post1.postNo+"\")' role='button'>置精</a>" +
/*				        		                     "<a class='btn btn-info' href='javascript:hotPost(\""+post1.postNo+"\")' role='button'>置热</a>" +*/
				        		                     "<a class='btn btn-info' href='javascript:topPost(\""+post1.postNo+"\")' role='button'>置顶</a>" +
				        		                     "<a class='btn btn-info' href='javascript:overduePost(\""+post1.postNo+"\")' role='button'>删除</a>";
				        		                     break;
				        		            case 2:
				        		            	str1 += "<td>" + moment(post1.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
				        		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertPost(\""+post1.postNo+"\")' role='button'>修改</a>"+
				        		                     "<a class='btn btn-info' href='javascript:commonPost(\""+post1.postNo+"\")' role='button'>置普</a>" +
/*				        		                     "<a class='btn btn-info' href='javascript:hotPost(\""+post1.postNo+"\")' role='button'>置热</a>" +*/
				        		                     "<a class='btn btn-info' href='javascript:topPost(\""+post1.postNo+"\")' role='button'>置顶</a>" +
				        		                     "<a class='btn btn-info' href='javascript:overduePost(\""+post1.postNo+"\")' role='button'>删除</a>";
				        	                     break;
				        		            case 3:
				        		            	str1 += "<td>" + moment(post1.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
				        		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertPost(\""+post1.postNo+"\")' role='button'>修改</a>"+
				        		                     "<a class='btn btn-info' href='javascript:commonPost(\""+post1.postNo+"\")' role='button'>置普</a>" +
				        		                     "<a class='btn btn-info' href='javascript:passPost(\""+post1.postNo+"\")' role='button'>置精</a>" +
				        		                     "<a class='btn btn-info' href='javascript:topPost(\""+post1.postNo+"\")' role='button'>置顶</a>" +
				        		                     "<a class='btn btn-info' href='javascript:overduePost(\""+post1.postNo+"\")' role='button'>删除</a>";
				        	                     break;
				        		            case 4:
				        		            	str1 += "<td>" + moment(post1.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
				        		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertPost(\""+post1.postNo+"\")' role='button'>修改</a>"+
				        		                     "<a class='btn btn-info' href='javascript:commonPost(\""+post1.postNo+"\")' role='button'>置普</a>" +
				        		                     "<a class='btn btn-info' href='javascript:passPost(\""+post1.postNo+"\")' role='button'>置精</a>" +
/*				        		                     "<a class='btn btn-info' href='javascript:topPost(\""+post1.postNo+"\")' role='button'>置热</a>" +*/
				        		                     "<a class='btn btn-info' href='javascript:overduePost(\""+post1.postNo+"\")' role='button'>删除</a>";
				        	                     break;
				        		            case 5:
				        						 str1 += "<td>" +
				        		                     "<a class='btn btn-default' href='javascript:recoverPost(\""+post1.postNo+"\")' role='button'>恢复</a>"+
				        		                     "<a class='btn btn-info' href='javascript:deletePost(\""+post1.postNo+"\")' role='button'>删除</a>";
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










function toLookPost(postNo){
	var location = (window.location+'').split('/');  
	var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
	$.ajax({
		type:"post",
		url:basePath+"/post/findPostByPostNo.do",
		data:"postNo="+postNo, 
		dataType:"json",
		success:function(data){
			var src = '/upload/post/'+data.postPic;
			$("#lpostTitle").val(data.postTitle);
			$("#lpostCategory").val(data.postCategory);
			$("#lpostPic").attr('src', src);
			$("#lpostContent").html(data.postContent);
			changeContentImgSize('lpostContent');
		}
	});
}


function toAlertPost(postNo){
	var location = (window.location+'').split('/');  
	var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
	$.ajax({
		type:"post",
		url:basePath+"/post/findPostByPostNo.do",
		data:"postNo="+postNo, 
		dataType:"json",
		success:function(data){
			var src = '/upload/post/'+data.postPic;
			$("#apostNo").val(data.postNo);
			$("#auserNo").val(data.userNo);
			$("#apostCategory").val(data.postCategory);
			$("#apostState").val(data.postState);
			$("#apostTitle").val(data.postTitle);
			$("#simple-editor").html(data.postContent);
			$("#postAlertPic").attr('src', src);
		}
	});
}






function passPost(postNo){
	if(confirm("通过该精品帖子申请？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/post/passPost.do",
			data:"postNo="+postNo, 
			dataType:"json",
			success:function(data){
				if(data.passState==1){
					alert(data.passMsg);
					loadPost();
				}
				else if(data.passState==0){
					alert(data.passMsg);
				}
				
			}
		});
		}
}




function failPost(postNo){
	if(confirm("否决该精品帖子申请？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/post/failPost.do",
			data:"postNo="+postNo, 
			dataType:"json",
			success:function(data){
				if(data.failState==1){
					alert(data.failMsg);
					loadPost();
				}
				else if(data.failState==0){
					alert(data.failMsg);
				}
				
			}
		});
		}
}




function overduePost(postNo){
	if(confirm("帖子将变更为过期状态")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/post/overduePost.do",
			data:"postNo="+postNo, 
			dataType:"json",
			success:function(data){
				if(data.overdueState==1){
					alert(data.overdueMsg);
					loadPost();
				}
				else if(data.overdueState==0){
					alert(data.overdueMsg);
				}
				
			}
		});
		}
	
}





function deletePost(postNo){
	if(confirm("彻底删除该帖子？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/post/deletePost.do",
			data:"postNo="+postNo, 
			dataType:"json",
			success:function(data){
				if(data.deleteState==1){
					alert(data.deleteMsg);
					loadPost();
				}
				else if(data.deleteState==0){
					alert(data.deleteMsg);
				}
				
			}
		});
		}
	
}




function recoverPost(postNo){
	if(confirm("恢复该帖子到已发布状态？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/postNo/recoverPost.do",
			data:"postNo="+postNo, 
			dataType:"json",
			success:function(data){
				if(data.recoverState==1){
					alert(data.recoverMsg);
					loadPost();
				}
				else if(data.recoverState==0){
					alert(data.recoverMsg);
				}
				
			}
		});
		}
	
}




function commonPost(postNo){
	if(confirm("确定置为普通帖？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/post/commonPost.do",
			data:"postNo="+postNo, 
			dataType:"json",
			success:function(data){
				if(data.commonState==1){
					alert(data.commonMsg);
					loadPost();
				}
				else if(data.commonState==0){
					alert(data.commonMsg);
				}
				
			}
		});
		}
}




/*function hotPost(postNo){
	if(confirm("确定置为热门帖？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/post/hotPost.do",
			data:"postNo="+postNo, 
			dataType:"json",
			success:function(data){
				if(data.hotState==1){
					alert(data.hotMsg);
					loadPost();
				}
				else if(data.hotState==0){
					alert(data.hotMsg);
				}
				
			}
		});
		}
	
}*/





function topPost(postNo){
	if(confirm("确定置为置顶帖？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/post/topPost.do",
			data:"postNo="+postNo, 
			dataType:"json",
			success:function(data){
				if(data.topState==1){
					alert(data.topMsg);
					loadPost();
				}
				else if(data.topState==0){
					alert(data.topMsg);
				}
				
			}
		});
		}
	
}

