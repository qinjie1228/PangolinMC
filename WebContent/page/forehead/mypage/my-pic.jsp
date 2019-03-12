<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ include file="/page/common/page-include.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>照片列表</title>
	<link rel="stylesheet" href="<%=basePath%>css/lightbox.css" media="screen"/>
	<script src="<%=basePath%>js/lightbox-2.6.min.js"></script>
</head>
<body>   
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">前台</li>
	  <li class="active">个人中心</li>
	  <li id="picNameShow" class="active">已发布照片</li>
	</ol>
	
	<div class="searchBar" style="height:100px;">
		<div class="searchTop">搜索栏</div>
		<div class="cutLine"></div>
		<div class="form-inline">
		  <div class="form-group">
		  <span class="itemLeftFirst">搜索条件:</span>
			<input type="text" class="searchItem" id="searchPicDes" placeholder="照片描述">
			<a href="<%=basePath%>index/toAlertPic.do?url=index"><button id="addPicShow" class="btn" style="float:right;margin-right:75px;" class="btn" type="button">上传照片</button></a>
		  </div>
		</div>

		<div class="form-inline searchBarTwo">
		  <div class="form-group">
		  <span class="itemLeftFirst searchActTimeName">发布时间:</span>
			<input type="text" class="searchItem date_picker searchActTimeName" id="searchStartTime" placeholder="起始时间">
			<input type="text" class="itemLeft searchItem date_picker searchActTimeName" id="searchEndTime" placeholder="结束时间">
		  <button type="button" id="submitSearch" class="submitSearch btn" onclick="submitSearchIndex();" style="float:right;margin-right:75px;" >搜索</button>
			</div>
		</div>
	</div>

	<div class="widget-box">
	
		<table cellspacing="0">
    		<tr>
    			<th>照片</th>
    			<th>描述</th>
    			<th id="picPubTimeShow">发布时间</th>
    			<th>操作</th>
    		</tr>
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

</body>
  
  
 <script type="text/javascript">
 var picState= ${picState};
 var islove = "";
$(document).ready(function(){
	$('.date_picker').date_input();
	$("#addPicUp").uploadPreview({ Img: "addPicPic", Width: 120, Height: 120 });
	$("#picAlertUp").uploadPreview({ Img: "picAlertPic", Width: 120, Height: 120 });
	switch(picState){
	case 1:
		$("#picNameShow").html("普通照片");
		break;
	case 2:
		$("#picNameShow").html("我喜欢的照片");
		$("#addPicShow").hide();
		islove = 1;
		break;
	case 3:
		$("#picNameShow").html("待审核照片");
		$("#addPicShow").hide();
		break;
	case 4:
		$("#picNameShow").html("精品照片");
		$("#addPicShow").hide();
		break;
	case 5:
		$("#picNameShow").html("已否决照片");
		$("#addPicShow").hide();
		break;
	}
	$("#submitSearch").click();
});
 
