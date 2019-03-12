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
    <title>帖子列表</title>
	<script type="text/javascript" src="<%=basePath%>js/back/postlist-back.js"></script>

</head>
<body>   
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">前台</li>
	  <li class="active">个人中心</li>
	  <li id="postNameShow" class="active">已发布帖子</li>
	</ol>
	
	<div class="searchBar" style="height:100px;">
		<div class="searchTop">搜索栏</div>
		<div class="cutLine"></div>
		<div class="form-inline">
		  <div class="form-group">
			  <span class="itemLeftFirst">搜索条件:</span>
				<input type="text" class="searchItem" id="searchPostTitle" placeholder="帖子标题">
				<select class="itemLeft searchItem" id="searchPostCategory">
					<option value="主题帖"  selected>主题帖</option>
					<option value="交友贴">交友贴</option>
					<option value="投诉建议贴">投诉建议贴</option>
				</select>
				<a href="<%=basePath%>index/toAddPost.do?url=index"><button id="addPostShow" class="btn" style="float:right;margin-right:75px;" class="btn" type="button">添加帖子</button></a>
			</div>
		</div>

		<div class="form-inline searchBarTwo">
		  <div class="form-group">
		  <span class="itemLeftFirst searchPostTimeName">发布时间:</span>
			<input type="text" class="searchItem date_picker searchPostTimeName" id="searchStartTime" placeholder="起始时间">
			<input type="text" class="itemLeft searchItem date_picker searchPostTimeName" id="searchEndTime" placeholder="结束时间">
		  <button type="button" id="submitSearch" class="submitSearch btn" onclick="submitSearchIndex();" style="float:right;margin-right:75px;">搜索</button>
			</div>
		</div>
	</div>

	<div class="widget-box">
	
		<table cellspacing="0">
    		<tr>
    			<th>帖子标题</th>
    			<th>帖子类别</th>
    			<th>浏览量</th>
    			<th>评论量</th>
    			<th id="postPubTimeShow">发布时间</th>
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
 var postState= ${postState};
$(document).ready(function(){
	$('.date_picker').date_input();
	$("#addPostUp").uploadPreview({ Img: "addPostPic", Width: 120, Height: 120 });
	$("#postAlertUp").uploadPreview({ Img: "postAlertPic", Width: 120, Height: 120 });
	switch(postState){
	case 6:
		$("#postNameShow").html("待审核帖子");
		$(".searchPostTimeName").hide();
		$("#addPostShow").hide();
		$("#postPubTimeShow").hide();
		break;
	case 1:
		$("#postNameShow").html("普通帖子");
		break;
	case 2:
		$("#postNameShow").html("精品帖子");
		$("#addPostShow").hide();
		break;
	case 4:
		$("#postNameShow").html("置顶帖子");
		$("#addPostShow").hide();
		break;
	case 5:
		$("#postNameShow").html("过期帖子");
		$(".searchPostTimeName").hide();
		$("#addPostShow").hide();
		$("#postPubTimeShow").hide();
		break;
	}
	$("#submitSearch").click();
});
 
