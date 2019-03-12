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
    <title>帖子列表</title>
	<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/bootstrap-theme.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/date-picker.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="<%=basePath%>trumbowyg/design/css/trumbowyg.css">
	<link href="<%=basePath%>css/common.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/bootstrap-paginator.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/back/postlist-back.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.date_input.pack.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/browser.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/moment.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/picUpload.js"></script>
	
	<script src="<%=basePath%>trumbowyg/trumbowyg.js"></script>
    <script src="<%=basePath%>trumbowyg/langs/fr.js"></script>
	<script src="<%=basePath%>trumbowyg/plugins/upload/trumbowyg.upload.js"></script>
	<script src="<%=basePath%>trumbowyg/plugins/base64/trumbowyg.base64.js"></script>
	
	<script src="<%=basePath%>js/back/background-common.js"></script>
	
<style type="text/css">
.postTitleTd{
	width: 250px;
}

</style>

</head>
<body onload="loadPost();">   
  
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">后台</li>
	  <li class="active">帖子管理</li>
	  <li id="postNameShow" class="active">已发布帖子</li>
	</ol>
	
	<div class="searchBar">
		<div class="searchTop">搜索栏</div>
		<div class="cutLine"></div>
		<div class="form-inline">
		  <div class="form-group">
		  <span class="itemLeftFirst">搜索条件:</span>
			<input type="text" class="searchItem" id="searchUserName" placeholder="用户名">
			<input type="text" class="itemLeft searchItem" id="searchPostScanNum" placeholder="浏览量">
			<input type="text" class="itemLeft searchItem" id="searchPostCommentNum" placeholder="评论量">
			<input type="text" class="itemLeft searchItem " id="searchPostTitle" placeholder="帖子标题">
			<select class="itemLeft searchItem" id="searchPostCategory">
				<option value="主题帖"  selected>主题帖</option>
				<option value="交友贴">交友贴</option>
				<option value="投诉建议贴">投诉建议贴</option>
			</select>
		  </div>
		</div>

		<div class="form-inline searchBarTwo">
		  <div class="form-group">
		  <span class="itemLeftFirst searchPostTimeName">发布时间:</span>
			<input type="text" class="searchItem date_picker searchPostTimeName" id="searchStartTime" placeholder="起始时间">
			<input type="text" class="itemLeft searchItem date_picker searchPostTimeName" id="searchEndTime" placeholder="结束时间">
		  <button type="button" class="submitSearch btn" onclick="submitSearch();" style="margin-left:449px;">搜索</button>
		 
		  <!-- <button type="button" class="submitSearch btn" onclick="submitSearchCommentNum();" style="margin-left:449px;">搜索</button>
		  <button type="button" class="submitSearch btn" onclick="submitSearchSearchScanNum();" style="margin-left:449px;">搜索</button> -->
			
		  </div>
		</div>
	</div>

	<button id="addPostShow" class="btn btn-info btn-md active" type="button" data-toggle="modal" data-target="#toAddPost">添加帖子</button>
	<div class="widget-box">
		<table class="table table-hover table-bordered table-striped table-responsive">
			<thead>
				<tr>
					<td>帖子标题</td>
					<td>发布者</td>
					<td>帖子类别</td>
					<td>浏览量</td>
					<td>评论量</td>
					<td id="postPubTimeShow">发布时间</td>
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





<!-- 添加帖子模态框开始 -->
<div class="modal fade" id="toAddPost" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="overflow-y:scroll;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">添加帖子</h4>
      </div>
      <div class="modal-body">
        <!--添加帖子表单-->
		<form class="form-horizontal" action="<%=basePath%>post/addPost.do" method="post" enctype="multipart/form-data">
		
		<input type="hidden" name="userNo" value="${currentUser.currentNo}"/>
		<input type="hidden" name="postCommentNum" value="0"/>
		<input type="hidden" name="postScanNum" value="0"/>
		<input type="hidden" name="postState" value="${postState}"/>
		
		 <div class="form-group">
		 <label class="col-sm-2 control-label">帖子类别</label>
			<select style="margin-left:15px;width:140px;" id="select" name="postCategory">
				<option value="主题帖"  selected>主题帖</option>
				<option value="交友贴">交友贴</option>
				<option value="投诉建议贴">投诉建议贴</option>
			</select>
		 </div>
		
		  <div class="form-group">
			<label class="col-sm-2 control-label">帖子标题</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="帖子标题" name="postTitle">
			</div>
		  </div>
		  
		  		  
		  <div class="form-group">
			<label class="col-sm-2 control-label">帖子图片</label>
			<div class="col-sm-10">
			 	<input type="file" id="addPostUp" name="file"/>
				<div><img id="addPostPic" width="120" height="120" /></div> 
			</div>
		  </div>
		  
		   <div class="form-group">
			<label class="col-sm-2 control-label">帖子内容</label>
			<div class="col-sm-10">
					<div id="add-editor"></div>
			  <input type="hidden" name="postContent" id="addPostContent"/>
			</div>
		  </div>

	
      
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="submit" class="btn btn-primary" onclick="return valueToAddInput();">确认添加</button>
      </div>
      
      </form>
       <!--添加帖子表单结束-->
      	
      </div>
      </div>
      </div>
    </div>	
 <!--添加帖子模态框结束-->
      
         