function submitSearchIndex(){
	var pageSize = 9;
	
	var searchUserName = $("#searchUserName").val();
	var searchPicDes = $("#searchPicDes").val();
	var searchStartTime = $("#searchStartTime").val();
	var searchEndTime = $("#searchEndTime").val();
	
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
	var action ="getPicCondition.do";
	$.ajax({
		type:"post",
		url:"<%=basePath%>pic/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&picState="+picState+
		"&userName="+searchUserName+
		"&picDes="+searchPicDes+
		"&searchStartTime="+searchStartTime+
		"&searchEndTime="+searchEndTime+
		"&islove="+islove, 
		dataType:"json",
		success:function(data){
			$("#tbody").html("");
			 var str = ""; 
			 $(data.data).each(function(i,picture){ 
				 var picDes = picture.picDes;
                 if(picDes.length > 14){
                	 picDes = picDes.substring(0,14) + "...";
                 }
				 str += "<tr><td>" +  
				 	"<a data-lightbox='example-2' title='"+picture.picDes+"' href='" + '/upload/pic/' + picture.picPath + "'>" +
				 	"<img alt='"+picture.picDes+"' src='" + '/upload/pic/' + picture.picPath + "' width='60' height='40' /></a></td>" + "<td>";
                 str += picDes + "</td>" + "<td>" + moment(picture.picPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>"; 
                 switch(Number(picState)){
	                case 1:
						 str += 
		                     "<a class='btn btn-default' href='javascript:wellPictureApply(\""+picture.picNo+"\")' role='button'>申精</a>"+
		                     "<a class='btn btn-default' href='javascript:addPictureMyLove(\""+picture.picNo+"\")' role='button'>我喜欢</a>"+
		                     "<a class='btn btn-default' href='<%=basePath%>index/toAlertPic.do?picNo=" +picture.picNo+ "' role='button'>修改</a>"+
		                     "<a class='btn btn-info' href='javascript:deletePic(\""+picture.picNo+"\")' role='button'>删除</a>";
		                     break;
					case 2:
						 str += 
							 "<a class='btn btn-default' href='javascript:wellPictureApply(\""+picture.picNo+"\")' role='button'>申精</a>"+
							 "<a class='btn btn-default' href='<%=basePath%>index/toAlertPic.do?picNo=" +picture.picNo+ "' role='button'>修改</a>"+
		                     "<a class='btn btn-default' href='javascript:cancelPictureMyLove(\""+picture.picNo+"\")' role='button'>取消</a>"+
		                     "<a class='btn btn-info' href='javascript:deletePic(\""+picture.picNo+"\")' role='button'>删除</a>";
		                     break;
					case 3:
						 str += 
							 "<a class='btn btn-default' href='javascript:addPictureMyLove(\""+picture.picNo+"\")' role='button'>我喜欢</a>"+
							 "<a class='btn btn-default' href='<%=basePath%>index/toAlertPic.do?picNo=" +picture.picNo+ "' role='button'>修改</a>"+
		                     "<a class='btn btn-info' href='javascript:cancelWellPictureApply(\""+picture.picNo+"\")' role='button'>取消</a>";
		                     break;
					case 4:
						 str += 
		                     "<a class='btn btn-default' href='javascript:addPictureMyLove(\""+picture.picNo+"\")' role='button'>我喜欢</a>"+
		                     "<a class='btn btn-default' href='<%=basePath%>index/toAlertPic.do?picNo=" +picture.picNo+ "' role='button'>修改</a>"+
		                     "<a class='btn btn-default' href='javascript:cancelWellPictureApply(\""+picture.picNo+"\")' role='button'>取消</a>"+
		                     "<a class='btn btn-info' href='javascript:deletePic(\""+picture.picNo+"\")' role='button'>删除</a>";
		                     break;
		            case 5:
		            	 str += 
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
			            	url:"<%=basePath%>pic/"+action,
			            	data:"pageNow="+page+"&pageSize="+pageSize+"&picState="+picState+
			            	"&userName="+searchUserName+
			        		"&picDes="+searchPicDes+
			        		"&searchStartTime="+searchStartTime+
			        		"&searchEndTime="+searchEndTime+
			        		"&islove="+islove, 
			          		dataType:"json",
			                success: function (msg) {
			                	var str1 = ""; 
			                	  $(msg.data).each(function(i,picture1){ 
			                		  var picDes1 = picture1.picDes;
			                		  if(picDes1.length > 14){
			                         	 picDes1 = picDes1.substring(0,14) + "...";
			                          }
			         				  str1 += "<tr><td>" +  
			         				 	"<a data-lightbox='example-2' title='"+picture1.picDes+"' href='" + '/upload/pic/' + picture1.picPath + "'>" +
			         				 	"<img alt='"+picture1.picDes+"' src='" + '/upload/pic/' + picture1.picPath + "' width='60' height='40' /></a></td>" + "<td>";
			                          str1 += picDes1 + "</td>" + "<td>" + moment(picture1.picPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>"; 
			                          switch(Number(picState)){
			         	                case 1:
			         						 str1 += 
			         		                     "<a class='btn btn-default' href='javascript:wellPictureApply(\""+picture1.picNo+"\")' role='button'>申精</a>"+
			         		                     "<a class='btn btn-default' href='javascript:addPictureMyLove(\""+picture1.picNo+"\")' role='button'>我喜欢</a>"+
			         		                     "<a class='btn btn-default' href='<%=basePath%>index/toAlertPic.do?picNo=" +picture1.picNo+ "' role='button'>修改</a>"+
			         		                     "<a class='btn btn-info' href='javascript:deletePic(\""+picture1.picNo+"\")' role='button'>删除</a>";
			         		                     break;
			         					case 2:
			         						 str1 += 
			         							 "<a class='btn btn-default' href='javascript:wellPictureApply(\""+picture1.picNo+"\")' role='button'>申精</a>"+
			         							"<a class='btn btn-default' href='<%=basePath%>index/toAlertPic.do?picNo=" +picture1.picNo+ "' role='button'>修改</a>"+
			         		                     "<a class='btn btn-default' href='javascript:cancelPictureMyLove(\""+picture1.picNo+"\")' role='button'>取消</a>"+
			         		                     "<a class='btn btn-info' href='javascript:deletePic(\""+picture1.picNo+"\")' role='button'>删除</a>";
			         		                     break;
			         					case 3:
			         						 str1 += 
			         							"<a class='btn btn-default' href='javascript:addPictureMyLove(\""+picture.picNo+"\")' role='button'>我喜欢</a>"+
			         							"<a class='btn btn-default' href='<%=basePath%>index/toAlertPic.do?picNo=" +picture1.picNo+ "' role='button'>修改</a>"+
			         		                     "<a class='btn btn-info' href='javascript:cancelWellPictureApply(\""+picture1.picNo+"\")' role='button'>取消</a>";
			         		                     break;
			         					case 4:
			         						 str1 += 
			         		                     "<a class='btn btn-default' href='javascript:addPictureMyLove(\""+picture1.picNo+"\")' role='button'>我喜欢</a>"+
			         		                    "<a class='btn btn-default' href='<%=basePath%>index/toAlertPic.do?picNo=" +picture1.picNo+ "' role='button'>修改</a>"+
			         		                    "<a class='btn btn-default' href='javascript:cancelWellPictureApply(\""+picture1.picNo+"\")' role='button'>取消</a>"+
			         		                     "<a class='btn btn-info' href='javascript:deletePic(\""+picture1.picNo+"\")' role='button'>删除</a>";
			         		                     break;
			         		            case 5:
			         		            	 str1 += 
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


function wellPictureApply(picNo){
	art.dialog(
	        {
	            content:'申请精品照片？',
	            style:'succeed noClose'
	        },
	        function(){
	        	$.ajax({
	        		type:"post",
	        		url:"<%=basePath%>pic/wellPictureApply.do",
	        		data:"picNo="+picNo, 
	        		dataType:"json",
	        		success:function(data){
	        			if(data.applyState==1){
	        				art.dialog.alert(data.applyMsg, function () {
	        					$("#submitSearch").click();
	        			    });
	        			}
	        			else if(data.applyState==0){
	        				art.dialog.alert(data.applyMsg, function () {
	        					;
	        			    });
	        			}
	        			
	        		}
	        	});
	        },
	        function(){
	        	;
	        }
	);
}

function addPictureMyLove(picNo){
	art.dialog(
	        {
	            content:'添加照片到我喜欢？',
	            style:'succeed noClose'
	        },
	        function(){
	        	$.ajax({
	        		type:"post",
	        		url:"<%=basePath%>pic/addPictureMyLove.do",
	        		data:"picNo="+picNo, 
	        		dataType:"json",
	        		success:function(data){
	        			if(data.addMyLoveState==1){
	        				art.dialog.alert(data.addMyLoveMsg, function () {
	        					$("#submitSearch").click();
	        			    });
	        			}
	        			else if(data.addMyLoveState==0){
	        				art.dialog.alert(data.addMyLoveMsg, function () {
	        					;
	        			    });
	        			}
	        			
	        		}
	        	});
	        },
	        function(){
	        	;
	        }
	);
}

function deletePic(picNo){
	art.dialog(
	        {
	            content:'删除不可恢复！',
	            style:'succeed noClose'
	        },
	        function(){
	        	$.ajax({
	        		type:"post",
	        		url:"<%=basePath%>pic/deletePic.do",
	        		data:"picNo="+picNo, 
	        		dataType:"json",
	        		success:function(data){
	        			if(data.deleteState==1){
	        				art.dialog.alert(data.deleteMsg, function () {
	        					$("#submitSearch").click();
	        			    });
	        			}
	        			else if(data.deleteState==0){
	        				art.dialog.alert(data.deleteMsg, function () {
	        					;
	        			    });
	        			}
	        			
	        		}
	        	});
	        },
	        function(){
	        	;
	        }
	);
}

function cancelWellPictureApply(picNo){
	art.dialog(
	        {
	            content:'取消精品照片申请？',
	            style:'succeed noClose'
	        },
	        function(){
	        	$.ajax({
	        		type:"post",
	        		url:"<%=basePath%>pic/cancelWellPictureApply.do",
	        		data:"picNo="+picNo, 
	        		dataType:"json",
	        		success:function(data){
	        			if(data.canceApplyState==1){
	        				art.dialog.alert(data.canceApplyMsg, function () {
	        					$("#submitSearch").click();
	        			    });
	        			}
	        			else if(data.canceApplyState==0){
	        				art.dialog.alert(data.canceApplyMsg, function () {
	        					;
	        			    });
	        			}
	        			
	        		}
	        	});
	        },
	        function(){
	        	;
	        }
	);
}

function cancelPictureMyLove(picNo){
	art.dialog(
	        {
	            content:'将照片从我喜欢移除？',
	            style:'succeed noClose'
	        },
	        function(){
	        	$.ajax({
	        		type:"post",
	        		url:"<%=basePath%>pic/cancelPictureMyLove.do",
	        		data:"picNo="+picNo, 
	        		dataType:"json",
	        		success:function(data){
	        			if(data.cancelMyLoveState==1){
	        				art.dialog.alert(data.cancelMyLoveMsg, function () {
	        					$("#submitSearch").click();
	        			    });
	        			}
	        			else if(data.cancelMyLoveState==0){
	        				art.dialog.alert(data.cancelMyLoveMsg, function () {
	        					;
	        			    });
	        			}
	        			
	        		}
	        	});
	        },
	        function(){
	        	;
	        }
	);
}
</script>
  
  
  
</html>