function submitSearchIndex(){
	var pageSize = 10;
	
	var searchUserName = $("#searchUserName").val();
	var searchPostTitle = $("#searchPostTitle").val();
	var searchPostCategory = $("#searchPostCategory").val();
/* 	var searchPostScanNum = $("#searchPostScanNum").val();
	var searchPostCommentNum = $("#searchPostCommentNum").val(); */
	var searchStartTime = $("#searchStartTime").val();
	var searchEndTime = $("#searchEndTime").val();
	
/* 	var forMatNum = /^[0-9]{1,12}$/; */
	if(searchPostTitle != null && searchPostTitle !=""){
		if(forMatTitle.test(searchPostTitle) != true){
			alert("标题格式不正确！");
			$("#searchPostTitle").focus();
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
	
	var action ="getPostCondition.do";
	$.ajax({
		type:"post",
		url:"<%=basePath%>post/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&postState="+postState+
		"&userName="+searchUserName+
		"&postTitle="+searchPostTitle+
		"&postCategory="+searchPostCategory+
		"&postScanNum="+""+
		"&postCommentNum="+""+
		"&searchStartTime="+searchStartTime+
		"&searchEndTime="+searchEndTime,
		dataType:"json",
		success:function(data){
			$("#tbody").html("");
			 var str = ""; 
			 $(data.data).each(function(i,post){ 
				 str += "<tr><td>"; 
                 var postTitle = post.postTitle;
                 if(postTitle.length > 13){
                	 postTitle = postTitle.substring(0,13) + "...";
                 }
                 str += postTitle + "</td>" + 
                 "<td>" + post.postCategory + "</td>" + 
                 "<td>" + post.postScanNum + "</td>" +
                 "<td>" + post.postCommentNum + "</td>";  
                 switch(Number(post.postState)){
					case 6:
						 str += "<td>" +
		                	 "<a class='btn btn-default' href='<%=basePath%>post/findPostByPostNoIndexMy.do?postNo=" +post.postNo+ "' role='button'>查看</a>"+
		                     "<a class='btn btn-info' href='javascript:cancelWellPostApply(\""+post.postNo+"\")' role='button'>取消</a>";
		                     break;
					case 1:
						 str += "<td>" + moment(post.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
		                     "<a class='btn btn-default' href='<%=basePath%>index/toAddPost.do?postNo=" +post.postNo+ "' role='button'>修改</a>"+
		                     "<a class='btn btn-info' href='javascript:wellPostApply(\""+post.postNo+"\")' role='button'>申精</a>" +
		                     "<a class='btn btn-info' href='javascript:deletePost(\""+post.postNo+"\")' role='button'>删除</a>";
		                     break;
		            case 2:
		            	str += "<td>" + moment(post.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
						 	 "<a class='btn btn-default' href='<%=basePath%>post/findPostByPostNoIndexMy.do?postNo=" +post.postNo+ "' role='button'>查看</a>" +
		                     "<a class='btn btn-default' href='<%=basePath%>index/toAddPost.do?postNo=" +post.postNo+ "' role='button'>修改</a>"+
		                     "<a class='btn btn-info' href='javascript:deletePost(\""+post.postNo+"\")' role='button'>删除</a>";
		                     break;
		            case 4:
		            	str += "<td>" + moment(post.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
					 	 "<a class='btn btn-default' href='<%=basePath%>post/findPostByPostNoIndexMy.do?postNo=" +post.postNo+ "' role='button'>查看</a>" +
	                     "<a class='btn btn-default' href='<%=basePath%>index/toAddPost.do?postNo=" +post.postNo+ "' role='button'>修改</a>"+
	                     "<a class='btn btn-info' href='javascript:deletePost(\""+post.postNo+"\")' role='button'>删除</a>";
	                     break;
		            case 5:
						 str += "<td>" +
		                     "<a class='btn btn-default' href='<%=basePath%>post/findPostByPostNoIndexMy.do?postNo=" +post.postNo+ "' role='button'>查看</a>"+
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
			            	url:"<%=basePath%>post/"+action,
			            	data:"pageNow="+page+"&pageSize="+pageSize+"&postState="+postState+
			            	"&userName="+searchUserName+
			        		"&postTitle="+searchPostTitle+
			        		"&postCategory="+searchPostCategory+
			        		"&postScanNum="+""+
			        		"&postCommentNum="+""+
			        		"&searchStartTime="+searchStartTime+
			        		"&searchEndTime="+searchEndTime,
			          		dataType:"json",
			                success: function (msg) {
			                	var str1 = ""; 
			                	  $(msg.data).each(function(i,post1){ 
			                		  str1 += "<tr><td>"; 
			                          var postTitle1 = post1.postTitle;
			                          if(postTitle1.length > 13){
			                         	 postTitle1 = postTitle1.substring(0,13) + "...";
			                          }
			                          str1 += postTitle1 + "</td>" + 
			                          "<td>" + post1.postCategory + "</td>" + 
			                          "<td>" + post1.postScanNum + "</td>" +
			                          "<td>" + post1.postCommentNum + "</td>";  
			                          switch(Number(post1.postState)){
			         					case 6:
			         						 str1 += "<td>" +
			         		                	 "<a class='btn btn-default' href='<%=basePath%>post/findPostByPostNoIndexMy.do?postNo=" +post1.postNo+ "' role='button'>查看</a>"+
			         		                     "<a class='btn btn-info' href='javascript:cancelWellPostApply(\""+post1.postNo+"\")' role='button'>取消</a>";
			         		                     break;
			         					case 1:
			         						 str1 += "<td>" + moment(post1.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
			         		                     "<a class='btn btn-default' href='<%=basePath%>index/toAddPost.do?postNo=" +post1.postNo+ "' role='button'>修改</a>"+
			         		                     "<a class='btn btn-info' href='javascript:wellPostApply(\""+post1.postNo+"\")' role='button'>申精</a>" +
			         		                     "<a class='btn btn-info' href='javascript:deletePost(\""+post1.postNo+"\")' role='button'>删除</a>";
			         		                     break;
			         		            case 2:
			         		            	str1 += "<td>" + moment(post1.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
			         						 	 "<a class='btn btn-default' href='<%=basePath%>post/findPostByPostNoIndexMy.do?postNo=" +post1.postNo+ "' role='button'>查看</a>" +
			         		                     "<a class='btn btn-default' href='<%=basePath%>index/toAddPost.do?postNo=" +post1.postNo+ "' role='button'>修改</a>"+
			         		                     "<a class='btn btn-info' href='javascript:deletePost(\""+post1.postNo+"\")' role='button'>删除</a>";
			         		                     break;
			         		            case 4:
			         		            	str1 += "<td>" + moment(post1.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
			         					 	 "<a class='btn btn-default' href='<%=basePath%>post/findPostByPostNoIndexMy.do?postNo=" +post1.postNo+ "' role='button'>查看</a>" +
			         	                     "<a class='btn btn-default' href='<%=basePath%>index/toAddPost.do?postNo=" +post1.postNo+ "' role='button'>修改</a>"+
			         	                     "<a class='btn btn-info' href='javascript:deletePost(\""+post1.postNo+"\")' role='button'>删除</a>";
			         	                     break;
			         		            case 5:
			         						 str1 += "<td>" +
			         		                     "<a class='btn btn-default' href='<%=basePath%>post/findPostByPostNoIndexMy.do?postNo=" +post1.postNo+ "' role='button'>查看</a>"+
			         		                     "<a class='btn btn-info' href='javascript:deletePost(\""+post1.postNo+"\")' role='button'>删除</a>";
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

function cancelWellPostApply(postNo){
	art.dialog(
	        {
	            content:'取消申请？',
	            style:'succeed noClose'
	        },
	        function(){
	        	$.ajax({
	        		type:"post",
	        		url:"<%=basePath%>post/cancelWellPostApply.do",
	        		data:"postNo="+postNo, 
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

function wellPostApply(postNo){
	art.dialog(
	        {
	            content:'申请精品帖子？',
	            style:'succeed noClose'
	        },
	        function(){
	        	$.ajax({
	        		type:"post",
	        		url:"<%=basePath%>post/wellPostApply.do",
	        		data:"postNo="+postNo, 
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

function deletePost(postNo){
	art.dialog(
	        {
	            content:'删除不可恢复！',
	            style:'succeed noClose'
	        },
	        function(){
	        	$.ajax({
	        		type:"post",
	        		url:"<%=basePath%>post/deletePost.do",
	        		data:"postNo="+postNo, 
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
