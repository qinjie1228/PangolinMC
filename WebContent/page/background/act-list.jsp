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
    <title>活动列表</title>
	<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/bootstrap-theme.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/date-picker.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="<%=basePath%>trumbowyg/design/css/trumbowyg.css">
	<link href="<%=basePath%>css/common.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/bootstrap-paginator.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/back/actlist-back.js"></script>
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
.actTitleTd{
	width: 300px;
}
</style>

</head>
<body onload="loadAct();">   
  
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">后台</li>
	  <li class="active">活动管理</li>
	  <li id="actNameShow" class="active">已发布活动</li>
	</ol>
	
	<div class="searchBar">
		<div class="searchTop">搜索栏</div>
		<div class="cutLine"></div>
		<div class="form-inline">
		  <div class="form-group">
		  <span class="itemLeftFirst">搜索条件:</span>
			<input type="text" class="searchItem" id="searchUserName" placeholder="用户名">
			<input type="text" class="itemLeft searchItem" id="searchActNum" placeholder="预约人数">
			<input type="text" class="itemLeft searchItem" id="searchActTitle" placeholder="活动标题">
		  </div>
		</div>

		<div class="form-inline searchBarTwo">
		  <div class="form-group">
		  <span class="itemLeftFirst searchActTimeName">发布时间:</span>
			<input type="text" class="searchItem date_picker searchActTimeName" id="searchStartTime" placeholder="起始时间">
			<input type="text" class="itemLeft searchItem date_picker searchActTimeName" id="searchEndTime" placeholder="结束时间">
		  <button type="button" class="submitSearch btn" onclick="submitSearch();" style="margin-left:449px;">搜索</button>
			</div>
		</div>
	</div>

	<button id="addActShow" class="btn btn-info btn-md active" type="button" data-toggle="modal" data-target="#toAddAct">添加活动</button>
	<div class="widget-box">
		<table class="table table-hover table-bordered table-striped table-responsive">
			<thead>
				<tr>
					<td>活动标题</td>
					<td>发布者</td>
					<td>预约人数</td>
					<td id="actPubTimeShow">发布时间</td>
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





<!-- 添加活动模态框开始 -->
<div class="modal fade" id="toAddAct" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="overflow-y:scroll;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">添加活动</h4>
      </div>
      <div class="modal-body">
        <!--添加活动表单-->
		<form class="form-horizontal" action="<%=basePath%>act/addAct.do" method="post" enctype="multipart/form-data">
		
		<input type="hidden" name="userNo" value="${currentUser.currentNo}"/>
		<input type="hidden" name="actNum" value="0"/>
		<input type="hidden" name="actState" value="${actState}"/>
		
		  <div class="form-group">
			<label class="col-sm-2 control-label">活动标题</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="活动标题" name="actTitle">
			</div>
		  </div>
		  
		  		  
		  <div class="form-group">
			<label class="col-sm-2 control-label">活动图片</label>
			<div class="col-sm-10">
			 	<input type="file" id="addActUp" name="file"/>
				<div><img id="addActPic" width="120" height="120" /></div> 
			</div>
		  </div>
		  
		   <div class="form-group">
			<label class="col-sm-2 control-label">活动内容</label>
			<div class="col-sm-10">
					<div id="add-editor" ></div>
			  <input type="hidden" name="actContent" id="addActContent"/>
			</div>
		  </div>

	
      
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="submit" class="btn btn-primary" onclick="return valueToAddInput();">确认添加</button>
      </div>
      
      </form>
       <!--添加活动表单结束-->
      	
      </div>
      </div>
      </div>
    </div>	
 <!--添加活动模态框结束-->
      
         


