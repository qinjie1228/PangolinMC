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
    <title>公告列表</title>
	<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/bootstrap-theme.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/date-picker.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="<%=basePath%>trumbowyg/design/css/trumbowyg.css">
	<link href="<%=basePath%>css/common.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/bootstrap-paginator.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/back/noticelist-back.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.date_input.pack.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/browser.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/moment.min.js"></script>
	
	<script src="<%=basePath%>trumbowyg/trumbowyg.js"></script>
    <script src="<%=basePath%>trumbowyg/langs/fr.js"></script>
	<script src="<%=basePath%>trumbowyg/plugins/upload/trumbowyg.upload.js"></script>
	<script src="<%=basePath%>trumbowyg/plugins/base64/trumbowyg.base64.js"></script>
	
<style type="text/css">
.NoticeTitleTd{
	width: 250px;
}
</style>

</head>
<body onload="loadNotice();">   
  
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">后台</li>
	  <li class="active">公告管理</li>
	  <li id="noticeNameShow" class="active">已发布公告</li>
	</ol>
	
	<div class="searchBar">
		<div class="searchTop">搜索栏</div>
		<div class="cutLine"></div>
		<div class="form-inline">
		  <div class="form-group">
		  <span class="itemLeftFirst">搜索条件:</span>
			<input type="text" class="searchItem" id="searchUserName" placeholder="用户名">
			<input type="text" class="itemLeft searchItem" id="searchNoticeTitle" placeholder="公告标题">
		  </div>
		</div>

		<div class="form-inline searchBarTwo">
		  <div class="form-group">
		  <span class="itemLeftFirst searchNoticeTimeName">发布时间:</span>
			<input type="text" class="searchItem date_picker searchNoticeTimeName" id="searchStartTime" placeholder="起始时间">
			<input type="text" class="itemLeft searchItem date_picker searchNoticeTimeName" id="searchEndTime" placeholder="结束时间">
		  <button type="button" class="submitSearch btn" onclick="submitSearch();" style="margin-left:449px;">搜索</button>
			</div>
		</div>
	</div>

	<button id="addNoticeShow" class="btn btn-info btn-md active" type="button" data-toggle="modal" data-target="#toAddNotice">添加公告</button>
	<div class="widget-box">
		<table class="table table-hover table-bordered table-striped table-responsive">
			<thead>
				<tr>
					<td>公告标题</td>
					<td>发布者</td>
					<td id="NoticePubTimeShow">发布时间</td>
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





<!-- 添加公告模态框开始 -->
<div class="modal fade" id="toAddNotice" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="overflow-y:scroll;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">添加公告</h4>
      </div>
      <div class="modal-body">
        <!--添加公告表单-->
		<form class="form-horizontal" action="<%=basePath%>notice/addNotice.do" method="post">
		
		<input type="hidden" name="userNo" value="${currentUser.currentNo}"/>
		<input type="hidden" name="noticeState" value="${noticeState}"/>
		
		  <div class="form-group">
			<label class="col-sm-2 control-label">活动标题</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="公告标题" name="noticeTitle">
			</div>
		  </div>
		  		  
		   <div class="form-group">
			<label class="col-sm-2 control-label">公告内容</label>
			<div class="col-sm-10">
					<div id="add-editor"></div>
			  <input type="hidden" name="noticeContent" id="addNoticeContent"/>
			</div>
		  </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="submit" class="btn btn-primary" onclick="return valueToAddInput();">确认添加</button>
      </div>
      
      </form>
       <!--添加公告表单结束-->
      	
      </div>
      </div>
      </div>
    </div>	
 <!--添加公告模态框结束-->
      
         


<!-- 查看公告模态框开始 -->
<div class="modal fade" id="look" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="overflow-y:scroll;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">查看公告</h4>
      </div>
      <div class="modal-body" >
		<div class="form-horizontal" >
		  <div class="form-group" >
			<label class="col-sm-2 control-label">公告标题</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control" placeholder="活动标题" id="lnoticeTitle" disabled="disabled">
			</div>
		  </div>
		  
		   <div class="form-group">
			<label class="col-sm-2 control-label">公告内容</label>
			<div class="col-sm-10">
				<div id="lnoticeContent" style="width:480px;height:tauto;;"></div>
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
 <!--查看公告模态框结束-->

         
         
         
<!-- 修改公告模态框开始 -->
<div class="modal fade" id="modify" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="overflow-y:scroll;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">修改活动</h4>
      </div>
      <div class="modal-body">
        <!--修改活动表单-->
		<form class="form-horizontal" action="<%=basePath%>notice/doAlterNotice.do" method="post">
		
		<input type="hidden" name="noticeNo" id="anoticeNo"/>
		<input type="hidden" name="userNo" id="auserNo"/>
		<input type="hidden" name="noticeState" id="anoticeState"/>
		
		  <div class="form-group">
			<label class="col-sm-2 control-label">活动标题</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control" placeholder="活动标题" name="noticeTitle" id="anoticeTitle">
			</div>
		  </div>
		  
		   <div class="form-group">
			<label class="col-sm-2 control-label">活动内容</label>
			<div class="col-sm-10">
				<div id="simple-editor"></div>
			  <input type="hidden" name="noticeContent" id="anoticeContent"/>
			</div>
		  </div>

      
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="submit" class="btn btn-primary" onclick="return valueToAlertInput();">确认修改</button>
      </div>
      
      </form>
       <!--修改公告表单结束-->
      	
      </div>
      </div>
      </div>
    </div>	
 <!--修改公告模态框结束-->    
 


</body>
  
  
 <script type="text/javascript">

var noticeState= ${noticeState};
var pageSize = 6;

function loadNotice(){

	$('.date_picker').date_input();
	
	var action ="doGetAllNotice.do";
	switch(noticeState){
		case 1:
			$("#noticeNameShow").html("已发布公告");
			break;
		case 2:
			$("#noticeNameShow").html("过期公告");
			$(".searchNoticeTimeName").hide();
			$("#addNoticeShow").hide();
			$("#NoticePubTimeShow").hide();
			break;
	}
	$.ajax({
		type:"post",
		url:"<%=basePath%>notice/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&noticeState="+noticeState, 
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
			          		data:"pageNow="+page+"&pageSize="+pageSize+"&noticeState="+noticeState, 
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
	$("#addNoticeContent").val($("#add-editor").html());
	return true;
}


function valueToAlertInput(){
	$("#anoticeContent").val($("#simple-editor").html());
	return true;
}
		  
</script>
  
  
  
</html>
