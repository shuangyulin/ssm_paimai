<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Item" %>
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
<title>竞拍订单添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>ProductBidding/frontlist">竞拍订单列表</a></li>
			    	<li role="presentation" class="active"><a href="#productBiddingAdd" aria-controls="productBiddingAdd" role="tab" data-toggle="tab">添加竞拍订单</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="productBiddingList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="productBiddingAdd"> 
				      	<form class="form-horizontal" name="productBiddingAddForm" id="productBiddingAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="productBidding_itemObj_itemId" class="col-md-2 text-right">竞拍商品:</label>
						  	 <div class="col-md-8">
							    <select id="productBidding_itemObj_itemId" name="productBidding.itemObj.itemId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="productBidding_userObj_user_name" class="col-md-2 text-right">竞拍用户:</label>
						  	 <div class="col-md-8">
							    <select id="productBidding_userObj_user_name" name="productBidding.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="productBidding_biddingTimeDiv" class="col-md-2 text-right">竞拍时间:</label>
						  	 <div class="col-md-8">
				                <div id="productBidding_biddingTimeDiv" class="input-group date productBidding_biddingTime col-md-12" data-link-field="productBidding_biddingTime">
				                    <input class="form-control" id="productBidding_biddingTime" name="productBidding.biddingTime" size="16" type="text" value="" placeholder="请选择竞拍时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="productBidding_biddingPrice" class="col-md-2 text-right">竞拍出价:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="productBidding_biddingPrice" name="productBidding.biddingPrice" class="form-control" placeholder="请输入竞拍出价">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxProductBiddingAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#productBiddingAddForm .form-group {margin:10px;}  </style>
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
	//提交添加竞拍订单信息
	function ajaxProductBiddingAdd() { 
		//提交之前先验证表单
		$("#productBiddingAddForm").data('bootstrapValidator').validate();
		if(!$("#productBiddingAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "ProductBidding/add",
			dataType : "json" , 
			data: new FormData($("#productBiddingAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#productBiddingAddForm").find("input").val("");
					$("#productBiddingAddForm").find("textarea").val("");
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
	//验证竞拍订单添加表单字段
	$('#productBiddingAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"productBidding.biddingTime": {
				validators: {
					notEmpty: {
						message: "竞拍时间不能为空",
					}
				}
			},
			"productBidding.biddingPrice": {
				validators: {
					notEmpty: {
						message: "竞拍出价不能为空",
					},
					numeric: {
						message: "竞拍出价不正确"
					}
				}
			},
		}
	}); 
	//初始化竞拍商品下拉框值 
	$.ajax({
		url: basePath + "Item/listAll",
		type: "get",
		success: function(items,response,status) { 
			$("#productBidding_itemObj_itemId").empty();
			var html="";
    		$(items).each(function(i,item){
    			html += "<option value='" + item.itemId + "'>" + item.pTitle + "</option>";
    		});
    		$("#productBidding_itemObj_itemId").html(html);
    	}
	});
	//初始化竞拍用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#productBidding_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#productBidding_userObj_user_name").html(html);
    	}
	});
	//竞拍时间组件
	$('#productBidding_biddingTimeDiv').datetimepicker({
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
		$('#productBiddingAddForm').data('bootstrapValidator').updateStatus('productBidding.biddingTime', 'NOT_VALIDATED',null).validateField('productBidding.biddingTime');
	});
})
</script>
</body>
</html>
