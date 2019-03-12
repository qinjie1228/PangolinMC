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
    <title>道具列表</title>
	<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/bootstrap-theme.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/date-picker.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="<%=basePath%>trumbowyg/design/css/trumbowyg.css">
	<link href="<%=basePath%>css/common.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/bootstrap-paginator.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/back/toollist-back.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.date_input.pack.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/browser.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/moment.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/picUpload.js"></script>
	
	<script src="<%=basePath%>trumbowyg/trumbowyg.js"></script>
    <script src="<%=basePath%>trumbowyg/langs/fr.js"></script>
	<script src="<%=basePath%>trumbowyg/plugins/upload/trumbowyg.upload.js"></script>
	<script src="<%=basePath%>trumbowyg/plugins/base64/trumbowyg.base64.js"></script>

<style type="text/css">
.toolNameTd{
	width: 300px;
}
</style>

</head>
<body onload="loadTool();">   
  
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">后台</li>
	  <li class="active">道具管理</li>
	  <li id="toolNameShow" class="active">在售道具</li>
	</ol>
	
	<div class="searchBar">
		<div class="searchTop">搜索栏</div>
		<div class="cutLine"></div>
		<div class="form-inline">
		  <div class="form-group">
		  <span class="itemLeftFirst">搜索条件:</span>
			<input type="text" class="searchItem" id="searchToolNum" placeholder="库存">
			<input type="text" class="itemLeft searchItem" id="searchStartPrice" placeholder="起始价格">
			<input type="text" class="itemLeft searchItem" id="searchEndPrice" placeholder="结束价格">
			<input type="text" class="itemLeft searchItem" id="searchToolName" placeholder="道具名称">
		  </div>
		</div>

		<div class="form-inline searchBarTwo">
		  <div class="form-group">
		  <span class="itemLeftFirst overDueHide">发布时间:</span>
			<input type="text" class="searchItem date_picker overDueHide" id="searchStartTime" placeholder="起始时间">
			<input type="text" class="itemLeft searchItem date_picker overDueHide" id="searchEndTime" placeholder="结束时间">
		  <button type="button" class="submitSearch btn" onclick="submitSearch();" style="margin-left:449px;">搜索</button>
			</div>
		</div>
	</div>

	<button id="addToolShow" class="btn btn-info btn-md active" type="button" data-toggle="modal" data-target="#toAddTool" onclick="modelClick();">添加道具</button>
	<div class="widget-box">
		<table class="table table-hover table-bordered table-striped table-responsive">
			<thead>
				<tr>
					<td>道具名称</td>
					<td>库存</td>
					<td>价格</td>
					<td id="actPubTimeTD">发布时间</td>
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


<!-- 添加道具模态框开始 -->
<div class="modal fade" id="toAddTool" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="overflow-y:scroll">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">添加道具</h4>
      </div>
      <div class="modal-body">
        <!--添加道具表单-->
		<form class="form-horizontal" action="<%=basePath%>tool/addTool.do" method="post" enctype="multipart/form-data">
		
		<input type="hidden" name="toolState" value="${toolState}"/>
		
		  <div class="form-group">
			<label class="col-sm-2 control-label">道具名称</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="道具名称" name="toolName">
			</div>
		  </div>
		  
		  <div class="form-group">
			<label class="col-sm-2 control-label">道具库存</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="道具库存" name="toolNum">
			</div>
		  </div>
		  
		  <div class="form-group">
			<label class="col-sm-2 control-label">道具价格</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="道具价格" name="toolPrice">
			</div>
		  </div>
		  
		  <div class="form-group">
			<label class="col-sm-2 control-label">道具图片</label>
			<div class="col-sm-10">
			
			<input type="file" id="addUp" name="file"/>
			<div><img id="addPic" width="120" height="120" /></div> 
			
			</div>
		  </div>
		  
		   <div class="form-group">
			<label class="col-sm-2 control-label">道具描述</label>
			<div class="col-sm-10">
				<div id="add-editor" ></div>
			  <input type="hidden" name="toolDes" id="addToolDes"/>
			</div>
		  </div>
	
      
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="submit" class="btn btn-primary" onclick="return valueToAddInput();">确认添加</button>
      </div>
      
      </form>
       <!--添加道具表单结束-->
      	
      </div>
      </div>
      </div>
    </div>	
 <!--添加道具模态框结束--> 
      
         

         
         
         