<!-- 查看活动模态框开始 -->
<div class="modal fade" id="look" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="overflow-y:scroll;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">查看活动</h4>
      </div>
      <div class="modal-body" >
		<div class="form-horizontal" >
		  <div class="form-group" >
			<label class="col-sm-2 control-label">活动标题</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control" placeholder="活动标题" id="lactTitle" disabled="disabled">
			</div>
		  </div>
		  
		   <div class="form-group">
			<label class="col-sm-2 control-label">活动图片</label>
			<div class="col-sm-10">
			  <img width="120" height="120" id="lactPic"/>
			</div>
		  </div>
		  
		   <div class="form-group">
			<label class="col-sm-2 control-label">活动内容</label>
			<div class="col-sm-10">
				<div id="lactContent" style="width:480px;height:tauto;;"></div>
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
 <!--查看活动模态框结束-->

         
         
         
<!-- 修改活动模态框开始 -->
<div class="modal fade" id="modify" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="overflow-y:scroll;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">修改活动</h4>
      </div>
      <div class="modal-body">
        <!--修改活动表单-->
		<form class="form-horizontal" action="<%=basePath%>act/doAlterAct.do" method="post" enctype="multipart/form-data">
		
		<input type="hidden" name="actNo" id="aactNo"/>
		<input type="hidden" name="userNo" id="auserNo"/>
		<input type="hidden" name="actNum" id="aactNum"/>
		<input type="hidden" name="actState" id="aactState"/>
		
		  <div class="form-group">
			<label class="col-sm-2 control-label">活动标题</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control" placeholder="活动标题" name="actTitle" id="aactTitle">
			</div>
		  </div>
		  
		  		  
		  <div class="form-group">
			<label class="col-sm-2 control-label">活动图片</label>
			<div class="col-sm-10">
				<input type="file" id="actAlertUp" name="file"/>
				<div><img id="actAlertPic" width="120" height="120" class="aactPic"/></div>
				<input type="hidden" name="actPic" id="kactPic"/>
			</div>
		  </div>
		  
		   <div class="form-group">
			<label class="col-sm-2 control-label">活动内容</label>
			<div class="col-sm-10">
				<div id="simple-editor"></div>
			  <input type="hidden" name="actContent" id="aactContent"/>
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

var actState= ${actState};
var pageSize = 6;