<!-- 查看帖子模态框开始 -->
<div class="modal fade" id="look" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="overflow-y:scroll;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">查看帖子</h4>
      </div>
      <div class="modal-body" >
		<div class="form-horizontal" >
		
		<div class="form-group">
		 <label class="col-sm-2 control-label">帖子类别</label>
			<select type="select" style="margin-left:15px;width:140px;" id="lpostCategory" disabled="disabled">
				<option value="主题帖"  selected>主题帖</option>
				<option value="交友贴">交友贴</option>
				<option value="投诉建议贴">投诉建议贴</option>
			</select>
		 </div>
		
		  <div class="form-group" >
			<label class="col-sm-2 control-label">帖子标题</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control" placeholder="帖子标题" id="lpostTitle" disabled="disabled">
			</div>
		  </div>
		  
		   <div class="form-group">
			<label class="col-sm-2 control-label">帖子图片</label>
			<div class="col-sm-10">
			  <img width="120" height="120" id="lpostPic"/>
			</div>
		  </div>
		  
		   <div class="form-group">
			<label class="col-sm-2 control-label">帖子内容</label>
			<div class="col-sm-10">
				<div id="lpostContent" style="width:480px;height:tauto;;"></div>
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
 <!--查看帖子模态框结束-->

         
         
         
<!-- 修改帖子模态框开始 -->
<div class="modal fade" id="modify" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="overflow-y:scroll;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">修改帖子</h4>
      </div>
      <div class="modal-body">
        <!--修改活动表单-->
		<form class="form-horizontal" action="<%=basePath%>post/doAlterPost.do" method="post" enctype="multipart/form-data">
		
		<input type="hidden" name="postNo" id="apostNo"/>
		<input type="hidden" name="userNo" id="auserNo"/>
		<input type="hidden" name="postState" id="apostState"/>
		
		<div class="form-group">
		 <label class="col-sm-2 control-label">帖子类别</label>
			<select style="margin-left:15px;width:140px;" type="select" id="apostCategory" name="postCategory">
				<option value="主题帖"  selected>主题帖</option>
				<option value="交友贴">交友贴</option>
				<option value="投诉建议贴">投诉建议贴</option>
			</select>
		 </div>
		
		  <div class="form-group">
			<label class="col-sm-2 control-label">帖子标题</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control" placeholder="活动标题" name="postTitle" id="apostTitle">
			</div>
		  </div>
		  
		  		  
		  <div class="form-group">
			<label class="col-sm-2 control-label">帖子图片</label>
			<div class="col-sm-10">
				<input type="file" id="postAlertUp" name="file"/>
				<div><img id="postAlertPic" width="120" height="120" class="apostPic"/></div>
				<input type="hidden" name="postPic" id="kpostPic"/>
			</div>
		  </div>
		  
		   <div class="form-group">
			<label class="col-sm-2 control-label">帖子内容</label>
			<div class="col-sm-10">
				<div id="simple-editor"></div>
			  <input type="hidden" name="postContent" id="apostContent"/>
			</div>
		  </div>

		  

      
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="submit" class="btn btn-primary" onclick="return valueToAlertInput();">确认修改</button>
      </div>
      
      </form>
       <!--修改活动表单结束-->
      	
      </div>
      </div>
      </div>
    </div>	
 <!--修改活动模态框结束-->    
 






</body>
  
  
 <script type="text/javascript">

var postState= ${postState};
var pageSize = 6;

