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
    <title>评语列表</title>
	<script type="text/javascript" src="<%=basePath%>js/back/commentlist-back.js"></script>

</head>
<body>   
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">前台</li>
	  <li class="active">个人中心</li>
	  <li id="postNameShow" class="active">已发表评语</li>
	</ol>
	
	<div class="searchBar" style="height:100px;">
		<div class="searchTop">搜索栏</div>
		<div class="cutLine"></div>
		<div class="form-inline">
		  <div class="form-group">
		  <span class="itemLeftFirst">搜索条件:</span>
			<input type="text" class="searchItem" id="searchPostTitle" placeholder="帖子标题">
			<input type="text" class="itemLeft searchItem" id="searchCommentContent" placeholder="评语内容">
		  </div>
		</div>

		<div class="form-inline searchBarTwo">
		  <div class="form-group">
		  <span class="itemLeftFirst searchCommentTimeName">发布时间:</span>
			<input type="text" class="searchItem date_picker searchCommentTimeName" id="searchStartTime" placeholder="起始时间">
			<input type="text" class="itemLeft searchItem date_picker searchCommentTimeName" id="searchEndTime" placeholder="结束时间">
		  <button type="button" id="submitSearch" class="submitSearch btn" onclick="submitSearchIndex();" style="float:right;margin-right:75px;">搜索</button>
			</div>
		</div>
	</div>

	<div class="widget-box">
	
		<table cellspacing="0">
    		<tr>
    			<th>帖子标题</th>
    			<th>评语</th>
    			<th id="CommentPubTimeShow">发布时间</th>
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
var commentState= ${commentState};
$(document).ready(function(){
	$('.date_picker').date_input();
	switch(commentState){
	case 1:
		$("#commentNameShow").html("已发布评语");
		break;
	case 2:
		$("#noticeNameShow").html("过期评语");
		$(".searchCommentTimeName").hide();
		$("#CommentPubTimeShow").hide();
		break;
}
	$("#submitSearch").click();
});
 
function submitSearchIndex(){
	var pageSize = 10;
	
	var searchUserName = $("#searchUserName").val();
	var searchPostTitle = $("#searchPostTitle").val();
	var searchCommentContent = $("#searchCommentContent").val();
	var searchStartTime = $("#searchStartTime").val();
	var searchEndTime = $("#searchEndTime").val();
	
	if(searchPostTitle != null && searchPostTitle !=""){
		if(forMatTitle.test(searchPostTitle) != true){
			alert("标题格式不正确！");
			$("#searchPostTitle").focus();
			return;
		}
	}
	
	if(searchCommentContent != null && searchCommentContent !=""){
		if(forMatTitle.test(searchCommentContent) != true){
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
	
	var action ="getCommentCondition.do";
	$.ajax({
		type:"post",
		url:"<%=basePath%>comment/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&commentState="+commentState+
		"&userName="+searchUserName+
		"&postTitle="+searchPostTitle+
		"&commentContent="+searchCommentContent+
		"&searchStartTime="+searchStartTime+
		"&searchEndTime="+searchEndTime,
		success:function(data){
			$("#tbody").html("");
			 var str = ""; 
			 $(data.data).each(function(i,comment){ 
				 var postTitle = comment.postTitle;
                 if(postTitle.length > 16){
                	 postTitle = postTitle.substring(0,16) + "...";
                 }
                 str += "<tr><td>" + postTitle + "</td><td>";
                 var commentContent = comment.commentContent;
                 if(commentContent.length > 10){
                	 commentContent = commentContent.substring(0,10) + "...";
                 }
                 str += commentContent + "</td>";
                 switch(Number(comment.commentState)){
					case 1:
						 str += "<td>" + moment(comment.commentPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
		                	 "<a class='btn btn-default' href='<%=basePath%>comment/findCommentByCommentNoIndexMy.do?commentNo=" +comment.commentNo+ "' role='button'>查看</a>"+
		                	 "<a class='btn btn-info' href='javascript:deleteComment(\""+comment.commentNo+"\")' role='button'>删除</a>";
		                     break;
					case 2:
						 str += "<td>" +
							 "<a class='btn btn-default' href='<%=basePath%>comment/findCommentByCommentNoIndexMy.do?commentNo=" +comment.commentNo+ "' role='button'>查看</a>"+
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
			            	url:"<%=basePath%>comment/"+action,
			            	data:"pageNow="+page+"&pageSize="+pageSize+"&commentState="+commentState+
			        		"&userName="+searchUserName+
			        		"&postTitle="+searchPostTitle+
			        		"&commentContent="+searchCommentContent+
			        		"&searchStartTime="+searchStartTime+
			        		"&searchEndTime="+searchEndTime,
			          		dataType:"json",
			                success: function (msg) {
			                	var str1 = ""; 
			                	  $(msg.data).each(function(i,comment1){ 
			                		  var postTitle1 = comment1.postTitle;
			                          if(postTitle1.length > 16){
			                         	 postTitle1 = postTitle1.substring(0,16) + "...";
			                          }
			                          str1 += "<tr><td>" + postTitle1 + "</td><td>";
			                          var commentContent1 = comment1.commentContent;
			                          if(commentContent1.length > 10){
			                         	 commentContent1 = commentContent1.substring(0,10) + "...";
			                          }
			                          str1 += commentContent1 + "</td>";
			                          switch(Number(comment1.commentState)){
			         					case 1:
			         						 str1 += "<td>" + moment(comment1.commentPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
			         		                	 "<a class='btn btn-default' href='<%=basePath%>comment/findCommentByCommentNoIndexMy.do?commentNo=" +comment1.commentNo+ "' role='button'>查看</a>"+
			         		                	 "<a class='btn btn-info' href='javascript:deleteComment(\""+comment1.commentNo+"\")' role='button'>删除</a>";
			         		                     break;
			         					case 2:
			         						 str1 += "<td>" +
			         							 "<a class='btn btn-default' href='<%=basePath%>comment/findCommentByCommentNoIndexMy.do?commentNo=" +comment1.commentNo+ "' role='button'>查看</a>"+
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

function deleteComment(commentNo){
	art.dialog(
	        {
	            content:'删除不可恢复！',
	            style:'succeed noClose'
	        },
	        function(){
	        	$.ajax({
	        		type:"post",
	        		url:"<%=basePath%>comment/deleteComment.do",
	        		data:"commentNo="+commentNo, 
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

</script>
  
  
  
</html>
