<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma","no-cache"); 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>评语列表</title>
	<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/bootstrap-theme.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/date-picker.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/common.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/bootstrap-paginator.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/back/commentlist-back.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.date_input.pack.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/browser.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/moment.min.js"></script>
	
	<script src="<%=basePath%>js/back/background-common.js"></script>

</head>
<body onload="loadComment();">   
  
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">后台</li>
	  <li class="active">评语管理</li>
	  <li id="commentNameShow" class="active">已发布评语</li>
	</ol>
	
	<div class="searchBar">
		<div class="searchTop">搜索栏</div>
		<div class="cutLine"></div>
		<div class="form-inline">
		  <div class="form-group">
		  <span class="itemLeftFirst">搜索条件:</span>
			<input type="text" class="searchItem" id="searchUserName" placeholder="用户名">
			<input type="text" class="itemLeft searchItem" id="searchPostTitle" placeholder="帖子标题">
			<input type="text" class="itemLeft searchItem" id="searchCommentContent" placeholder="评语内容">
		  </div>
		</div>

		<div class="form-inline searchBarTwo">
		  <div class="form-group">
		  <span class="itemLeftFirst searchCommentTimeName">发布时间:</span>
			<input type="text" class="searchItem date_picker searchCommentTimeName" id="searchStartTime" placeholder="起始时间">
			<input type="text" class="itemLeft searchItem date_picker searchCommentTimeName" id="searchEndTime" placeholder="结束时间">
		  <button type="button" class="submitSearch btn" onclick="submitSearch();" style="margin-left:449px;">搜索</button>
			</div>
		</div>
	</div>

	<div class="widget-box">
		<table class="table table-hover table-bordered table-striped table-responsive">
			<thead>
				<tr>
					<td>帖子标题</td>
					<td>发布者</td>
					<td>评语</td>
					<td id="CommentPubTimeShow">发布时间</td>
					<td>操作</td>
				</tr>
			</thead>
			
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

      
         


<!-- 查看评语模态框开始 -->
<div class="modal fade" id="look" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="overflow-y:scroll;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">查看评语</h4>
      </div>
      <div class="modal-body" >
		<div class="form-horizontal" >
		  <div class="form-group" >
			<label class="col-sm-2 control-label">帖子标题</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control" placeholder="帖子标题" id="lpostTitle" disabled="disabled">
			</div>
		  </div>
		  
		   <div class="form-group">
			<label class="col-sm-2 control-label">评语内容</label>
			<div class="col-sm-10">
				<div id="lcommentContent" style="width:480px;height:tauto;;"></div>
			</div>
		  </div>
		  
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">确定</button>
      </div>
      

      	</div>
      </div>
      </div>
      </div>
    </div>	
 <!--查看评语模态框结束-->


</body>
  
  
 <script type="text/javascript">

var commentState= ${commentState};
var pageSize = 6;

function loadComment(){

	$('.date_picker').date_input();
	
	var action ="doGetAllComment.do";
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
	$.ajax({
		type:"post",
		url:"<%=basePath%>comment/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&commentState="+commentState, 
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
			            	url:"<%=basePath%>comment/"+action,
			          		data:"pageNow="+page+"&pageSize="+pageSize+"&commentState="+commentState, 
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

</script>
  
  
  
</html>
