$(function(){
	carouselShow();
	noticeShow();
	actShow();
	toolShow();
	postShow();
	picShow();

});

function carouselShow(){
	var selectNum = 3;
	var imgPathBefore = "/upload/act/";
	
	var srcArray = new Array();
	var altArray = new Array();
	$.ajax({
		type : "post",
		url : basePath + "act/actPicCarousel.do",
		data : "selectNum="+selectNum,
		success : function(data) {
			$(data).each(function(i,act){ 
				srcArray.push(act.actPic);
				
				var actTitle = act.actTitle;
				if(actTitle.length > 8){
					actTitle = actTitle.substring(0,8) + "...";
				}
				altArray.push(actTitle);
			});
			$("#carouselImgOne").attr("src", imgPathBefore + srcArray[0]);
			$("#carouselImgTwo").attr("src", imgPathBefore + srcArray[1]);
			$("#carouselImgThree").attr("src", imgPathBefore + srcArray[2]);
			
			$("#carouselImgOne").attr("alt", altArray[0]);
			$("#carouselImgTwo").attr("alt", altArray[1]);
			$("#carouselImgThree").attr("alt", altArray[2]);
		}
	});
}

function noticeShow(){
	var selectNum = 8;
	var userNo = $("#userNo").val();
	$.ajax({
		type : "post",
		url : basePath + "notice/noticeIndexShow.do",
		data : "selectNum="+selectNum,
		success : function(data) {
			var str = "";
			$(data).each(function(i,notice){
				var noticeTitle = notice.noticeTitle;
				if(noticeTitle.length > 21){
					noticeTitle = noticeTitle.substring(0,21) + "...";
				}
				str += "<a style='color: black;' href='" + basePath + "notice/findNoticeIndexByNoticeNo.do?noticeNo=" + notice.noticeNo + "'>" +
						noticeTitle + "</a> <span style='float: right;'>" + moment(notice.noticePubTime).format('YYYY-MM-DD HH:mm:ss') + "</span><br />";
			});
			$("#noticeUp_notices").html("");
      	    $("#noticeUp_notices").append(str); 
		}
	});
}

function actShow(){
	var selectNum = 6;
	var userNo = $("#userNo").val();
	var imgPathBefore = "/upload/act/";
	
	$.ajax({
		type : "post",
		url : basePath + "act/actIndexShow.do",
		data : "selectNum="+selectNum,
		success : function(data) {
			var str = "";
			$(data).each(function(i,act){ 
				str += "<div class='actone'><div class='actone_pic'><a href='" + basePath + "act/findActIndexByActNo.do?actNo=" + act.actNo + "'><img src='" + imgPathBefore + act.actPic + "' style='width:100%; height:180px;'/></a></div>" +
					   "<div style='float:left;' class='actone_title' onClick='window.location.href=\"" + basePath + 'act/findActIndexByActNo.do?actNo=' + act.actNo + "\"'>";
				var actTitle = act.actTitle;
				if(actTitle.length > 10){
					actTitle = actTitle.substring(0,10) + "...";
				}
				str += actTitle + "(<span class='color-red "+act.actNo+"'>" + act.actNum + "</span>)</div> <div style='float:right;' class='actone_do'> ";
				if(userNo == null || userNo == ""){
					str += "<input type='button' value='预约' disabled='true'></div></div>";
				}
				
				else if(userNo != null && userNo != ""){
					str += "<input id='"+act.actNo+"' type='button' value='预约' onclick='resAct(\""+act.actNo+"\""+",\""+userNo+"\");' onMouseOver='checkMact(\""+act.actNo+"\""+",\""+userNo+"\");'></div></div>";
				}
			});
			$("#act_content").html("");
      	    $("#act_content").append(str); 
		}
	});
}



