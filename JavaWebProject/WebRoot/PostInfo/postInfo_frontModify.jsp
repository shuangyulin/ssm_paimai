<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.PostInfo" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    PostInfo postInfo = (PostInfo)request.getAttribute("postInfo");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改帖子信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">帖子信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="postInfoEditForm" id="postInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="postInfo_postInfoId_edit" class="col-md-3 text-right">帖子id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="postInfo_postInfoId_edit" name="postInfo.postInfoId" class="form-control" placeholder="请输入帖子id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="postInfo_pTitle_edit" class="col-md-3 text-right">帖子标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="postInfo_pTitle_edit" name="postInfo.pTitle" class="form-control" placeholder="请输入帖子标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="postInfo_content_edit" class="col-md-3 text-right">帖子内容:</label>
		  	 <div class="col-md-9">
			    <script name="postInfo.content" id="postInfo_content_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="postInfo_userObj_user_name_edit" class="col-md-3 text-right">发帖人:</label>
		  	 <div class="col-md-9">
			    <select id="postInfo_userObj_user_name_edit" name="postInfo.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="postInfo_addTime_edit" class="col-md-3 text-right">发帖时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date postInfo_addTime_edit col-md-12" data-link-field="postInfo_addTime_edit">
                    <input class="form-control" id="postInfo_addTime_edit" name="postInfo.addTime" size="16" type="text" value="" placeholder="请选择发帖时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="postInfo_hitNum_edit" class="col-md-3 text-right">浏览量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="postInfo_hitNum_edit" name="postInfo.hitNum" class="form-control" placeholder="请输入浏览量">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxPostInfoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#postInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
var postInfo_content_editor = UE.getEditor('postInfo_content_edit'); //帖子内容编辑框
var basePath = "<%=basePath%>";
/*弹出修改帖子界面并初始化数据*/
function postInfoEdit(postInfoId) {
  postInfo_content_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(postInfoId);
  });
}
 function ajaxModifyQuery(postInfoId) {
	$.ajax({
		url :  basePath + "PostInfo/" + postInfoId + "/update",
		type : "get",
		dataType: "json",
		success : function (postInfo, response, status) {
			if (postInfo) {
				$("#postInfo_postInfoId_edit").val(postInfo.postInfoId);
				$("#postInfo_pTitle_edit").val(postInfo.pTitle);
				postInfo_content_editor.setContent(postInfo.content, false);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#postInfo_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#postInfo_userObj_user_name_edit").html(html);
		        		$("#postInfo_userObj_user_name_edit").val(postInfo.userObjPri);
					}
				});
				$("#postInfo_addTime_edit").val(postInfo.addTime);
				$("#postInfo_hitNum_edit").val(postInfo.hitNum);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交帖子信息表单给服务器端修改*/
function ajaxPostInfoModify() {
	$.ajax({
		url :  basePath + "PostInfo/" + $("#postInfo_postInfoId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#postInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#postInfoQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*发帖时间组件*/
    $('.postInfo_addTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    postInfoEdit("<%=request.getParameter("postInfoId")%>");
 })
 </script> 
</body>
</html>

