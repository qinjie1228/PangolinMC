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
    <title>用户列表</title>
	<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/bootstrap-theme.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/date-picker.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/common.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/bootstrap-paginator.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/back/userlist-back.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.date_input.pack.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/browser.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/moment.min.js"></script>

</head>
<body onload="loadUser();">   
  
<div class="container">
	<ol class="breadcrumb">
	  <li class="active">后台</li>
	  <li class="active">会员管理</li>
	  <li id="uName" class="active">初级会员</li>
	</ol>
	<div class="searchBar">
		<div class="searchTop">搜索栏</div>
		<div class="cutLine"></div>
		<div class="form-inline">
		  <div class="form-group">
		  <span class="itemLeftFirst">搜索条件:</span>
			<input type="text" class="searchItem" id="searchUserName" placeholder="用户名">
			<input type="text" class="itemLeft searchItem" id="searchUserRealName" placeholder="真实姓名">
			<input type="text" class="itemLeft searchItem" id="searchUserAge" placeholder="年龄">
			<input type="text" class="itemLeft searchItem" id="searchUserSex" placeholder="男/女">
			<input type="text" class="itemLeft searchItem" id="searchUserEmail" placeholder="邮箱">
		  </div>
		</div>


		<div class="form-inline searchBarTwo">
		  <div class="form-group">
		  <span class="itemLeftFirst">注册时间:</span>
			<input type="text" class="searchItem date_picker" id="searchStartTime" placeholder="起始时间">
			<input type="text" class="itemLeft searchItem date_picker" id="searchEndTime" placeholder="结束时间">
		  <button type="button" class="submitSearch btn" onclick="submitSearch();" style="margin-left:449px;">搜索</button>
			</div>
		</div>
	</div>

	<button id="addUserShow" class="btn btn-info btn-md active" type="button" data-toggle="modal" data-target="#toAddUser">添加用户</button>
	<button id="addAdminShow" class="btn btn-info btn-md active" type="button" data-toggle="modal" data-target="#toAddAdmin">添加管理员</button>
	
	<div class="widget-box">
		<table class="table table-hover table-bordered table-striped table-responsive">
			<thead>
				<tr>
					<td>用户名</td>
					<td>真实姓名</td>
					<td>年龄</td>
					<td>性别</td>
					<td>邮箱</td>
					<td>注册时间</td>
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





<!-- 添加用户模态框开始 -->
<div class="modal fade" id="toAddUser" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">添加用户</h4>
      </div>
      <div class="modal-body">
        <!--添加用户表单-->
		<form class="form-horizontal" action="<%=basePath%>user/addUser.do" method="post">
		
		  <div class="form-group">
			<label class="col-sm-2 control-label">用户名</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="用户名" name="userName">
			</div>
		  </div>
		  
		   <div class="form-group">
			<label class="col-sm-2 control-label">用户真实姓名</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="用户真实姓名" name="userRealName">
			</div>
		  </div>
		  
		  <div class="form-group">
			<label class="col-sm-2 control-label">地址</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="地址" name="userAddress">
			</div>
		  </div>
		  
		   <div class="form-group">
			<label class="col-sm-2 control-label">邮件</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="邮件" name="userEmail">
			</div>
		  </div>
		  
		   <div class="form-group">
			<label class="col-sm-2 control-label">年龄</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="年龄" name="userAge">
			</div>
		  </div>
		  
		  <div class="form-group">
			<label class="col-sm-2 control-label">性别</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="性别" name="userSex">
			</div>
		  </div>
		  
		 
		 
		
		
      
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="submit" class="btn btn-primary">确认添加</button>
      </div>
      
      </form>
       <!--添加用户表单结束-->
      	
      </div>
      </div>
      </div>
    </div>	
 <!--添加用户模态框结束-->
      
         
         
         
         
