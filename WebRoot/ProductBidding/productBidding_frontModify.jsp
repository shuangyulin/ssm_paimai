<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.ProductBidding" %>
<%@ page import="com.chengxusheji.po.Item" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的itemObj信息
    List<Item> itemList = (List<Item>)request.getAttribute("itemList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    ProductBidding productBidding = (ProductBidding)request.getAttribute("productBidding");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改竞拍订单信息</TITLE>
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
  		<li class="active">竞拍订单信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="productBiddingEditForm" id="productBiddingEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="productBidding_biddingId_edit" class="col-md-3 text-right">订单编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="productBidding_biddingId_edit" name="productBidding.biddingId" class="form-control" placeholder="请输入订单编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="productBidding_itemObj_itemId_edit" class="col-md-3 text-right">竞拍商品:</label>
		  	 <div class="col-md-9">
			    <select id="productBidding_itemObj_itemId_edit" name="productBidding.itemObj.itemId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="productBidding_userObj_user_name_edit" class="col-md-3 text-right">竞拍用户:</label>
		  	 <div class="col-md-9">
			    <select id="productBidding_userObj_user_name_edit" name="productBidding.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="productBidding_biddingTime_edit" class="col-md-3 text-right">竞拍时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date productBidding_biddingTime_edit col-md-12" data-link-field="productBidding_biddingTime_edit">
                    <input class="form-control" id="productBidding_biddingTime_edit" name="productBidding.biddingTime" size="16" type="text" value="" placeholder="请选择竞拍时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="productBidding_biddingPrice_edit" class="col-md-3 text-right">竞拍出价:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="productBidding_biddingPrice_edit" name="productBidding.biddingPrice" class="form-control" placeholder="请输入竞拍出价">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxProductBiddingModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#productBiddingEditForm .form-group {margin-bottom:5px;}  </style>
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
<script>
var basePath = "<%=basePath%>";
/*弹出修改竞拍订单界面并初始化数据*/
function productBiddingEdit(biddingId) {
	$.ajax({
		url :  basePath + "ProductBidding/" + biddingId + "/update",
		type : "get",
		dataType: "json",
		success : function (productBidding, response, status) {
			if (productBidding) {
				$("#productBidding_biddingId_edit").val(productBidding.biddingId);
				$.ajax({
					url: basePath + "Item/listAll",
					type: "get",
					success: function(items,response,status) { 
						$("#productBidding_itemObj_itemId_edit").empty();
						var html="";
		        		$(items).each(function(i,item){
		        			html += "<option value='" + item.itemId + "'>" + item.pTitle + "</option>";
		        		});
		        		$("#productBidding_itemObj_itemId_edit").html(html);
		        		$("#productBidding_itemObj_itemId_edit").val(productBidding.itemObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#productBidding_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#productBidding_userObj_user_name_edit").html(html);
		        		$("#productBidding_userObj_user_name_edit").val(productBidding.userObjPri);
					}
				});
				$("#productBidding_biddingTime_edit").val(productBidding.biddingTime);
				$("#productBidding_biddingPrice_edit").val(productBidding.biddingPrice);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交竞拍订单信息表单给服务器端修改*/
function ajaxProductBiddingModify() {
	$.ajax({
		url :  basePath + "ProductBidding/" + $("#productBidding_biddingId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#productBiddingEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#productBiddingQueryForm").submit();
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
    /*竞拍时间组件*/
    $('.productBidding_biddingTime_edit').datetimepicker({
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
    productBiddingEdit("<%=request.getParameter("biddingId")%>");
 })
 </script> 
</body>
</html>