<!-- 修改道具模态框开始 -->
<div class="modal fade" id="modify" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="overflow-y: scroll;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">修改道具</h4>
      </div>
      <div class="modal-body">
        <!--修改道具表单-->
		<form class="form-horizontal" action="<%=basePath%>tool/doAlterTool.do" method="post" enctype="multipart/form-data">
		
		<input type="hidden" name="toolNo" id="atoolNo"/>
		<input type="hidden" name="toolState" id="atoolState"/>
		<input type="hidden" name="version" id="aversion"/>
		<input type="hidden" name="toolPic" id="ktoolPic"/>
		  <div class="form-group">
			<label class="col-sm-2 control-label">道具名称</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="道具名称" name="toolName" id="atoolName">
			</div>
		  </div>
		  
	
		  
		  <div class="form-group">
			<label class="col-sm-2 control-label">道具库存</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="道具库存" name="toolNum" id="atoolNum">
			</div>
		  </div>
		  
		  <div class="form-group">
			<label class="col-sm-2 control-label">道具价格</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="道具价格" name="toolPrice" id="atoolPrice">
			</div>
		  </div>
		  
		  <div class="form-group">
			<label class="col-sm-2 control-label">道具图片</label>
			<div class="col-sm-10">
			  	<input type="file" id="up" name="file"/>
				<div><img id="pic" width="120" height="120" class="atoolPic"/></div>
			</div>
		  </div>
		  
		  
		  <div class="form-group">
			<label class="col-sm-2 control-label">道具描述</label>
			<div class="col-sm-10">
			  <div id="simple-editor"></div>
			  <input type="hidden" name="toolDes" id="atoolDes"/>
			</div>
		  </div>

      
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="submit" class="btn btn-primary" onclick="return valueToInput();">确认修改</button>
      </div>
      
      </form>
       <!--修改道具表单结束-->
      	
      </div>
      </div>
      </div>
    </div>	
 <!--修改道具模态框结束--> 





</body>
  
  
 <script type="text/javascript">
var toolState= ${toolState};
var pageSize = 6;

function loadTool(){

	$('.date_picker').date_input();
	$("#up").uploadPreview({ Img: "pic", Width: 120, Height: 120 });
	$("#addUp").uploadPreview({ Img: "addPic", Width: 120, Height: 120 });
	
	var action ="doGetAllTool.do";
	switch(toolState){
		case 1:
			$("#toolNameShow").html("在售道具");
			break;
		case 2:
			$("#toolNameShow").html("过期道具");
			$(".overDueHide").hide();
			$("#addToolShow").hide();
			$("#actPubTimeTD").hide();
			break;
	}
	$.ajax({
		type:"post",
		url:"<%=basePath%>tool/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&toolState="+toolState, 
		dataType:"json",
		success:function(data){
			$("#tbody").html("");
			 var str = "";  
			 $(data.data).each(function(i,tool){ 
				 str += "<tr class='success'>" +  
                 "<td class='toolNameTd'>";
                 var toolName = tool.toolName;
                 if(toolName.length > 18){
                	 toolName = toolName.substring(0,18) + "...";
                 }
                 str += toolName + "</td>" + 
                 "<td>" + tool.toolNum + "</td>" +  
                 "<td>" + tool.toolPrice + "</td>";
                 switch(Number(tool.toolState)){
					case 1:
						 str += "<td>" + moment(tool.toolPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertTool(\""+tool.toolNo+"\");modelClick();' role='button'>修改</a>"+
		                     "<a class='btn btn-info' href='javascript:overdueTool(\""+tool.toolNo+"\")' role='button'>删除</a>";
		                     break;
		            case 2:
		            	 str += "<td>" +
		                	 "<a class='btn btn-default' href='javascript:recoverTool(\""+tool.toolNo+"\")' role='button'>恢复</a>"+
		                     "<a class='btn btn-info' href='javascript:deleteTool(\""+tool.toolNo+"\")' role='button'>彻底删除</a>";
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
			            	url:"<%=basePath%>tool/"+action,
			          		data:"pageNow="+page+"&pageSize="+pageSize+"&toolState="+toolState, 
			          		dataType:"json",
			                success: function (msg) {
			                	var str1 = ""; 
			                	 $(msg.data).each(function(i,tool1){ 
			                		 str1 += "<tr class='success'>" +  
			                         "<td class='toolNameTd'>";
			                         var toolName1 = tool1.toolName;
			                         if(toolName1.length > 18){
			                        	 toolName1 = toolName1.substring(0,18) + "...";
			                         }
			                         str1 += toolName1 + "</td>" + 
			                         "<td>" + tool1.toolNum + "</td>" +  
			                         "<td>" + tool1.toolPrice + "</td>";
			                         switch(Number(tool1.toolState)){
			        					case 1:
			        						 str1 += "<td>" + moment(tool1.toolPubTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
			        		                     "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertTool(\""+tool1.toolNo+"\")' role='button'>修改</a>"+
			        		                     "<a class='btn btn-info' href='javascript:overdueTool(\""+tool1.toolNo+"\")' role='button'>删除</a>";
			        		                     break;
			        		            case 2:
			        		            	 str1 += "<td>" +
			        		                	 "<a class='btn btn-default' href='javascript:recoverTool(\""+tool1.toolNo+"\")' role='button'>恢复</a>"+
			        		                     "<a class='btn btn-info' href='javascript:deleteTool(\""+tool1.toolNo+"\")' role='button'>彻底删除</a>";
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
	$("#addToolDes").val($("#add-editor").html());
	if($("#addUp").val()==null||$("#addUp").val()==""){
		alert("请上传道具图片！");
		return false;
	}else{
		return true;
	}
	
}


function valueToInput(){
	$("#atoolDes").val($("#simple-editor").html());
	if($("#up").val()==null||$("#up").val()==""){
		$("#ktoolPic").val("fail");
	}else{
		$("#ktoolPic").val("success");
	}
	return true;
}

function modelClick(){
	document.body.style.overflow ='hidden';
}

</script>
  
  
  
</html>
