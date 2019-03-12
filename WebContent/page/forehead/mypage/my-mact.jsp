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
    <title>活动预约记录列表</title>

</head>
<body>   
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">前台</li>
	  <li class="active">个人中心</li>
	  <li id="mactNameShow" class="active">已成功预约活动记录</li>
	</ol>
	
	<div class="searchBar" style="height:100px;">
		<div class="searchTop">搜索栏</div>
		<div class="cutLine"></div>
		<div class="form-inline">
		  <div class="form-group">
		  <span class="itemLeftFirst">搜索条件:</span>
			<input type="text" class="searchItem" id="searchActTitle" placeholder="活动标题">
		  </div>
		</div>

		<div class="form-inline searchBarTwo">
		  <div class="form-group">
		  <span class="itemLeftFirst mactResTimeSeachShow">预约时间:</span>
			<input type="text" class="searchItem date_picker mactResTimeSeachShow" id="searchStartTime" placeholder="起始时间">
			<input type="text" class="itemLeft searchItem date_picker mactResTimeSeachShow" id="searchEndTime" placeholder="结束时间">
		  <button type="button" id="submitSearch" class="submitSearch btn" onclick="submitSearchIndex();" style="float:right;margin-right:75px;" >搜索</button>
			</div>
		</div>
	</div>

	<div class="widget-box">
	
		<table cellspacing="0">
    		<tr>
    			<th>活动标题</th>
    			<th id="mactResTimeShow">预约时间</th>
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
 var actResState= ${actResState};
$(document).ready(function(){
	$('.date_picker').date_input();
	
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
	$("#submitSearch").click();
});
 
function submitSearchIndex(){
	var pageSize = 10;
	
	var searchUserName = $("#searchUserName").val();
	var searchActTitle = $("#searchActTitle").val();
	var searchStartTime = $("#searchStartTime").val();
	var searchEndTime = $("#searchEndTime").val();
	if(searchActTitle != null && searchActTitle !=""){
		if(forMatTitle.test(searchActTitle) != true){
			alert("标题格式不正确！");
			$("#searchActTitle").focus();
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
	
	var action ="getMactCondition.do";
	$.ajax({
		type:"post",
		url:"<%=basePath%>mact/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&actResState="+actResState+
		"&userName="+searchUserName+
		"&actTitle="+searchActTitle+
		"&searchStartTime="+searchStartTime+
		"&searchEndTime="+searchEndTime,
		dataType:"json",
		success:function(data){
			$("#tbody").html("");
			 var str = ""; 
			 $(data.data).each(function(i,mact){ 
				 str += "<tr><td>";
                 var actTitle = mact.actTitle;
                 if(actTitle.length > 36){
                	 actTitle = actTitle.substring(0,36) + "...";
                 }
                 str += actTitle + "</td>";  
                 switch(Number(mact.actResState)){
					case 1:
						 str += 
							 "<td>" +
		                     "<a class='btn btn-info' href='javascript:deleteMact(\""+mact.mactNo+"\")' role='button'>取消</a>";
		                     break;
					case 2:
						 str +=
							 "<td>" + moment(mact.actResTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
		                     "<a class='btn btn-info' href='javascript:deleteMact(\""+mact.mactNo+"\")' role='button'>删除</a>";
		                     break;
		            case 3:
		            	 str +=
		            		 "<td>" +
		                	 "<a class='btn btn-info' href='javascript:deleteMact(\""+mact.mactNo+"\")' role='button'>删除</a>";
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
			            	data:"pageNow="+page+"&pageSize="+pageSize+"&actResState="+actResState+
			        		"&userName="+searchUserName+
			        		"&actTitle="+searchActTitle+
			        		"&searchStartTime="+searchStartTime+
			        		"&searchEndTime="+searchEndTime,
			          		dataType:"json",
			                success: function (msg) {
			                	var str1 = ""; 
			                	  $(msg.data).each(function(i,mact1){ 
			                		  str1 += "<tr><td>";
			                          var actTitle1 = mact1.actTitle;
			                          if(actTitle1.length > 36){
			                         	 actTitle1 = actTitle1.substring(0,36) + "...";
			                          }
			                          str1 += actTitle1 + "</td>";  
			                          switch(Number(mact1.actResState)){
			         					case 1:
			         						 str1 += 
			         							 "<td>" +
			         		                     "<a class='btn btn-info' href='javascript:deleteMact(\""+mact1.mactNo+"\")' role='button'>取消</a>";
			         		                     break;
			         					case 2:
			         						 str1 +=
			         							 "<td>" + moment(mact1.actResTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" + "<td>" +
			         		                     "<a class='btn btn-info' href='javascript:deleteMact(\""+mact1.mactNo+"\")' role='button'>删除</a>";
			         		                     break;
			         		            case 3:
			         		            	 str1 +=
			         		            		 "<td>" +
			         		                	 "<a class='btn btn-info' href='javascript:deleteMact(\""+mact1.mactNo+"\")' role='button'>删除</a>";
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


function deleteMact(mactNo){
	art.dialog(
	        {
	            content:'删除不可恢复',
	            style:'succeed noClose'
	        },
	        function(){
	        	$.ajax({
	        		type:"post",
	        		url:"<%=basePath%>mact/deleteMact.do",
	        		data:"mactNo="+mactNo, 
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
