<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>用户关注添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>UserFollow/frontlist">用户关注列表</a></li>
			    	<li role="presentation" class="active"><a href="#userFollowAdd" aria-controls="userFollowAdd" role="tab" data-toggle="tab">添加用户关注</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="userFollowList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="userFollowAdd"> 
				      	<form class="form-horizontal" name="userFollowAddForm" id="userFollowAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="userFollow_userObj1_user_name" class="col-md-2 text-right">被关注人:</label>
						  	 <div class="col-md-8">
							    <select id="userFollow_userObj1_user_name" name="userFollow.userObj1.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="userFollow_userObj2_user_name" class="col-md-2 text-right">关注人:</label>
						  	 <div class="col-md-8">
							    <select id="userFollow_userObj2_user_name" name="userFollow.userObj2.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="userFollow_followTimeDiv" class="col-md-2 text-right">关注时间:</label>
						  	 <div class="col-md-8">
				                <div id="userFollow_followTimeDiv" class="input-group date userFollow_followTime col-md-12" data-link-field="userFollow_followTime">
				                    <input class="form-control" id="userFollow_followTime" name="userFollow.followTime" size="16" type="text" value="" placeholder="请选择关注时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxUserFollowAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#userFollowAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加用户关注信息
	function ajaxUserFollowAdd() { 
		//提交之前先验证表单
		$("#userFollowAddForm").data('bootstrapValidator').validate();
		if(!$("#userFollowAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "UserFollow/add",
			dataType : "json" , 
			data: new FormData($("#userFollowAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#userFollowAddForm").find("input").val("");
					$("#userFollowAddForm").find("textarea").val("");
				} else {
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
	//验证用户关注添加表单字段
	$('#userFollowAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"userFollow.followTime": {
				validators: {
					notEmpty: {
						message: "关注时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化被关注人下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#userFollow_userObj1_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#userFollow_userObj1_user_name").html(html);
    	}
	});
	//初始化关注人下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#userFollow_userObj2_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#userFollow_userObj2_user_name").html(html);
    	}
	});
	//关注时间组件
	$('#userFollow_followTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#userFollowAddForm').data('bootstrapValidator').updateStatus('userFollow.followTime', 'NOT_VALIDATED',null).validateField('userFollow.followTime');
	});
})
</script>
</body>
</html>
