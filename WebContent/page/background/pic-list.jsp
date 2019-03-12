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
    <title>照片列表</title>
	<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/bootstrap-theme.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/date-picker.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/common.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/bootstrap-paginator.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/back/piclist-back.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.date_input.pack.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/browser.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/moment.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/picUpload.js"></script>
	
<style type="text/css">
.picDesTd{
	width: 300px;
}
</style>

</head>
<body onload="loadPic();">   
  
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">后台</li>
	  <li class="active">照片管理</li>
	  <li id="picNameShow" class="active">待审核照片</li>
	</ol>
	
	<div class="searchBar">
		<div class="searchTop">搜索栏</div>
		<div class="cutLine"></div>
		<div class="form-inline">
		  <div class="form-group">
		  <span class="itemLeftFirst">搜索条件:</span>
			<input type="text" class="searchItem" id="searchUserName" placeholder="用户名">
			<input type="text" class="itemLeft searchItem" id="searchPicDes" placeholder="照片描述">
		  </div>
		</div>

		<div class="form-inline searchBarTwo">
		  <div class="form-group">
		  <span class="itemLeftFirst searchPicTimeName">发布时间:</span>
			<input type="text" class="searchItem date_picker searchPicTimeName" id="searchStartTime" placeholder="起始时间">
			<input type="text" class="itemLeft searchItem date_picker searchPicTimeName" id="searchEndTime" placeholder="结束时间">
		  <button type="button" class="submitSearch btn" onclick="submitSearch();" style="margin-left:449px;">搜索</button>
			</div>
		</div>
	</div>

	<button id="addPicShow" class="btn btn-info btn-md active" type="button" data-toggle="modal" data-target="#toAddPic">添加精品照片</button>
	<div class="widget-box">
		<table class="table table-hover table-bordered table-striped table-responsive">
			<thead>
				<tr>
					<td>照片</td>
					<td>描述</td>
					<td>发布者</td>
					<td id="picPubTimeShow">发布时间</td>
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





<!-- 添加精品照片模态框开始 -->
<div class="modal fade" id="toAddPic" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="overflow-y:scroll;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">添加照片</h4>
      </div>
      <div class="modal-body">
        <!--添加精品照片表单-->
		<form class="form-horizontal" action="<%=basePath%>pic/addPic.do" method="post" enctype="multipart/form-data">
		
		<input type="hidden" name="userNo" value="${currentUser.currentNo}"/>
		<input type="hidden" name="picState" value="${picState}"/>
		
		  <div class="form-group">
			<label class="col-sm-2 control-label">照片</label>
			<div class="col-sm-10">
			 	<input type="file" id="addPicUp" name="file"/>
				<div><img id="addPicPic" width="120" height="120" /></div> 
			</div>
		  </div>
		  
		  <div class="form-group">
			<label class="col-sm-2 control-label">照片描述</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="照片描述" name="picDes">
			</div>
		  </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="submit" class="btn btn-primary" onclick="return valueToAddInput();">确认添加</button>
      </div>
      
      </form>
       <!--添加精品照片表单结束-->
      	
      </div>
      </div>
      </div>
    </div>	
 <!--添加精品照片模态框结束-->
      
         
         
<!-- 修改精品照片模态框开始 -->
<div class="modal fade" id="modify" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="overflow-y:scroll;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">修改照片</h4>
      </div>
      <div class="modal-body">
        <!--修改活动表单-->
		<form class="form-horizontal" action="<%=basePath%>pic/doAlterPic.do" method="post" enctype="multipart/form-data">
		
		<input type="hidden" name="picNo" id="apicNo"/>
		<input type="hidden" name="userNo" id="auserNo"/>
		<input type="hidden" name="picState" id="apicState"/>
		
		  <div class="form-group">
			<label class="col-sm-2 control-label">照片</label>
			<div class="col-sm-10">
				<input type="file" id="picAlertUp" name="file"/>
				<div><img id="picAlertPic" width="120" height="120" class="apicPic"/></div>
				<input type="hidden" name="picPath" id="kpicPath"/>
			</div>
		  </div>
		  
		  <div class="form-group">
			<label class="col-sm-2 control-label">描述</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control" placeholder="照片描述" name="picDes" id="apicDes">
			</div>
		  </div>
		  
      
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="submit" class="btn btn-primary" onclick="return valueToAlertInput();">确认修改</button>
      </div>
      
      </form>
       <!--修改精品照片表单结束-->
      	
      </div>
      </div>
      </div>
    </div>	
 <!--修改精品照片模态框结束-->    
 






</body>
  
  
 <script type="text/javascript">

var picState= ${picState};
var pageSize = 6;

function loadPic(){

	$('.date_picker').date_input();
	$("#addPicUp").uploadPreview({ Img: "addPicPic", Width: 120, Height: 120 });
	$("#picAlertUp").uploadPreview({ Img: "picAlertPic", Width: 120, Height: 120 });
	
	var action ="doGetAllPic.do";
	switch(picState){
		case 3:
			$("#picNameShow").html("待审核照片");
			$("#addPicShow").hide();
			$("#picPubTimeShow").hide();
			$(".searchPicTimeName").hide();
			break;
		case 4:
			$("#picNameShow").html("精品照片");
			break;
		case 5:
			$("#picNameShow").html("过期照片");
			$("#addPicShow").hide();
			$("#picPubTimeShow").hide();
			$(".searchPicTimeName").hide();
			break;
	}
	$.ajax({
		type:"post",
		url:"<%=basePath%>pic/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&picState="+picState, 
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
			            	url:"<%=basePath%>pic/"+action,
			          		data:"pageNow="+page+"&pageSize="+pageSize+"&picState="+picState, 
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



function valueToAddInput(){
	if($("#addPicUp").val()==null||$("#addPicUp").val()==""){
 		alert("请上活动图片！");
		return false; 
	}else{
		return true;
	}
	
}


function valueToAlertInput(){
	if($("#picAlertUp").val()==null||$("#picAlertUp").val()==""){
		$("#kpicPath").val("fail");
	}else{
		$("#kpicPath").val("success");
	}
	return true;
}





			  
</script>
  
  
  
</html>