<!-- 修改用户模态框开始 -->
<div class="modal fade" id="modify" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">修改用户</h4>
      </div>
      <div class="modal-body">
        <!--修改用户表单-->
		<form class="form-horizontal" action="<%=basePath%>user/doAlterUser.do" method="post">
		
		<input type="hidden" name="userNo" id="auserNo"/>
		<input type="hidden" name="userPwd" id="auserPwd"/>
		<input type="hidden" name="userPic" id="auserPic"/>
		<input type="hidden" name="userState" id="auserState"/>
		
		  <div class="form-group">
			<label class="col-sm-2 control-label">用户名</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control" placeholder="用户名" name="userName" id="auserName">
			</div>
		  </div>
		  
		   <div class="form-group">
			<label class="col-sm-2 control-label">用户真实姓名</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="用户真实姓名" name="userRealName" id="auserRealName">
			</div>
		  </div>
		  
		  <div class="form-group">
			<label class="col-sm-2 control-label">地址</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="地址" name="userAddress" id="auserAddress">
			</div>
		  </div>
		  
		   <div class="form-group">
			<label class="col-sm-2 control-label">邮件</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="邮件" name="userEmail" id="auserEmail">
			</div>
		  </div>
		  
		   <div class="form-group">
			<label class="col-sm-2 control-label">年龄</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="年龄" name="userAge" id="auserAge">
			</div>
		  </div>
		  
		  <div class="form-group">
			<label class="col-sm-2 control-label">性别</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="性别" name="userSex" id="auserSex">
			</div>
		  </div>
		  
		 
		 
		
		
      
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="submit" class="btn btn-primary">确认修改</button>
      </div>
      
      </form>
       <!--修改用户表单结束-->
      	
      </div>
      </div>
      </div>
    </div>	
 <!--修改用户模态框结束-->         




<!-- 添加管理员模态框开始 -->
<div class="modal fade" id="toAddAdmin" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">添加管理员</h4>
      </div>
      <div class="modal-body">
        <!--添加用户表单-->
		<form class="form-horizontal" action="<%=basePath%>user/addAdmin.do" method="post">
		
		  <div class="form-group">
			<label class="col-sm-2 control-label">用户名</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="用户名" name="userName">
			</div>
		  </div>
		  
		  <div class="form-group">
			<label class="col-sm-2 control-label">密码</label>
			<div class="col-sm-10">
			  <input type="password" class="form-control"  placeholder="密码" name="userPwd">
			</div>
		  </div>
		  
		  <div class="form-group">
			<label class="col-sm-2 control-label">密码确认</label>
			<div class="col-sm-10">
			  <input type="password" class="form-control"  placeholder="密码确认">
			</div>
		  </div>
		  
		   <div class="form-group">
			<label class="col-sm-2 control-label">邮件</label>
			<div class="col-sm-10">
			  <input type="text" class="form-control"  placeholder="邮件" name="userEmail">
			</div>
		  </div>	 		 				
      
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="submit" class="btn btn-primary">确认添加</button>
      </div>
      
      </form>
       <!--添加管理员表单结束-->
      	
      </div>
      </div>
      </div>
    </div>	
 <!--添加管理员框结束-->




</body>
  
  
 <script type="text/javascript">
 //全局变量，用户状态
var userState= ${userState};
var pageSize = 6;


