<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ include file="/page/common/index-include.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>穿山甲登山俱乐部</title>
 	<link rel="stylesheet" href="<%=basePath%>css/lightbox.css" media="screen"/> 
	<script src="<%=basePath%>js/lightbox-2.6.min.js"></script>

</head>
<style>
.pic{
	min-height:820px;
}
</style>
<body>
<%@ include file="/page/common/user-include.jsp"%>
<div id ="main">
	<div id="index_all">
		<%@ include file="/page/common/head-include.jsp"%>
		<!--网站主体部分开始-->
		<div id="index_body">
			
			<!--图片开始-->
			<div class="pic">
				<!--头部开始-->
				<div >
					<img src="images/picture.png" style="width: 20px;" /> <span>精品图片</span>
				</div>
				<!--头部结束-->
				<br>
				<!--活动展示-->
				<div id="picBody">
				
					<div class="gallery">
					
 	  					<!-- <div><a href="img/gallery/DSC_0008-660x441.jpg"><img class="pic-one-pic" src="img/gallery/DSC_0008-69x69.jpg" /></a></div>
						<div><a href="img/gallery/DSC_0014-660x441.jpg"><img class="pic-one-pic" src="img/gallery/DSC_0014-69x69.jpg" /></a></div>
						<div><a href="img/gallery/DSC_0019-660x441.jpg"><img class="pic-one-pic" src="img/gallery/DSC_0019-69x69.jpg" /></a></div>
						<div><a href="img/gallery/DSC_0061-660x441.jpg"><img class="pic-one-pic" src="img/gallery/DSC_0061-69x69.jpg" /></a></div>  -->
		
					</div>
					<div class="clear"></div>
				
				</div>
				<!--图片展示结束-->
				
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
			<!--图片结束-->
		</div>
		<!--网站主体部分结束-->
	</div>


</div>
</body>
<script>
$(function(){
	loadPic();
});

function loadPic(){
	var pageSize = 16;
	var picState = 4;
	var imgPathBefore = "/upload/pic/";
	var action ="doGetAllPic.do";
	$.ajax({
		type : "post",
		url : basePath + "pic/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&picState="+picState, 
		success : function(data) {
			var str = "";
			$(data.data).each(function(i,picture){ 
				var picDes = picture.picDes;
				if(picDes.length > 15){
					picDes = picDes.substring(0,15) + "...";
				}
				str+="<a data-lightbox='example-2' title='"+picDes+"' href='" + imgPathBefore + picture.picPath + "'>" +
			 	"<img class='pic-one-pics' alt='"+picDes+"' src='" + imgPathBefore + picture.picPath +"'/></a></div>";
			    /* str += "<div><a href='" + imgPathBefore + picture.picPath + "'><img class='pic-one-pic' src='" + imgPathBefore + picture.picPath + "'/></a></div>"; */
			});
			$(".gallery").html("");
      	    $(".gallery").append(str); 
/*        		$.getScript(basePath+"js/zoom.min.js"); */
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
		            	url : basePath + "pic/"+action,
		        		data:"pageNow="+page+"&pageSize="+pageSize+"&picState="+picState, 
		          		dataType:"json",
		                success: function (msg) {
		                	var str1 = ""; 
		                	  $(msg.data).each(function(i,picture1){ 
		                		var picDes1 = picture1.picDes;
		          				if(picDes1.length > 15){
		          					picDes1 = picDes1.substring(0,15) + "...";
		          				}
		          			    str1 += "<div>"+
		          			  	"<a data-lightbox='example-2' title='"+picDes1+"' href='" + imgPathBefore + picture1.picPath + "'>" +
		  				 		"<img class='pic-one-pics' alt='"+picDes1+"' src='" + imgPathBefore + picture1.picPath +"'/></a>" +
		          			    /* <a href='" + imgPathBefore + picture1.picPath + "'><img class='pic-one-pic' src='" + imgPathBefore + picture1.picPath + "'/></a> */
		          			    "</div>";
		                    });
		                	$(".gallery").html("");
		                	$(".gallery").append(str1);
/* 		                	$.getScript(basePath+"js/zoom.min.js"); */
		                  }
		    
		              });
		            }
		          };
		          $('#example').bootstrapPaginator(options);
		        }
		      
		    });
}

window.onload=function(){
	
}
</script>

</html>
