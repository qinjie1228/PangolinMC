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
    <title>活动预约列表</title>
	<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/bootstrap-theme.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/date-picker.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/common.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/bootstrap-paginator.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/back/mactlist-back.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.date_input.pack.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/browser.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/moment.min.js"></script>

</head>
<body onload="loadMact();">   
  
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">后台</li>
	  <li class="active">活动预约</li>
	  <li id="mactNameShow" class="active">已成功预约活动记录</li>
	</ol>
	
	<div class="searchBar">
		<div class="searchTop">搜索栏</div>
		<div class="cutLine"></div>
		<div class="form-inline">
		  <div class="form-group">
		  <span class="itemLeftFirst">搜索条件:</span>
			<input type="text" class="searchItem" id="searchUserName" placeholder="用户名">
			<input type="text" class="itemLeft searchItem" id="searchActTitle" placeholder="活动标题">
		  </div>
		</div>

		<div class="form-inline searchBarTwo">
		  <div class="form-group">
		  <span class="itemLeftFirst mactResTimeSeachShow">发布时间:</span>
			<input type="text" class="searchItem date_picker mactResTimeSeachShow" id="searchStartTime" placeholder="起始时间">
			<input type="text" class="itemLeft searchItem date_picker mactResTimeSeachShow" id="searchEndTime" placeholder="结束时间">
		  <button type="button" class="submitSearch btn" onclick="submitSearch();" style="margin-left:449px;">搜索</button>
			</div>
		</div>
	</div>

	<div class="widget-box">
		<table class="table table-hover table-bordered table-striped table-responsive">
			<thead>
				<tr>
					<td>活动名称</td>
					<td>预约者</td>
					<td id="mactResTimeShow">预约时间</td>
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


</body>
  
  
 <script type="text/javascript">

var actResState= ${actResState};
var pageSize = 6;

function loadMact(){
	$('.date_picker').date_input();
	
	var action ="doGetAllMact.do";
	switch(actResState){
		case 1:
			$("#mactNameShow").html("待审核活动预约记录");
			$(".mactResTimeSeachShow").hide();
			$("#mactResTimeShow").hide();
			break;
		case 2:
			$("#mactNameShow").html("已成功预约活动记录");
			break;
		case 3:
			$("#mactNameShow").html("未通过活动预约记录");
			$(".mactResTimeSeachShow").hide();
			$("#mactResTimeShow").hide();
			break;
		case 4:
			$("#mactNameShow").html("过期活动预约记录");
			break;
	}
	$.ajax({
		type:"post",
		url:"<%=basePath%>mact/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&actResState="+actResState, 
		dataType:"json",
		success:function(data){
			$("#tbody").html("");
			 var str = "";  
			 $(data.data).each(function(i,mact){
				 str += "<tr class='success'>";  
                 var actTitle = mact.actTitle;
                 if(actTitle.length > 36){
                	 actTitle = mact.substring(0,36) + "...";
                 }
                 str += "<td>" + actTitle + "</td>" + 
                 "<td>" + mact.userName + "</td>"; 
                 switch(Number(mact.actResState)){
					case 1:
						 str += 
							 "<td>" +
		                     "<a class='btn btn-default' href='javascript:passMact(\""+mact.mactNo+"\")' role='button'>通过</a>"+
		                     "<a class='btn btn-info' href='javascript:failMact(\""+mact.mactNo+"\")' role='button'>否决</a>";
		                     break;
					case 2:
						 str +=
							 "<td>" + moment(mact.actResTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
							 "<a class='btn btn-info' href='javascript:failMactAgain(\""+mact.mactNo+"\")' role='button'>否决</a>"+
		                     "<a class='btn btn-info' href='javascript:overdueMact(\""+mact.mactNo+"\")' role='button'>删除</a>";
		                     break;
		            case 3:
		            	 str +=
		            		 "<td>" +
		            		 "<a class='btn btn-default' href='javascript:passMact(\""+mact.mactNo+"\")' role='button'>通过</a>"+
		                	 "<a class='btn btn-info' href='javascript:deleteMact(\""+mact.mactNo+"\")' role='button'>删除</a>";
		                	 break;
		            case 4:
		            	 str +=
		            		 "<td>" + moment(mact.actResTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
		                	 "<a class='btn btn-default' href='javascript:recoverMact(\""+mact.mactNo+"\")' role='button'>恢复</a>"+
		                     "<a class='btn btn-info' href='javascript:deleteMact(\""+mact.mactNo+"\")' role='button'>彻底删除</a>";
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
			            	url:"<%=basePath%>mact/"+action,
			          		data:"pageNow="+page+"&pageSize="+pageSize+"&actResState="+actResState, 
			          		dataType:"json",
			                success: function (msg) {
			                	var str1 = ""; 
			                	  $(msg.data).each(function(i,mact1){ 
			                		  str1 += "<tr class='success'>";  
			                          var actTitle1 = mact1.actTitle;
			                          if(actTitle1.length > 36){
			                         	 actTitle1 = mact1.substring(0,36) + "...";
			                          }
			                          str1 += "<td>" + actTitle1 + "</td>" + 
			                          "<td>" + mact1.userName + "</td>";   
			                          switch(Number(mact1.actResState)){
			         					case 1:
			         						 str1 += 
			         							 "<td>" +
			         		                     "<a class='btn btn-default' href='javascript:passMact(\""+mact1.mactNo+"\")' role='button'>通过</a>"+
			         		                     "<a class='btn btn-info' href='javascript:failMact(\""+mact1.mactNo+"\")' role='button'>否决</a>";
			         		                     break;
			         					case 2:
			         						 str1 +=
			         							 "<td>" + moment(mact1.actResTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
			         							 "<a class='btn btn-info' href='javascript:failMactAgain(\""+mact1.mactNo+"\")' role='button'>否决</a>"+
			         		                     "<a class='btn btn-info' href='javascript:overdueMact(\""+mact1.mactNo+"\")' role='button'>删除</a>";
			         		                     break;
			         		            case 3:
			         		            	 str1 +=
			         		            		 "<td>" +
			         		            		 "<a class='btn btn-default' href='javascript:passMact(\""+mact1.mactNo+"\")' role='button'>通过</a>"+
			         		                	 "<a class='btn btn-info' href='javascript:deleteMact(\""+mact1.mactNo+"\")' role='button'>删除</a>";
			         		                	 break;
			         		            case 4:
			         		            	 str1 +=
			         		            		 "<td>" + moment(mact1.actResTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
			         		                	 "<a class='btn btn-default' href='javascript:recoverMact(\""+mact1.mactNo+"\")' role='button'>恢复</a>"+
			         		                     "<a class='btn btn-info' href='javascript:deleteMact(\""+mact1.mactNo+"\")' role='button'>彻底删除</a>";
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
