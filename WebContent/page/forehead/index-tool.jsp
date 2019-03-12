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
</head>
<style>
.tool{
	height:1070px;
}
</style>
<body>
<%@ include file="/page/common/user-include.jsp"%>
<div id ="main">
	<div id="index_all">
		<%@ include file="/page/common/head-include.jsp"%>
		<!--网站主体部分开始-->
		<div id="index_body">
			<!--道具开始-->
			<div class="tool">
				<!--头部开始-->
				<div>
					<img src="images/toolbuy.png" style="width: 20px;" /> <span>登山道具推荐</span>
				</div>
				<!--头部结束-->
				<!--道具展示-->
				<div id="toolBody">
				</div>
				<!--道具展示结束-->
				
				<div class="chosePrice">
					<p> 
						<label style="width:200px;">当页已选商品价格：<label id="total"></label></label>
						<span style="margin-left:330px;">购物车总价：<label id="totalAll"></label></span>   
						<input id="indexPay" style="margin-left:90px;" type="button" value="去结算" onclick='toPayOrderDo2();'> 
					</p>
				</div>
				
				<ul class="pagination" id="example"> 
		    		<li><a href="#">&laquo;</a></li> 
				    <li class="active"><a href="#">1</a></li> 
				    <li ><a href="#">2</a></li> 
				    <li><a href="#">3</a></li> 
				    <li><a href="#">4</a></li> 
				    <li><a href="#">5</a></li> 
				    <li><a href="#">&raquo;</a></li> 
			    </ul>
				
				
			</div><br> 
			<!--道具结束-->
		</div>
		<!--网站主体部分结束-->
	</div>


</div>
</body>

<script>

$(function(){
	loadtool();
});