function loadUser(){
	$('.date_picker').date_input();
	$("#addAdminShow").hide();
	
	var action ="doGetAllUser.do";
	switch(userState){
		case 1:
			$("#uName").html("初级会员");
			break;
		case 2:
			$("#uName").html("中级会员");
			$("#addUserShow").hide();
			break;
		case 3:
			$("#uName").html("高级会员");
			$("#addUserShow").hide();
			break;
		case 4:
			$("#uName").html("管理员");
			$("#addUserShow").hide();
			$("#addAdminShow").show();
			break;
		case 6:
			$("#uName").html("过期会员");
			$("#addUserShow").hide();
			break;
	}
	$.ajax({
		type:"post",
		url:"<%=basePath%>user/"+action,
		data:"pageNow="+1+"&pageSize="+pageSize+"&userState="+userState, 
		dataType:"json",
		success:function(data){
			$("#tbody").html("");
			 var str = "";  
			 $(data.data).each(function(i,user){ 
				 str += "<tr class='success'>" +  
                 "<td>" + user.userName + "</td>" +  
                 "<td>" + user.userRealName + "</td>" +  
                 "<td>" + user.userAge + "</td>" +  
                 "<td>" + user.userSex + "</td>" +  
                 "<td>" + user.userEmail + "</td>" +  
                 "<td>" + moment(user.userRegTime).format('YYYY-MM-DD HH:mm:ss')  + "</td>" +  
                 "<td>";
                 switch(Number(user.userState)){
					case 1:
						 str += 
							 "<a class='btn btn-default' href='javascript:promoteUser(\""+user.userNo+"\")' role='button'>升级</a>"+
							 "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertUser(\""+user.userNo+"\")' role='button'>修改</a>"+
							 "<a class='btn btn-info' href='javascript:overdueUser(\""+user.userNo+"\")' role='button'>删除</a>";
		                     break;
					case 2:
						 str +=
							 "<a class='btn btn-default' href='javascript:promoteUser(\""+user.userNo+"\")' role='button'>升级</a>"+
							 "<a class='btn btn-default' href='javascript:degradeUser(\""+user.userNo+"\")' role='button'>降级</a>"+
							 "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertUser(\""+user.userNo+"\")' role='button'>修改</a>"+
							 "<a class='btn btn-info' href='javascript:overdueUser(\""+user.userNo+"\")' role='button'>删除</a>";
		                     break;
		            case 3:
		            	 str +=
							 "<a class='btn btn-default' href='javascript:degradeUser(\""+user.userNo+"\")' role='button'>降级</a>"+
							 "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertUser(\""+user.userNo+"\")' role='button'>修改</a>"+
							 "<a class='btn btn-info' href='javascript:overdueUser(\""+user.userNo+"\")' role='button'>删除</a>";
		                     break;
		            case 4:
		            	 str +=
		            		"<a class='btn btn-info' href='javascript:deleteUser(\""+user.userNo+"\")' role='button'>删除</a>";
		                     break;
		            case 6:
		            	 str +=
		                    "<a class='btn btn-default' href='javascript:recoverUser(\""+user.userNo+"\")' role='button'>恢复</a>"+
		   				    "<a class='btn btn-info' href='javascript:deleteUser(\""+user.userNo+"\")' role='button'>彻底删除</a>"; 
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
			            },//点击事件，用于通过Ajax来刷新整个用户列表
			            onPageClicked: function (event, originalEvent, type, page) {
			              $.ajax({
			            	type:"post",
			            	url:"<%=basePath%>user/"+action,
			          		data:"pageNow="+page+"&pageSize="+pageSize+"&userState="+userState, 
			          		dataType:"json",
			                success: function (msg) {
			                	var str1 = ""; 
			                	  $(msg.data).each(function(i,user1){ 
			         				 str1 += "<tr class='success'>" +  
			                          "<td>" + user1.userName + "</td>" +  
			                          "<td>" + user1.userRealName + "</td>" +  
			                          "<td>" + user1.userAge + "</td>" +  
			                          "<td>" + user1.userSex + "</td>" +  
			                          "<td>" + user1.userEmail + "</td>" +  
			                          "<td>" + moment(user1.userRegTime).format('YYYY-MM-DD HH:mm:ss') + "</td>" +  
			                          "<td>";
			                          switch(Number(user1.userState)){
				      					case 1:
				      						 str1 += 
				      							 "<a class='btn btn-default' href='javascript:promoteUser(\""+user1.userNo+"\")' role='button'>升级</a>"+
				      							 "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertUser(\""+user1.userNo+"\")' role='button'>修改</a>"+
				      							 "<a class='btn btn-info' href='javascript:overdueUser(\""+user1.userNo+"\")' role='button'>删除</a>";
				      		                     break;
				      					case 2:
				      						 str1 +=
				      							 "<a class='btn btn-default' href='javascript:promoteUser(\""+user1.userNo+"\")' role='button'>升级</a>"+
				      							 "<a class='btn btn-default' href='javascript:degradeUser(\""+user1.userNo+"\")' role='button'>降级</a>"+
				      							 "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertUser(\""+user1.userNo+"\")' role='button'>修改</a>"+
				      							 "<a class='btn btn-info' href='javascript:overdueUser(\""+user1.userNo+"\")' role='button'>删除</a>";
				      		                     break;
				      		            case 3:
				      		            	 str1 +=
				      							 "<a class='btn btn-default' href='javascript:degradeUser(\""+user1.userNo+"\")' role='button'>降级</a>"+
				      							 "<a class='btn btn-default' data-toggle='modal' data-target='#modify' onclick='toAlertUser(\""+user1.userNo+"\")' role='button'>修改</a>"+
				      							 "<a class='btn btn-info' href='javascript:overdueUser(\""+user1.userNo+"\")' role='button'>删除</a>";
				      		                     break;
				      		            case 4:
				      		            	 str1 +=
				      		            		"<a class='btn btn-info' href='javascript:deleteUser(\""+user1.userNo+"\")' role='button'>删除</a>";
				      		                     break;
				      		            case 6:
				      		            	 str1 +=
				      		                    "<a class='btn btn-default' href='javascript:recoverUser(\""+user1.userNo+"\")' role='button'>恢复</a>"+
				      		   				    "<a class='btn btn-info' href='javascript:deleteUser(\""+user1.userNo+"\")' role='button'>彻底删除</a>"; 
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
