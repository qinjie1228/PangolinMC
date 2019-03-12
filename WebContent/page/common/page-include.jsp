<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String pathInclude = request.getContextPath();
	String basePathInclude = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ pathInclude + "/";
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma","no-cache"); 
%>
<link href="<%=basePathInclude%>css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePathInclude%>css/bootstrap-theme.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePathInclude%>css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePathInclude%>css/date-picker.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="<%=basePathInclude%>trumbowyg/design/css/trumbowyg.css">
	<link href="<%=basePathInclude%>css/common.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePathInclude%>css/jquery-confirm.css" rel="stylesheet" type="text/css" />
<%-- 	<link href="<%=basePathInclude%>artDialog/default.css" rel="stylesheet" type="text/css" /> --%>
	<link href="<%=basePathInclude%>artDialog/css/simple.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=basePathInclude%>js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="<%=basePathInclude%>js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=basePathInclude%>js/bootstrap-paginator.js"></script>
	<script type="text/javascript" src="<%=basePathInclude%>js/jquery.date_input.pack.js"></script>
	<script type="text/javascript" src="<%=basePathInclude%>js/browser.js"></script>
	<script type="text/javascript" src="<%=basePathInclude%>js/moment.min.js"></script>
	<script type="text/javascript" src="<%=basePathInclude%>js/picUpload.js"></script>
	
	<script src="<%=basePathInclude%>trumbowyg/trumbowyg.js"></script>
    <script src="<%=basePathInclude%>trumbowyg/langs/fr.js"></script>
	<script src="<%=basePathInclude%>trumbowyg/plugins/upload/trumbowyg.upload.js"></script>
	<script src="<%=basePathInclude%>trumbowyg/plugins/base64/trumbowyg.base64.js"></script>
	<script src="<%=basePathInclude%>js/jquery-confirm.js"></script>
	<script src="<%=basePathInclude%>artDialog/artDialog.source.js"></script>
	<script src="<%=basePathInclude%>artDialog/iframeTools.source.js"></script>
	<script src="<%=basePathInclude%>js/back/background-common.js"></script>
	
	
<script type="text/javascript">
 $(function() {
        $("table tr:nth-child(odd)").addClass("odd-row");
		$("table td:first-child, table th:first-child").addClass("first");
		$("table td:last-child, table th:last-child").addClass("last");
});
var forMatTitle = /^[\w\u4e00-\u9fa5~!@#$%^&*()+-_={}|\/:;/'/"”‘？’“、：,，。.?<>{}]{2,1000}$/;
var forMatDes = forMatTitle;
var forMatTime = /^[0-9]{4}-(0?[0-9]|1[0-2])-(0?[1-9]|[12]?[0-9]|3[01])$/;
</script>

<style type="text/css">
	
	a {color:#666;}
	
	#content {width:100%; max-width:90%; margin:6% auto 0;}

	table {
		font:12px/15px "Helvetica Neue",Arial, Helvetica, sans-serif;
		overflow:hidden;
		border:1px solid #d3d3d3;
		background:#fefefe;
		width:100%;
		margin:1% auto 0;
		-moz-border-radius:5px; /* FF1+ */
		-webkit-border-radius:5px; /* Saf3-4 */
		border-radius:5px;
		-moz-box-shadow: 0 0 4px rgba(0, 0, 0, 0.2);
		-webkit-box-shadow: 0 0 4px rgba(0, 0, 0, 0.2);
	}
	
	th, td {padding:5px 7px 5px; text-align:center; }
	
	th {padding-top:22px; text-shadow: 1px 1px 1px #fff; background:#e8eaeb;}
	
	td {border-top:1px solid #e0e0e0; border-right:1px solid #e0e0e0;}
	
	tr.odd-row td {background:#f6f6f6;}
	
	td.last {border-right:none;}
	
	td {
		background: -moz-linear-gradient(100% 25% 90deg, #fefefe, #f9f9f9);
		background: -webkit-gradient(linear, 0% 0%, 0% 25%, from(#f9f9f9), to(#fefefe));
	}
	
	tr.odd-row td {
		background: -moz-linear-gradient(100% 25% 90deg, #f6f6f6, #f1f1f1);
		background: -webkit-gradient(linear, 0% 0%, 0% 25%, from(#f1f1f1), to(#f6f6f6));
	}
	
	th {
		background: -moz-linear-gradient(100% 20% 90deg, #e8eaeb, #ededed);
		background: -webkit-gradient(linear, 0% 0%, 0% 20%, from(#ededed), to(#e8eaeb));
	}
	

</style>

<input type="hidden" id="searchUserName" value="${currentUser.currentName }">
<input type="hidden" id="userNo" value="${currentUser.currentNo }">
<input type="hidden" id="userName" value="${currentUser.currentName }">

<script>
var userNo = $("#userNo").val();
var userName = $("#userName").val();

</script>