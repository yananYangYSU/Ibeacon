<%@ page language="java" contentType="text/html"
	import="java.util.*,com.ictwsn.bean.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	//获取当前角色的权限信息
	RoleBean rb = null;
	if ((RoleBean) session.getAttribute("RoleBean") != null) {
		rb = (RoleBean) session.getAttribute("RoleBean");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="Bookmark" href="/favicon.ico" >
<link rel="Shortcut Icon" href="/favicon.ico" />

<link rel="stylesheet" href="css/pintuer.css">
<link rel="stylesheet" href="css/admin.css">

<link rel="stylesheet" type="text/css" href="static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="lib/Hui-iconfont/1.0.8/iconfont.css" />

<link rel="stylesheet" type="text/css" href="static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/style.css" />

<link href="lib/webuploader/0.1.5/webuploader.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="page-container">
	<form action="" method="post" class="form form-horizontal" id="form-article-add">
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>用户名称：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input w50" value="" maxlength='20' placeholder="请输入用户名称" id="clientName" name="clientName">
				<span id="name_notice" class="c-red"></span>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>用户密码：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input w50" value="" maxlength='20' placeholder="请输入用户密码" id="clientPassword" name="clientPassword">
				<span id="password_notice" class="c-red"></span>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>所属运营商：</label>
			<div class="formControls col-xs-8 col-sm-9"> 
				<select name="selectOperator" id="selectOperator" class="input w50" onChange="setType()">
					<option value="">请选择所属运营商</option>
					<c:forEach var="list" items="${operatorList}" varStatus="status">
					<option value="${list.id}">${list.name}</option>
					</c:forEach>
				</select>
				<span id="belong_notice" class="c-red"></span>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red"></span>联系电话：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input w50" value="" maxlength='11' placeholder="请输入用户电话" id="clientPhone" name="clientPhone">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red"></span>用户邮箱：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input w50" value="" maxlength='50' placeholder="请输入用户邮箱" id="clientEmail" name="clientEmail">
			</div>
		</div>
		<input type="hidden" value="3" id="roleId" name="roleId">
		<input type="hidden" value="" id="operatorId" name="operatorId">
		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
				<button onClick="addClient();" class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i>确认添加</button>
				<button class="btn btn-default radius" type="reset">&nbsp;&nbsp;重置&nbsp;&nbsp;</button>
			</div>
		</div>
	</form>
</div>

<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="static/h-ui/js/H-ui.min.js"></script> 
<script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script> 
<script type="text/javascript">
function setType() {
			var operatorIds = document.getElementById("selectOperator");
			for ( var i = 0; i < operatorIds.length; i++) {
				if (operatorIds[i].selected == true) {
					document.getElementById("operatorId").value = operatorIds[i].value;
					break;
				}
			}
		}
function addClient(){
			var operatorId = document.getElementById("operatorId").value;
			var clientName = document.getElementById("clientName").value;
			var clientPassword = document.getElementById("clientPassword").value;
			var clientPhone = document.getElementById("clientPhone").value;
			var clientEmail = document.getElementById("clientEmail").value;
			var roleId = document.getElementById("roleId").value;
			if(clientName==""){
				document.getElementById("name_notice").innerHTML="*请填写用户名称!";
				document.getElementById("clientName").focus();
				return 0;
			}
			if(clientPassword==""){
				document.getElementById("password_notice").innerHTML="*请填写用户密码!";
				document.getElementById("clientPassword").focus();
				return 0;
			}
			if(operatorId==""){
				document.getElementById("belong_notice").innerHTML="*请选择用户所属运营商!";
				document.getElementById("selectOperator").focus();
				return 0;
			}
		$.post("addClient.do", {
				operatorId : operatorId,
				clientName : clientName,
				clientPassword : clientPassword,
				clientPhone : clientPhone,
				clientEmail : clientEmail,
				roleId : roleId
			}, 
			function(data) {
				if (data == 1) {
					alert("终端用户添加成功!");
					window.location='searchClient.do?userId=<%=rb.getUserId()%>&page=1&roleName=<%=rb.getRoleName()%>';
				} else if (data == -1) {
					document.getElementById("name_notice").innerHTML = "*用户名称已存在,请重新填写!";
					document.getElementById("clientName").focus();
				} else {
					alert("终端用户添加失败!");
				}
			});
		}
</script> 
</body>
</html>