function loadPost(){

	$('.date_picker').date_input();
	$("#addPostUp").uploadPreview({ Img: "addPostPic", Width: 120, Height: 120 });
	$("#postAlertUp").uploadPreview({ Img: "postAlertPic", Width: 120, Height: 120 });
	
	var action ="doGetAllPost.do";
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
/* 		case 3:
			$("#postNameShow").html("热门帖子");
			$("#addPostShow").hide();
			break; */
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
	$.ajax({
		type:"post",
		url:"<%=basePath%>post/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&postState="+postState, 
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
/* 		                     "<a class='btn btn-info' href='javascript:hotPost(\""+post.postNo+"\")' role='button'>置热</a>" + */
		                     "<a class='btn btn-info' href='javascript:topPost(\""+post.postNo+"\")' role='button'>置顶</a>" +
		                     "<a class='btn btn-info' href='javascript:overduePost(\""+post.postNo+"\")' role='button'>删除</a>";
		                     break;
		            case 2:
		            	str += "<td>" + moment(post.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertPost(\""+post.postNo+"\")' role='button'>修改</a>"+
		                     "<a class='btn btn-info' href='javascript:commonPost(\""+post.postNo+"\")' role='button'>置普</a>" +
/* 		                     "<a class='btn btn-info' href='javascript:hotPost(\""+post.postNo+"\")' role='button'>置热</a>" + */
		                     "<a class='btn btn-info' href='javascript:topPost(\""+post.postNo+"\")' role='button'>置顶</a>" +
		                     "<a class='btn btn-info' href='javascript:overduePost(\""+post.postNo+"\")' role='button'>删除</a>";
	                     break;
		            case 3:
		            	str += "<td>" + moment(post.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertPost(\""+post.postNo+"\")' role='button'>修改</a>"+
		                     "<a class='btn btn-info' href='javascript:commonPost(\""+post.postNo+"\")' role='button'>置普</a>" +
		                     "<a class='btn btn-info' href='javascript:passPost(\""+post.postNo+"\")' role='button'>置精</a>" +
		                     "<a class='btn btn-info' href='javascript:topPost(\""+post.postNo+"\")' role='button'>置顶</a>" +
		                     "<a class='btn btn-info' href='javascript:overduePost(\""+post.postNo+"\")' role='button'>删除</a>";
	                     break;
		            case 4:
		            	str += "<td>" + moment(post.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertPost(\""+post.postNo+"\")' role='button'>修改</a>"+
		                     "<a class='btn btn-info' href='javascript:commonPost(\""+post.postNo+"\")' role='button'>置普</a>" +
		                     "<a class='btn btn-info' href='javascript:passPost(\""+post.postNo+"\")' role='button'>置精</a>" +
/* 		                     "<a class='btn btn-info' href='javascript:topPost(\""+post.postNo+"\")' role='button'>置热</a>" + */
		                     "<a class='btn btn-info' href='javascript:overduePost(\""+post.postNo+"\")' role='button'>删除</a>";
	                     break;
		            case 5:
						 str += "<td>" +
		                     "<a class='btn btn-default' href='javascript:recoverPost(\""+post.postNo+"\")' role='button'>恢复</a>"+
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
			          		data:"pageNow="+page+"&pageSize="+pageSize+"&postState="+postState, 
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
/* 			        		                     "<a class='btn btn-info' href='javascript:hotPost(\""+post1.postNo+"\")' role='button'>置热</a>" + */
			        		                     "<a class='btn btn-info' href='javascript:topPost(\""+post1.postNo+"\")' role='button'>置顶</a>" +
			        		                     "<a class='btn btn-info' href='javascript:overduePost(\""+post1.postNo+"\")' role='button'>删除</a>";
			        		                     break;
			        		            case 2:
			        		            	str1 += "<td>" + moment(post1.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
			        		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertPost(\""+post1.postNo+"\")' role='button'>修改</a>"+
			        		                     "<a class='btn btn-info' href='javascript:commonPost(\""+post1.postNo+"\")' role='button'>置普</a>" +
/* 			        		                     "<a class='btn btn-info' href='javascript:hotPost(\""+post1.postNo+"\")' role='button'>置热</a>" + */
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
/* 			        		                     "<a class='btn btn-info' href='javascript:topPost(\""+post1.postNo+"\")' role='button'>置热</a>" + */
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



$('#simple-editor').trumbowyg();
$('#add-editor').trumbowyg();
$.trumbowyg.btnsGrps.test = ['bold', 'link'];
$.extend(true, $.trumbowyg.langs, {
    fr: {
        align: 'Alignement',
        image: 'Image'
    }
});



function valueToAddInput(){
	$("#addPostContent").val($("#add-editor").html());
	
	if($("#addPostUp").val()==null||$("#addPostUp").val()==""){
 		alert("请上活动图片！");
		return false; 
	}else{
		return true;
	}
	
}


function valueToAlertInput(){
	$("#apostContent").val($("#simple-editor").html());
	if($("#postAlertUp").val()==null||$("#postAlertUp").val()==""){
		$("#kpostPic").val("fail");
	}else{
		$("#kpostPic").val("success");
	}
	return true;
}
</script>
<script type="text/javascript" src="<%=basePath%>js/back/background-common.js"></script>  
  
  
</html>