function toolShow(){
	var selectNum = 6;
	var userNo = $("#userNo").val();
	var imgPathBefore = "/upload/tool/";
	
	$.ajax({
		type : "post",
		url : basePath + "tool/toolIndexShow.do",
		data : "selectNum="+selectNum,
		success : function(data) {
			var str = "";
			$(data).each(function(i,tool){ 
				str += "<div class='toolone'><div class='toolone_pic'><a href='" + basePath + "tool/findToolIndexByToolNo.do?toolNo=" + tool.toolNo + "'><img src='" + imgPathBefore + tool.toolPic + "' style='width:100%; height:220px;'/></a></div>" +
					"<div class='toolone_desc' onClick='window.location.href=\"" + basePath + 'tool/findToolIndexByToolNo.do?toolNo=' + tool.toolNo + "\"'>";
				var toolName = tool.toolName;
				if(toolName.length > 31){
					toolName = toolName.substring(0,31) + "...";
				}
				str += "<p>" + toolName + "</p>" + "</div> <div class='toolone_do'><div style='float:left;' class='tool_price'><img src='"+basePath+"images/toolprice.png' style='width: 15px;' /><span class='price color-red price" + tool.toolNo + "'>" +
					tool.toolPrice + "</span></div> ";
				if(userNo == null || userNo == ""){
					str += "<input type='button' style='float:right;width:85px;height:22px;font-size:11px;background: #f5f5f5;border:none;' value='添加到购物车' disabled='true'>";
				}
				else if(userNo != null && userNo != ""){
					str += "<button id='"+tool.toolNo+"' style='float:right;width:85px;height:22px;font-size:11px;background: #f5f5f5;border:none;' onclick='addToolToOrder(\""+tool.toolNo+"\",\""+userNo+"\");' onMouseOver='checkOrder(\""+ tool.toolNo + "\");'>添加到购物车</button>";
				}
				str += "<input style='margin-left:50px;' class='min' onclick='orderChange(\""+tool.toolNo+"\");' type='button' value='-'/>";
				str += "<input class='text_box color-red "+tool.toolNo+"' type='text' ";
				str += "value='" + getToolOrderNum(tool.toolNo,userNo) + "' onChange='orderChange(\""+tool.toolNo+"\");' style='width:24px;font-size:10px;'/>";
				str += "<input class='add' onclick='orderChange(\""+tool.toolNo+"\");' type='button' value='+'/></div></div>";
			});
			$("#tool_content").html("");
      	    $("#tool_content").append(str); 
      	    
      		//订单处理部分
      	    setTotal();
      	    /*$("#totalAll").html($("#total").text());*/
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


function postShow(){
	var selectNum = 14;
	$.ajax({
		type : "post",
		url : basePath + "post/postNewIndexShow.do",
		data : "selectNum="+selectNum,
		success : function(data) {
			var str = "";
			$(data).each(function(i,post){ 
				var postTitle = post.postTitle;
				if(postTitle.length > 29){
					postTitle = postTitle.substring(0,29) + "...";
				}
				str += "<div class='post-one'><a style='color: black;' href='" + basePath + "post/findPostIndexByPostNo.do?postNo=" + post.postNo + "'>" + postTitle + "</a>" +
					"<span style='float: right;'>时间：&nbsp;" + moment(post.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "&nbsp;&nbsp;&nbsp;点击：&nbsp;<span class='color-red' style='display:-moz-inline-box;display:inline-block;width:14px; '>" + post.postScanNum +"</span>&nbsp;&nbsp;&nbsp;" +
					"回复：&nbsp;&nbsp;<span class='color-red' style='display:-moz-inline-box;display:inline-block;width:14px; '>" + post.postCommentNum + "</span></span></div>";
			});
			$("#postNew").html("");
      	    $("#postNew").append(str); 
		}
	});
}

function postWellShow(){
	var selectNum = 14;
	$.ajax({
		type : "post",
		url : basePath + "post/postWellIndexShow.do",
		data : "selectNum="+selectNum,
		success : function(data) {
			var str = "";
			$(data).each(function(i,post){ 
				var postTitle = post.postTitle;
				if(postTitle.length > 29){
					postTitle = postTitle.substring(0,29) + "...";
				}
				str += "<div class='post-one'><a style='color: black;' href='" + basePath + "post/findPostIndexByPostNo.do?postNo=" + post.postNo + "'>" + postTitle + "</a>" +
					"<span style='float: right;'>时间：&nbsp;" + moment(post.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "&nbsp;&nbsp;&nbsp;点击：&nbsp;<span class='color-red' style='display:-moz-inline-box;display:inline-block;width:14px; '>" + post.postScanNum +"</span>&nbsp;&nbsp;&nbsp;" +
					"回复：&nbsp;&nbsp;<span class='color-red' style='display:-moz-inline-box;display:inline-block;width:14px; '>" + post.postCommentNum + "</span></span></div>";
			});
			$("#postWell").html("");
      	    $("#postWell").append(str); 
		}
	});
}

function postHotShow(){
	var selectNum = 14;
	$.ajax({
		type : "post",
		url : basePath + "post/postHotIndexShow.do",
		data : "selectNum="+selectNum,
		success : function(data) {
			var str = "";
			$(data).each(function(i,post){ 
				var postTitle = post.postTitle;
				if(postTitle.length > 29){
					postTitle = postTitle.substring(0,29) + "...";
				}
				str += "<div class='post-one'><a style='color: black;' href='" + basePath + "post/findPostIndexByPostNo.do?postNo=" + post.postNo + "'>" + postTitle + "</a>" +
					"<span style='float: right;'>时间：&nbsp;" + moment(post.postPubTime).format('YYYY-MM-DD HH:mm:ss') + "&nbsp;&nbsp;&nbsp;点击：&nbsp;<span class='color-red' style='display:-moz-inline-box;display:inline-block;width:14px; '>" + post.postScanNum +"</span>&nbsp;&nbsp;&nbsp;" +
					"回复：&nbsp;&nbsp;<span class='color-red' style='display:-moz-inline-box;display:inline-block;width:14px; '>" + post.postCommentNum + "</span></span></div>";
			});
			$("#postHot").html("");
      	    $("#postHot").append(str); 
		}
	});
}

function picShow(){
	var selectNum = 8;
	var imgPathBefore = "/upload/pic/";
	$.ajax({
		type : "post",
		url : basePath + "pic/picIndexShow.do",
		data : "selectNum="+selectNum,
		success : function(data) {
			var str = "";
			$(data).each(function(i,picture){ 
				var picDes = picture.picDes;
				if(picDes.length > 15){
					picDes = picDes.substring(0,15) + "...";
				}
			    str += "<div><a href='" + imgPathBefore + picture.picPath + "'><img class='pic-one-pic' src='" + imgPathBefore + picture.picPath + "'/></a></div>";
			});
			$(".gallery").html("");
      	    $(".gallery").append(str); 
      	  $.getScript(basePath+"js/zoom.min.js");
		}
	});
}

function setTotal(){ 
	var s=0; 
	$("#tool_content .toolone_do").each(function(){ 
		s+=parseInt($(this).find('input[class*=text_box]').val())*parseFloat($(this).find('span[class*=price]').text()); 
	}); 
	$("#total").html(s.toFixed(2)); 
} 