function loadAct(){

	$('.date_picker').date_input();
	$("#addActUp").uploadPreview({ Img: "addActPic", Width: 120, Height: 120 });
	$("#actAlertUp").uploadPreview({ Img: "actAlertPic", Width: 120, Height: 120 });
	
	var action ="doGetAllAct.do";
	switch(actState){
		case 1:
			$("#actNameShow").html("待审核活动");
			$("#addActShow").hide();
			$("#actPubTimeShow").hide();
			$(".searchActTimeName").hide();
			break;
		case 2:
			$("#actNameShow").html("已发布活动");
			break;
		case 3:
			$("#actNameShow").html("未通过活动");
			$("#addActShow").hide();
			$("#actPubTimeShow").hide();
			$(".searchActTimeName").hide();
			break;
		case 4:
			$("#actNameShow").html("过期活动");
			$("#addActShow").hide();
			break;
	}
	$.ajax({
		type:"post",
		url:"<%=basePath%>act/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&actState="+actState, 
		dataType:"json",
		success:function(data){
			$("#tbody").html("");
			 var str = "";  
			 $(data.data).each(function(i,act){ 
				 str += "<tr class='success'>" +  
                 "<td class='actTitleTd'>";
                 var actTitle = act.actTitle;
                 if(actTitle.length > 18){
                	 actTitle = actTitle.substring(0,18) + "...";
                 }
                 str += actTitle + "</td>" + 
                 "<td>" + act.userName + "</td>" + 
                 "<td>" + act.actNum + "</td>";  
                 switch(Number(act.actState)){
					case 1:
						 str += "<td>" +
		                	 "<a class='btn btn-default' data-toggle='modal' data-target='#look' onclick='toLookAct(\""+act.actNo+"\")' role='button'>查看</a>"+
		                     "<a class='btn btn-default' href='javascript:passAct(\""+act.actNo+"\")' role='button'>通过</a>"+
		                     "<a class='btn btn-info' href='javascript:failAct(\""+act.actNo+"\")' role='button'>否决</a>";
		                     break;
					case 2:
						 str += "<td>" + moment(act.actPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertAct(\""+act.actNo+"\")' role='button'>修改</a>"+
		                     "<a class='btn btn-info' href='javascript:overdueAct(\""+act.actNo+"\")' role='button'>删除</a>";
		                     break;
		            case 3:
		            	 str += "<td>" +
		                	 "<a class='btn btn-info' href='javascript:deleteAct(\""+act.actNo+"\")' role='button'>删除</a>";
		                	 break;
		            case 4:
		            	 str += "<td>" + moment(act.actPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
		                	 "<a class='btn btn-default' href='javascript:recoverAct(\""+act.actNo+"\")' role='button'>恢复</a>"+
		                     "<a class='btn btn-info' href='javascript:deleteAct(\""+act.actNo+"\")' role='button'>彻底删除</a>";
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
			            	url:"<%=basePath%>act/"+action,
			          		data:"pageNow="+page+"&pageSize="+pageSize+"&actState="+actState, 
			          		dataType:"json",
			                success: function (msg) {
			                	var str1 = ""; 
			                	  $(msg.data).each(function(i,act1){ 
			                		 str1 += "<tr class='success'>" +  
			                         "<td class='actTitleTd'>";
			                         var actTitle1 = act1.actTitle;
			                         if(actTitle1.length > 18){
			                         	actTitle1 = actTitle1.substring(0,18) + "...";
			                         }
			                         str1 += actTitle1 + "</td>" + 
			                         "<td>" + act1.userName + "</td>" +  
			                         "<td>" + act1.actNum + "</td>"; 
			                         switch(Number(act1.actState)){
				     					case 1:
				     						 str1 += "<td>" +
				     		                	 "<a class='btn btn-default' data-toggle='modal' data-target='#look' onclick='toLookAct(\""+act1.actNo+"\")' role='button'>查看</a>"+
				     		                     "<a class='btn btn-default' href='javascript:passAct(\""+act1.actNo+"\")' role='button'>通过</a>"+
				     		                     "<a class='btn btn-info' href='javascript:failAct(\""+act1.actNo+"\")' role='button'>否决</a>";
				     		                     break;
				     					case 2:
				     						 str1 += "<td>" + moment(act1.actPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
				     		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertAct(\""+act1.actNo+"\")' role='button'>修改</a>"+
				     		                     "<a class='btn btn-info' href='javascript:overdueAct(\""+act1.actNo+"\")' role='button'>删除</a>";
				     		                     break;
				     		            case 3:
				     		            	 str1 += "<td>" +
				     		                	 "<a class='btn btn-info' href='javascript:deleteAct(\""+act1.actNo+"\")' role='button'>删除</a>";
				     		                	 break;
				     		            case 4:
				     		            	 str1 += "<td>" + moment(act1.actPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" + 
				     		                	 "<a class='btn btn-default' href='javascript:recoverAct(\""+act1.actNo+"\")' role='button'>恢复</a>"+
				     		                     "<a class='btn btn-info' href='javascript:deleteAct(\""+act1.actNo+"\")' role='button'>彻底删除</a>";
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
	$("#addActContent").val($("#add-editor").html());
	
	if($("#addActUp").val()==null||$("#addActUp").val()==""){
 		alert("请上活动图片！");
		return false; 
	}else{
		return true;
	}
	
}


function valueToAlertInput(){
	$("#aactContent").val($("#simple-editor").html());
	if($("#actAlertUp").val()==null||$("#actAlertUp").val()==""){
		$("#kactPic").val("fail");
	}else{
		$("#kactPic").val("success");
	}
	return true;
}





			  
</script>
  
  
  
</html>
