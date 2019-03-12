
$(function() {
	count();
});


function count() {
	var basePath = getbasePath();
	$.ajax({
		type : "post",
		url : basePath + "bac/count.do",
		data : null,
		success : function(data) {
			$("#actCount").html(data.actCount); 
			$("#mactCount").html(data.mactCount);
			$("#orderCheckCount").html(data.orderCheckCount);
			$("#orderSendCount").html(data.orderSendCount);
			$("#postCount").html(data.postCount);
			$("#picCount").html(data.picCount);
		}
	});
}

function perCenter(userNo) {
	var basePath = getbasePath();
	$.ajax({
		type : "post",
		url : basePath + "user/findUserByUserNo.do",
		data : "userNo="+userNo,
		success : function(data) {
			$("#userNameShow").html(data.userName); 
			$("#userRealNameShow").html(data.userRealName);
			switch(Number(data.userState)){
			case 4:
				$("#userStateShow").html("管理员");
				break;
			case 5:
				$("#userStateShow").html("系统管理员");
				break;
			}
			$("#userAgeShow").html(data.userAge);
			$("#userSexShow").html(data.userSex);
			$("#userEmailShow").html(data.userEmail);
			$("#userAddressShow").html(data.userAddress);
			$("#userPicShow").attr('src', '/upload/user/'+data.userPic);
		}
	});
}

function sysCount() {
/*	var basePath = getbasePath();
	$.ajax({
		type : "post",
		url : basePath + "bac/count.do",
		data : null,
		success : function(data) {
			$("#actCount").html(data.actCount); 
			$("#mactCount").html(data.mactCount);
			$("#orderCheckCount").html(data.orderCheckCount);
			$("#orderSendCount").html(data.orderSendCount);
			$("#postCount").html(data.postCount);
			$("#picCount").html(data.picCount);
		}
	});*/
}



function getbasePath(){
    //获取当前网址，如： http://localhost:8080/ems/Pages/Basic/Person.jsp
    var curWwwPath = window.document.location.href;
    //获取主机地址之后的目录，如： /ems/Pages/Basic/Person.jsp
    var pathName = window.document.location.pathname;
    var pos = curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8080
    var localhostPath = curWwwPath.substring(0, pos);
    //获取带"/"的项目名，如：/ems
    var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
    //获取项目的basePath   http://localhost:8080/ems/
    var basePath=localhostPath+projectName+"/";
    return basePath;
};