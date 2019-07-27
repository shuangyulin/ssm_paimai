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
<title>帖子添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>PostInfo/frontlist">帖子列表</a></li>
			    	<li role="presentation" class="active"><a href="#postInfoAdd" aria-controls="postInfoAdd" role="tab" data-toggle="tab">添加帖子</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="postInfoList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="postInfoAdd"> 
				      	<form class="form-horizontal" name="postInfoAddForm" id="postInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="postInfo_pTitle" class="col-md-2 text-right">帖子标题:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="postInfo_pTitle" name="postInfo.pTitle" class="form-control" placeholder="请输入帖子标题">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="postInfo_content" class="col-md-2 text-right">帖子内容:</label>
						  	 <div class="col-md-8">
							    <textarea name="postInfo.content" id="postInfo_content" style="width:100%;height:500px;"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="postInfo_userObj_user_name" class="col-md-2 text-right">发帖人:</label>
						  	 <div class="col-md-8">
							    <select id="postInfo_userObj_user_name" name="postInfo.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="postInfo_addTimeDiv" class="col-md-2 text-right">发帖时间:</label>
						  	 <div class="col-md-8">
				                <div id="postInfo_addTimeDiv" class="input-group date postInfo_addTime col-md-12" data-link-field="postInfo_addTime">
				                    <input class="form-control" id="postInfo_addTime" name="postInfo.addTime" size="16" type="text" value="" placeholder="请选择发帖时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="postInfo_hitNum" class="col-md-2 text-right">浏览量:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="postInfo_hitNum" name="postInfo.hitNum" class="form-control" placeholder="请输入浏览量">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxPostInfoAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#postInfoAddForm .form-group {margin:10px;}  </style>
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var postInfo_content_editor = UE.getEditor('postInfo_content'); //帖子内容编辑器
var basePath = "<%=basePath%>";
	//提交添加帖子信息
	function ajaxPostInfoAdd() { 
		//提交之前先验证表单
		$("#postInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#postInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(postInfo_content_editor.getContent() == "") {
			alert('帖子内容不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "PostInfo/add",
			dataType : "json" , 
			data: new FormData($("#postInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#postInfoAddForm").find("input").val("");
					$("#postInfoAddForm").find("textarea").val("");
					postInfo_content_editor.setContent("");
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
	//验证帖子添加表单字段
	$('#postInfoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"postInfo.pTitle": {
				validators: {
					notEmpty: {
						message: "帖子标题不能为空",
					}
				}
			},
			"postInfo.addTime": {
				validators: {
					notEmpty: {
						message: "发帖时间不能为空",
					}
				}
			},
			"postInfo.hitNum": {
				validators: {
					notEmpty: {
						message: "浏览量不能为空",
					},
					integer: {
						message: "浏览量不正确"
					}
				}
			},
		}
	}); 
	//初始化发帖人下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#postInfo_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#postInfo_userObj_user_name").html(html);
    	}
	});
	//发帖时间组件
	$('#postInfo_addTimeDiv').datetimepicker({
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
		$('#postInfoAddForm').data('bootstrapValidator').updateStatus('postInfo.addTime', 'NOT_VALIDATED',null).validateField('postInfo.addTime');
	});
})
</script>
</body>
</html>