function loadtool(){
	var pageSize = 9;
	var toolState = 1;
	var action ="doGetAllTool.do";
	var userNo = $("#userNo").val();
	var imgPathBefore = "/upload/tool/";
	$.ajax({
		type:"post",
		url:"<%=basePath%>tool/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&toolState="+toolState, 
		dataType:"json",
		success:function(data){
			$("#toolBody").html("");
			var str = "<br>";  
			$(data.data).each(function(i,tool){ 
				str += "<div class='toolone'><div class='toolone_pic'><a href='" + basePath + "tool/findToolIndexByToolNo.do?toolNo=" + tool.toolNo + "'><img src='" + imgPathBefore + tool.toolPic + "' style='width:100%; height:220px;'/></a></div>" +
						"<div class='toolone_desc' onClick='window.location.href=\"" + basePath + 'tool/findToolIndexByToolNo.do?toolNo=' + tool.toolNo + "\"'>";
				var toolName = tool.toolName;
				if(toolName.length > 31){
					toolName = toolName.substring(0,31) + "...";
				}
				str += "<p>" + toolName + "</p>" + "</div> <div class='toolone_do'><div style='float:left;' class='tool_price'><img src='"+basePath+"images/toolprice.png' style='width: 15px;' /><span class='price color-red price" + tool.toolNo + "'>" +
					tool.toolPrice + "</span></div> ";
				str += "<button id='"+tool.toolNo+"' style='float:right;width:85px;height:22px;font-size:11px;background: #f5f5f5;border:none;' onclick='addToolToOrder(\""+tool.toolNo+"\",\""+userNo+"\");' onMouseOver='checkOrder(\""+ tool.toolNo + "\");'>添加到购物车</button>";
				str += "<input style='margin-left:50px;' class='min' onclick='orderChange(\""+tool.toolNo+"\");' type='button' value='-'/>";
				str += "<input class='text_box color-red "+tool.toolNo+"' type='text' ";
				str += "value='" + getToolOrderNum(tool.toolNo,userNo) + "' onChange='orderChange(\""+tool.toolNo+"\");' style='width:24px;font-size:10px;'/>";
				str += "<input class='add' onclick='orderChange(\""+tool.toolNo+"\");' type='button' value='+'/></div></div>";
			});
			$("#toolBody").append(str);
			//订单处理部分
		    setTotal();
		    /* $("#totalAll").html($("#total").text()); */
		    $("#totalAll").html(getToltalPice(userNo)); 
			$(".add").click(function(){ 
		  		var t=$(this).parent().find('input[class*=text_box]'); 
		  		t.val(parseInt(t.val())+1); 
		  		setTotal(); 
			}); 
			$(".min").click(function(){ 
		  		var t=$(this).parent().find('input[class*=text_box]'); 
		  		t.val(parseInt(t.val())-1); 
		  		if(parseInt(t.val())<0){ 
		  		t.val(0); 
		  		} 
		  		setTotal(); 
			}); 
			
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
			        success:function(msg){
						var str1 = "<br>";  
						$(msg.data).each(function(i,tool1){ 
							str1 += "<div class='toolone'><div class='toolone_pic'><a href='" + basePath + "tool/findToolIndexByToolNo.do?toolNo=" + tool1.toolNo + "'><img src='" + imgPathBefore + tool1.toolPic + "' style='width:100%; height:220px;'/></a></div>" +
									"<div class='toolone_desc' onClick='window.location.href=\"" + basePath + 'tool/findToolIndexByToolNo.do?toolNo=' + tool1.toolNo + "\"'>";
							var toolName1 = tool1.toolName;
							if(toolName1.length > 31){
								toolName1 = toolName1.substring(0,31) + "...";
							}
							str1 += "<p>" + toolName1 + "</p>" + "</div> <div class='toolone_do'><div style='float:left;' class='tool_price'><img src='"+basePath+"images/toolprice.png' style='width: 15px;' /><span class='price color-red price" + tool1.toolNo + "'>" +
								tool1.toolPrice + "</span></div> ";
							str1 += "<button id='"+tool1.toolNo+"' style='float:right;width:85px;height:22px;font-size:11px;background: #f5f5f5;border:none;' onclick='addToolToOrder(\""+tool1.toolNo+"\",\""+userNo+"\");' onMouseOver='checkOrder(\""+ tool1.toolNo + "\");'>添加到购物车</button>";
							str1 += "<input style='margin-left:50px;' class='min' onclick='orderChange(\""+tool1.toolNo+"\");' type='button' value='-'/>";
							str1 += "<input class='text_box color-red "+tool1.toolNo+"' type='text' ";
							str1 += "value='" + getToolOrderNum(tool1.toolNo,userNo) + "' onChange='orderChange(\""+tool1.toolNo+"\");' style='width:24px;font-size:10px;'/>";
							str1 += "<input class='add' onclick='orderChange(\""+tool1.toolNo+"\");' type='button' value='+'/></div></div>";
						});
					$("#toolBody").html("");
					$("#toolBody").append(str1);
					
					//订单处理部分
				    setTotal();
/* 				    $("#totalAll").html($("#total").text()); */
					$("#totalAll").html(getToltalPice(userNo)); 
					$(".add").click(function(){ 
				  		var t=$(this).parent().find('input[class*=text_box]'); 
				  		t.val(parseInt(t.val())+1); 
				  		setTotal(); 
					}); 
					$(".min").click(function(){ 
				  		var t=$(this).parent().find('input[class*=text_box]'); 
				  		t.val(parseInt(t.val())-1); 
				  		if(parseInt(t.val())<0){ 
				  		t.val(0); 
				  		} 
				  		setTotal(); 
					}); 
			     }
			    
			 });
			}
			};
			$('#example').bootstrapPaginator(options);
		}
			      
	});
}

function setTotal(){ 
	var s=0; 
	$("#toolBody .toolone_do").each(function(){ 
		s+=parseInt($(this).find('input[class*=text_box]').val())*parseFloat($(this).find('span[class*=price]').text()); 
	}); 
	$("#total").html(s.toFixed(2)); 
} 


window.onload=function(){ 
	//自适当前应屏幕分辨率
	var windowHeight = window.screen.height;
	var windowWidth = window.screen.width;
	var main = document.getElementById("main"); 
	main.style.height = windowHeight*0.9 + "px";
	main.style.width = windowWidth*0.9 + "px";
};

</script>

</html>
