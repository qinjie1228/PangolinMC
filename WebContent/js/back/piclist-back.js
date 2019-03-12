
function submitSearch(){
	var searchUserName = $("#searchUserName").val();
	var searchPicDes = $("#searchPicDes").val();
	var searchStartTime = $("#searchStartTime").val();
	var searchEndTime = $("#searchEndTime").val();
	
	var forMatUserName =/^[\u4e00-\u9fa5a-zA-Z0-9]{3,32}$/;
	var forMatDes = /^[\w\u4e00-\u9fa5~!@#$%^&*()+-_={}|\/:;/'/"”‘？’“、：,，。.?<>{}]{2,1000}$/;
	var forMatTime = /^[0-9]{4}-(0?[0-9]|1[0-2])-(0?[1-9]|[12]?[0-9]|3[01])$/;
	
	if(searchUserName != null && searchUserName !=""){
		if(forMatUserName.test(searchUserName) != true){
			alert("请输入正确的用户名！");
			$("#searchUserName").focus();
			return;
		}
	}
	
	if(searchPicDes != null && searchPicDes !=""){
		if(forMatDes.test(searchPicDes) != true){
			alert("描述格式不正确！");
			$("#searchPicDes").focus();
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
	var action = "getPicCondition.do";
	$.ajax({
		type:"post",
		url:basePath+"/pic/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&picState="+picState+
		"&userName="+searchUserName+
		"&picDes="+searchPicDes+
		"&searchStartTime="+searchStartTime+
		"&searchEndTime="+searchEndTime,
		dataType:"json",
		success:function(data){
			$("#tbody").html("");
			 var str = "";  
			 $(data.data).each(function(i,picture){ 
				 str += "<tr class='success'>" +  
				 "<td><div><img src='" + '/upload/pic/' + picture.picPath + "' width='60' height='40' /></div></td>" + 
                 "<td class='picDesTd'>";
                 var picDes = picture.picDes;
                 if(picDes.length > 18){
                	 picDes = picDes.substring(0,18) + "...";
                 }
                 str += picDes + "</td><td>" + picture.userName + "</td>"; 
                 switch(Number(picture.picState)){
					case 3:
						 str += "<td>" +
		                     "<a class='btn btn-default' href='javascript:passPic(\""+picture.picNo+"\")' role='button'>通过</a>"+
		                     "<a class='btn btn-info' href='javascript:failPic(\""+picture.picNo+"\")' role='button'>否决</a>";
		                     break;
					case 4:
						 str += "<td>" + moment(picture.picPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertPic(\""+picture.picNo+"\")' role='button'>修改</a>"+
		                     "<a class='btn btn-info' href='javascript:overduePic(\""+picture.picNo+"\")' role='button'>删除</a>";
		                     break;
		            case 5:
		            	 str += "<td>" +
			            	 "<a class='btn btn-default' href='javascript:recoverPic(\""+picture.picNo+"\")' role='button'>恢复</a>"+
		                     "<a class='btn btn-info' href='javascript:deletePic(\""+picture.picNo+"\")' role='button'>删除</a>";
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
			            	url:basePath+"/pic/"+action,
			        		data:"pageNow="+page+"&pageSize="+pageSize+"&picState="+picState+
			        		"&userName="+searchUserName+
			        		"&picDes="+searchPicDes+
			        		"&searchStartTime="+searchStartTime+
			        		"&searchEndTime="+searchEndTime,
			          		dataType:"json",
			                success: function (msg) {
			                	var str1 = ""; 
			                	  $(msg.data).each(function(i,picture1){ 
			                		  str1 += "<tr class='success'>" +  
			         				  "<td><div><img src='" + '/upload/pic/' + picture1.picPath + "' width='60' height='40' /></div></td>" + 
			                          "<td class='picDesTd'>";
			                          var picDes1 = picture1.picDes;
			                          if(picDes1.length > 18){
			                         	 picDes1 = picDes1.substring(0,18) + "...";
			                          }
			                          str1 += picDes1 + "</td><td>" + picture1.userName + "</td>"; 
				                         switch(Number(picture1.picState)){
				        					case 3:
				        						 str1 += "<td>" +
				        		                     "<a class='btn btn-default' href='javascript:passPic(\""+picture1.picNo+"\")' role='button'>通过</a>"+
				        		                     "<a class='btn btn-info' href='javascript:failPic(\""+picture1.picNo+"\")' role='button'>否决</a>";
				        		                     break;
				        					case 4:
				        						 str1 += "<td>" + moment(picture1.picPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
				        		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertPic(\""+picture1.picNo+"\")' role='button'>修改</a>"+
				        		                     "<a class='btn btn-info' href='javascript:overduePic(\""+picture1.picNo+"\")' role='button'>删除</a>";
				        		                     break;
				        		            case 5:
				        		            	 str1 += "<td>" +
				        			            	 "<a class='btn btn-default' href='javascript:recoverPic(\""+picture1.picNo+"\")' role='button'>恢复</a>"+
				        		                     "<a class='btn btn-info' href='javascript:deletePic(\""+picture1.picNo+"\")' role='button'>删除</a>";
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





function toAlertPic(picNo){
	var location = (window.location+'').split('/');  
	var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
	$.ajax({
		type:"post",
		url:basePath+"/pic/findPicByPicNo.do",
		data:"picNo="+picNo, 
		dataType:"json",
		success:function(data){
			var src = '/upload/pic/'+data.picPath;
			$("#apicNo").val(data.picNo);
			$("#auserNo").val(data.userNo);
			$("#apicDes").val(data.picDes);
			$("#apicState").val(data.picState);
			$("#picAlertPic").attr('src', src);
		}
	});
}






function passPic(picNo){
	if(confirm("通过该精品图片申请？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/pic/passPic.do",
			data:"picNo="+picNo, 
			dataType:"json",
			success:function(data){
				if(data.passState==1){
					alert(data.passMsg);
					loadPic();
				}
				else if(data.passState==0){
					alert(data.passMsg);
				}
				
			}
		});
		}
}




function failPic(picNo){
	if(confirm("否决该精品图片申请？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/pic/failPic.do",
			data:"picNo="+picNo, 
			dataType:"json",
			success:function(data){
				if(data.failState==1){
					alert(data.failMsg);
					loadPic();
				}
				else if(data.failState==0){
					alert(data.failMsg);
				}
				
			}
		});
		}
}




function overduePic(picNo){
	if(confirm("照片将变更为过期状态")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/pic/overduePic.do",
			data:"picNo="+picNo, 
			dataType:"json",
			success:function(data){
				if(data.overdueState==1){
					alert(data.overdueMsg);
					loadPic();
				}
				else if(data.overdueState==0){
					alert(data.overdueMsg);
				}
				
			}
		});
		}
	
}





function deletePic(picNo){
	if(confirm("彻底删除该照片？")){
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 

		$.ajax({
			type:"post",
			url:basePath+"/pic/deletePic.do",
			data:"picNo="+picNo, 
			dataType:"json",
			success:function(data){
				if(data.deleteState==1){
					alert(data.deleteMsg);
					loadPic();
				}
				else if(data.deleteState==0){
					alert(data.deleteMsg);
				}
				
			}
		});
		}
	
}

